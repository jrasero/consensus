\name{consensus}
\alias{consensus}
\alias{consensus}
\title{
	Calculates a consensus matrix on distance matrices
}
\description{
	\code{consensus} calculates the consensus matrix after applying 
	k-medoids with a partition configuration (i.e. the set of 
	k-paramaters to be used by the algorithm) into 
	a set of distance matrices
}
\usage{consensus(distMats, nk = seq(2, 20, 1), 
          n.shuffle=1000, par = F, ncores=1, gamma=1, 
          seed=NULL)}
\arguments{
	\item{distMats}{
		A list of n x n matrices, where n is the total number of subjects 
		and each entry in the matrix represents the distance among subjects.
	}
	\item{nk}{
		Set of values of k to be used by k-medoids on each matrix
	}
	\item{n.shuffle}{
	number of shufflings permutations to compute the null ensemble
	}
	\item{par}{
		Logical: should parallelization be used? \code{doParallel} package is required
    }
	\item{ncores}{
		Integer: If parallel is true, number of cores to be used 
    }
  \item{gamma}{
  resolution parameter of the null ensemble. 
  }
  \item{seed}{
  seed to make calculations reproducible
  }

}
\details{

}
\value{
    A modularity n x n matrix
}
\author{
    Javier Rasero \email{jrasero.daparte@gmail.com}.
    Daniele Marinazzo.
    Sebastiano Stramaglia.
}
