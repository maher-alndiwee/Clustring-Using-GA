% Accuracy  is pairwise external measure for clustering analysis
% this function implemented depending on (TP,FP,TN,FN) truth assignment
function  accuracy = Accuracy(targets,outputs)

% TP : is True Positive assignment
% FN : is False Negative assignment
% FP : is False Positive assignment
% TN : is True Negative assignment
numberOfClasses= numel(unique(targets));
n = length(targets); % Number of records

nCnr = nchoosek(n,2); % This parameter is 'N=C(n,2)'

Beta = 1 ;  % weight to penalize false negatives more strongly than false positives
[nij_i,nij,ni,mj,nijCnr,niCnr,mjCnr] = ContingencyTable(numberOfClasses,targets,outputs);

sumNijCnr = sum(sum(nijCnr)); % True Positive  'TP'
sumMjCnr = sum(mjCnr);
sumNiCnr = sum(niCnr);

% Four possibilities for Truth Assignment
TP =  sumNijCnr;
% Also we can re-write TP as :
% TP = 0.5 *( (sum(sum(nij.^2))) - n );
FN =  sumMjCnr - TP;
FP = sumNiCnr - TP ;
TN = nCnr - ( TP + FN + FP );
% Accuracy
accuracy = (TP+TN)/(TP+FP+TN+FN);
end