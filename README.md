# Consensus clustering approach to group brain connectivity matrices

![](https://github.com/jrasero/consensus/blob/master/docs/github.png)

Code to calculate the consensus matrix from a set of distance matrices using k-medoids as described in

Consensus clustering approach to group brain connectivity matrices. J.Rasero, Mario Pellicoro, Leonardo Angelini, Jesus M. Cortes, Daniele Marinazzo and Sebastiano Stramaglia. [https://arxiv.org/abs/1612.03760](https://arxiv.org/abs/1612.03760).

The folder contains the code written in R and MATLAB. In both, the function *consensus* is defined and takes as input variables a set of distance matrices and a given partition configuration to be used by k-medoids clusterig algorithm. Kmedoids function is also included in the MATLAB version to be add to your path, whereas its R version is implemented by [cluster](https://cran.r-project.org/web/packages/cluster/index.html), required when running the code along with few other packages. More details can be found in the documetation attached to both codes.

Please do not hesitate to contact us for suggestions and remarks to jrasero.daparte@gmail.com
