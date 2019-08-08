function crit = getSelCritLogDet(x,candModel,noiseVar)

% x: input vector 

numCand = length(candModel);
vec = [];
bestThetaMAPCell = getThetaMAP(candModel);
for i = 1:numCand
    thetaMat = bestThetaMAPCell{i};
    for j = 1:size(thetaMat,2)
        vec = [vec,candModel{i}.func(bestThetaMAPCell{i}(:,j),x)];
    end
end

mat = ((vec').^2 + vec.^2 - 2*(vec'*vec))/(2*noiseVar);
%disp(size(mat));

crit = -log(det(mat));                  % To be minimized

end

function  bestThetaMAPCell = getThetaMAP(candModel)

numCand = length(candModel);
bestThetaMAPCell = cell(1,numCand);
for i = 1:numCand
    [bestThetaMAP,~]= findMaxHMC(candModel{i}.logpdf,candModel{i}.numParam,1);  % No numerical gradient
    %sampleMat = sampleHMC(logpdf{i},numParam,numSample,1);                     % numParam x numSample
    %printVec(size(bestThetaMat,2));
    %bestThetaMAPCell{i} = sampleMat;                                           % Not used due to numerical instability
    bestThetaMAPCell{i} = bestThetaMAP;
end

end
