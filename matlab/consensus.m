function con = consensus(D, kind, nshuff, gamma, seed)
% consensus  Calculates the consensus matrix after applying 
%            k-medoids with a partition configuration into 
%            a set of distance matrices.
%
%   con = consensus(D) Calculates the consensus matrix for D 
%         in a default partition kind= [2:20], 
%         with 1000 permutations to simulate the null ensemble. 
%
%   con = consensus(D,kind) Calculates the consensus matrix for D 
%         in a supplied partition configuration kind,
%         with 1000 permutations to simulate the null ensemble. 
%
%   con = consensus(D,kind, nshuff) Calculates the consensus matrix for D 
%         in a supplied partition configuration kind,
%         with nshuff permutations to simulate the null ensemble. 
%
%   con = consensus(D,kind, nshuff) Calculates the consensus matrix for D 
%         in a supplied partition configuration kind,
%         with nshuff permutations to simulate the null ensemble
%         and fix the resolution of the null ensamble at gamma
%
%   con = consensus(D, kind, nshuff, seed) Calculates the consensus matrix for D 
%         in a supplied partition configuration kind,
%         with nshuff permutations to simulate the null ensemble,
%         fixing the resolution of the null ensamble at gamma
%         and setting the seed for the results to be reproducible
%
%   More details, please have a look into:
%       Rasero, J., Pellicoro, M., Angelini, L., Cortes, 
%       J. M., Marinazzo% D., & Stramaglia, S. (2017). 
%       Consensus clustering approach to group brain connectivity matrices.
%       Network Neuroscience, 1(3), 242–253.
%       https://doi.org/10.1162/netn_a_00017



if isempty(D)
	error('D must be provided')
end

if not(size(D,3))
    error('D must be an array of distance matrices')
end

if (nargin < 2) || isempty(kind)
	kind=[2:20];
end

if  (nargin < 3) || isempty(nshuff)
	nshuff=1000;
end

if  (nargin < 4) || isempty(gamma)
	gamma=1;
end

if  (nargin == 5)
	rng(seed);
end


m = size(D, 1);
n = size(D, 3);
nk=length(kind);
c=zeros(m,nk,n);
A=logical(zeros(m,m,nk,n));

% matrix of null ensemble
P=zeros(m,m,nk,n);

for i=1:n
    tic
    for k=1:nk
	  kk=kind(k);
	  c(:,k,i) = kmedoids(double(D(:,:,i)),kk);
	  for l=1:m
	      for j=l+1:m
	          A(l,j,k,i)=c(l,k,i)==c(j,k,i);
	          A(j,l,k,i)=A(l,j,k,i);
	      end
      end
      
      % shuffling to simulate the null ensemble
      if gamma>0
          for ns=1:nshuff
              randSub=randperm(m);
              cRand = c(randSub,k,i);
              for l=1:m
                 for j=l+1:m
                      P(l,j,k,i)= P(l,j,k,i) + (cRand(l)==cRand(j));
                      P(j,l,k,i)= P(l,j,k,i);
                 end
              end    
          end
      P(:,:,k,i) = P(:,:,k,i)/nshuff;
      end
    end
    disp(strcat('finished node = ', num2str(i)))
    toc
end

con = mean(squeeze(mean(A, 3)),3) - gamma*mean(squeeze(mean(P, 3)),3);
end
