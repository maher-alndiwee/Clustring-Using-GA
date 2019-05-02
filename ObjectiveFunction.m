function costVal=ObjectiveFunction(solution)

global numberOfFeatures numberOfClusters records numberOfCalls

centers=zeros(numberOfClusters,numberOfFeatures);
for i=1:numberOfClusters
    centers(i,:)=solution((i-1)*numberOfFeatures+1:i*numberOfFeatures);
end

dist=pdist2(records,centers);
costVal=sum(min(dist,[],2));
numberOfCalls=numberOfCalls+1;
end