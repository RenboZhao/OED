function logPost = getLogPosterior(x,y,candModel,noiseVar,logPrior)

numCand = length(logPrior);
logPost = cell(1,numCand);
for i = 1:numCand
    model = candModel{i};
    logLik = @(theta) -(y-model(theta,x))^2/(2*noiseVar);
    logPost{i} = @(theta) logPrior{i}(theta) + logLik(theta);
end

end

