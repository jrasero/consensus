function [label, energy, index,nc it] = kmedoids(X,k,dist)
% X:    n x n matrix distance  if dist=0
%       d x n data matrix if dist>0
% k:    number of cluster
%dist:  parameter of minkowski distance if d>0
if nargin<3
    dist=0;
end
[d n] = size(X);
if dist==0
    if d ~= n
        error('distance matrix must be square');
    end
    D=X;
else
    D=squareform(pdist(X','minkowski',dist).^2);
end
energy=inf;
niter=100;
for i=1:niter;
    ind=randsample(n,k);
    [val, lab] = min(D(ind,:),[],1);
    last = 0;
    while any(lab ~= last)
        [~, ind] = min(D*sparse(1:n,lab,1,n,k,n),[],1);
        last = lab;
        [val, lab] = min(D(ind,:),[],1);
    end
    en(i) = sum(val);
    if en(i)<energy
        energy=en(i);
        label=lab;
        index=ind;
        it=i;
    end
end
for i=1:k
    ipo{i}=find(label==i);
    ncc(i)=length(ipo{i});
end
[nc ip]=sort(ncc,'descend');
for i=1:k
    label(ipo{i})=i;
end