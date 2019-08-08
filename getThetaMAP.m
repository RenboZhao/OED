function  bestThetaMAPCell = getThetaMAP(logpdf,numParam)

numCand = length(logpdf);
bestThetaMAPCell = cell(1,numCand);
for i = 1:numCand
    [bestThetaMAP,~]= findMaxHMC(logpdf{i},numParam(i),1);          % No numerical gradient
    %sampleMat = sampleHMC(logpdf{i},numParam,numSample,1);                     % numParam x numSample
    %printVec(size(bestThetaMat,2));
    %bestThetaMAPCell{i} = sampleMat;                                           % Not used due to numerical instability
    bestThetaMAPCell{i} = bestThetaMAP;
end

end