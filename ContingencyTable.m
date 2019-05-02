function [nij_i,nij,ni,mj,nijCnr,niCnr,mjCnr] = ContingencyTable(numberOfGroundTruth,target,output)

numberOfClusters = max(output);

nij = zeros(numberOfClusters,numberOfGroundTruth);      % The number of data point  in common between classes (GroundTruth) and clusters
nijCnr = zeros(numberOfClusters,numberOfGroundTruth);
niCnr = zeros(1,numberOfGroundTruth);                   % The number of combinations for ni (rows of table)
mjCnr = zeros(1,numberOfClusters);                      % The number of combinations for mj (columns of table)

for i = 1:numberOfClusters
    t = target(output==i);
    for j = 1:numberOfGroundTruth
        nij(i,j) = length(find(t == j));
        
        if nij(i,j) < 2
            nijCnr(i,j) = 0;
        else
            nijCnr(i,j) = nchoosek(nij(i,j),2);
        end
    end
end
    
nij_i = max(nij,[],2);      % The maximum number of data point in Cluster 'Ci' 

ni = sum(nij,2);            % Number of data point in  each cluster "Ci"
mj = sum(nij,1);            % Number of data point in each class "Tj"


% Computing the combinations for ni
for i = 1: numberOfClusters
    if ni(i) < 2
        niCnr(i) = 0;
    else
        niCnr(i) = nchoosek(ni(i),2);
    end
end

% Computing the combinations for mj
for j = 1:numberOfGroundTruth
    if mj(j) < 2
        mjCnr(j) = 0;
    else
        mjCnr(j) = nchoosek(mj(j),2);
    end
end

end