function crit = getSelCritJSDivU(x,candModel,pM,noiseVar)

numCand = length(candModel);
predDist = cell(1,numCand);             % For response vars
numSample = 2;
for i = 1:numCand
    sampleMat = sampleHMC(candModel{i}.logpdf,candModel{i}.numParam,numSample,1);       % Param samples
    sampleCell = num2cell(sampleMat,1);
    respMeanVec = cellfun(@(theta) candModel{i}.func(theta,x),sampleCell); % + randn(1,numSample)*sqrt(noiseVar);
    predDist{i} = getPredDist(respMeanVec,noiseVar);
%     pd = fitdist(responseMat','Kernel','Kernel','normal');       % KDE
%     predDist{i} = @(y) pdf(pd,y);                                % Function handle
end

crit = -JSDivUMCMC(predDist,pM,1);                                % Univariate response; maximize JS div

end

