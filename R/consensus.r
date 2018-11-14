consensus<-function(distMats, nk = seq(2, 20, 1), n.shuffle=1000, 
                    par = F, ncores=1, gamma=1, seed=NULL)
  {
  
  if(missing(distMats) | length(distMats)==0 | !is.list(distMats))
    stop("need to supply a list of distance matrices")
  if(!require(cluster))
    stop("cluster package needs to be installed")
  if(!require(GraphAT))
    stop("GraphAT package needs to be installed")
  if(!require(foreach))
    stop("foreach package needs to be installed")

  if(par){
    if(!require(doParallel))
      stop("you have set the parallel option but doParallel package needs to be loaded")
    registerDoParallel(cores = ncores)
  }
  
  if(!is.null(seed))
    set.seed(seed)
  #number of SUBSET of features from which distance matrices are calculated
  nNodes<-length(distMats)
  #number of subjects
  nSub<-nrow(distMats[[1]])
  
  listCP.node<-foreach(iclus=nk, .packages = c("cluster", "GraphAT")) %dopar%{
    
    #empty consensus matrix for each partition
    C<-matrix(rep(0, nSub*nSub), nrow = nSub)
    #randomly permuted configuration matrix
    P<-matrix(rep(0,nSub*nSub), nrow = nSub)
    #average on nodes
    for(i in c(1:nNodes)){
      
      regioneMat<-distMats[[i]]
      
      clusIndex<-pam(regioneMat, k = iclus, diss = T)$clustering
      
      #adjacency matrix from clustering members
      adjMat<-clust2Mat(clusIndex)
      C<- C + adjMat
    
      for(shuff in c(1:n.shuffle)){
        
        randInd<-sample(c(1:nSub))
        P<-P + adjMat[randInd, randInd] 
        
      }
    }
    message("consensus with k = ", iclus, " finished ")  
    
    list(as.matrix(C/nNodes), P/(nNodes*n.shuffle))
  }

  C.list<-lapply(listCP.node, function(x) x[[1]])
  P.list<-lapply(listCP.node, function(x) x[[2]])
  
  C<-Reduce("+", C.list)/length(C.list)
  P<-Reduce("+", P.list)/length(P.list)
  B<-C-gamma*P
  return(B)
}
