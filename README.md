# Consensus clustering approach to group brain connectivity matrices

<p align="center">
  <img src="https://github.com/jrasero/consensus/blob/master/docs/github.png">
</p>

Toolbox that calculates the consensus/modularity matrix from a set of distance matrices using k-medoids as described in
*Consensus clustering approach to group brain connectivity matrices*. J.Rasero, Mario Pellicoro, Leonardo Angelini, Jesus M. Cortes, Daniele Marinazzo and Sebastiano Stramaglia. [https://doi.org/10.1162/NETN_a_00017](https://doi.org/10.1162/NETN_a_00017).

The folder *matlab* contains the toolbox in MATLAB. It consists of the function **_consensus_**, which calculates the consensus/modularity matrix from a set of distance matrices at different resolutions. **_Kmedoids_** function is also included in the MATLAB file version to be add to your path. More details can be found in the documentation attached. It also contains a toy example with the output shown below:

<p align="center">
  <img src="https://github.com/jrasero/consensus/blob/master/matlab/toy_model.png">
</p>

The *R* version is now also available. It consists of the function **consensus** and the requirements are the ***cluster***, ***graphAT*** and ***foreach*** libraries. The requirement of usage of these libraries might change in the future.

Please do not hesitate to contact us for suggestions and remarks to jrasero.daparte@gmail.com
