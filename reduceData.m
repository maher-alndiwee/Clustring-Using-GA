function [ Reduced ] = reduceData( DataSet,percentage)
%this function takes data set and down sample it whith keeping the
%percentage of each class aproximatly fixed 
%% input:
%DataSet : the oreginal dataSet to be reduced
%percentage: the percentage of data wanted to be extracted 

%% output:
%Reduced: the reduced DataSet 
%   Detailed explanation goes here
classes = DataSet(:,end);
uclasses = unique(classes);
for i =1:length(uclasses)
indices{i} = find(classes ==uclasses(i));  % find the indices for all class's samples
portion{i} = ceil(numel(indices{i})*percentage);  % the number of element wich should be sampled for each calss
end
data =[];
for i =1:length(uclasses)
    if (numel(indices{i})==1)
        x = DataSet(indices{i},:);
    else
    try
        x=datasample(DataSet(indices{i},:),portion{i});
    catch
        x=[];
    end
    end
 data= [data ;x]; % colect sampeld data from each calss in one array 
end  
rndindx = randperm(size(data,1));  % randomize indices
Reduced = data(rndindx,:);
     

end

