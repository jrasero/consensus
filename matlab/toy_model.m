%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Toy model example to show how the consensus clustering
% works. We have considered 2 groups of 50 subjects, all 
% having 10 brain nodes. 2 out of these bring information 
% about the group structure, whereas the rest don't.
%
% This is a simplified example of the toy model in
% Rasero, J., Pellicoro, M., Angelini, L., Cortes, 
% J. M., Marinazzo% D., & Stramaglia, S. (2017). 
% Consensus clustering approach to group brain connectivity matrices.
% Network Neuroscience, 1(3), 242–253.
%https://doi.org/10.1162/netn_a_00017


%Number of total subjects
subjects =100;
%Number of total nodes
nodes = 10;
%Number of informative nodes
inf_nodes = 2;

% Array of distance matrices
D = zeros(subjects, subjects, nodes);

D(1:50, 1:50, 1:inf_nodes) =  0.1 + 0.3*rand([50, 50, inf_nodes]);
D(51:subjects, 51:subjects, 1:inf_nodes) =  0.1 + 0.3*rand([50, 50, inf_nodes]);
D(1:50, 51:subjects, 1:inf_nodes) =  0.2 + 0.2*rand([50, 50, inf_nodes]);
D(51:subjects, 1:50, 1:inf_nodes) =  D(1:50, 51:subjects, 1:inf_nodes);

D(:, :, (inf_nodes+1):nodes) = 0.2 + 0.2*rand([subjects, subjects, nodes-inf_nodes]);

for i=1:nodes
    for j=1:subjects
        D(j,j,i) = 0;
    end
end

figure;
subplot(2,2,1)
imagesc(squeeze(D(:,:,1)))
title({'Distance matrix', 'informative node'},'FontSize',25)
xlabel('subjects (i)', 'FontSize',15, 'FontWeight', 'bold')
ylabel('subjects (j)', 'FontSize',15, 'FontWeight', 'bold')
colorbar()

subplot(2,2,2)
imagesc(squeeze(D(:,:,4)))
title({'Distance matrix', 'no informative node'},'FontSize',25)
xlabel('subjects (i)', 'FontSize',15, 'FontWeight', 'bold')
ylabel('subjects (j)', 'FontSize',15, 'FontWeight', 'bold')
colorbar()


C=consensus(D,[],[],0,0);

subplot(2,2,3)
imagesc(C)
title('Consensus matrix','FontSize',25)
xlabel('subjects (i)', 'FontSize',15, 'FontWeight', 'bold')
ylabel('subjects (j)', 'FontSize',15, 'FontWeight', 'bold')
colorbar()


B=consensus(D,[],[],[],0);

subplot(2,2,4)
imagesc(B)
title('Modularity matrix','FontSize',25)
xlabel('subjects (i)', 'FontSize',15, 'FontWeight', 'bold')
ylabel('subjects (j)', 'FontSize',15, 'FontWeight', 'bold')
colorbar()
