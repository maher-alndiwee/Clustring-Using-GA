close all
clear
clc
for seed=1:20
%seed=1;
rng(seed);

global numberOfRecords numberOfFeatures numberOfClusters records numberOfCalls numOfTrueIterations
numberOfCalls=0;
datasets= {'wdbcancer-dataset_Norm','glass-dataset_Norm','vowel-dataset_Norm','cmcDataset_Norm'};
for ds=1:numel(datasets)
    load(datasets{ds})
numberOfClusters=sum(numel(unique(records(:,end))));
classes= records(:,end);
records(:,end)=[];
numberOfRecords=size(records,1);
numberOfFeatures=size(records,2);

numberOfSolutions=50;
dimensionOfSolution=numberOfFeatures*numberOfClusters;
lowerBounds=repmat(min(records),1,numberOfClusters);
higherBounds=repmat(max(records),1,numberOfClusters);
numberOfIterations=10000;
tic;
options=gaoptimset('PlotFcns', @gaplotbestf,'Generations',numberOfIterations,'PopulationSize',numberOfSolutions,'StallGenLimit',5,'TolFun',1e-6);
[chrom,minVal,flag,gaoutput] = ga(@ObjectiveFunction,dimensionOfSolution,[],[],[],[],lowerBounds,higherBounds,[],[],options);
Time = toc;
centers = reshape(chrom,numberOfClusters,numberOfFeatures);
[mn clus]= min(pdist2(centers,records));  %finding the cluster of every point
clustersindx = unique(clus);     % finding the unique clusters ids
output = zeros(numberOfRecords,1);
for i =1:numel(clustersindx)     % finding the suitable class for every cluster
    clusterElementsIndices = find(clus == clustersindx(i));  % finds the indx of the elements of current cluster  
    classesOfElements = classes(clusterElementsIndices);   
    [numOfRepeats,class]= hist(classesOfElements,unique(classesOfElements));
    [nn classindx] = max(numOfRepeats);    % find the class with the maximum number of cluster's elements
    output(clusterElementsIndices)=class(classindx); %set the output of the cluster's elements to the correct class
end
numberOfCalls=gaoutput.funccount
numOfTrueIterations=gaoutput.generations
seed
ds
save(['seed results/GA-Seed' num2str(seed) '-'  datasets{ds}])
Accur(seed,ds)= Accuracy(classes,output);
end
end
save('seed results/GA-Accuracy.mat','Accur')
save('seed results/GA-Accuracy.xls','Accur','-ascii')
