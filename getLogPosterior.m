function candModel = getLogPosterior(x,y,candModel,noiseVar)

numCand = length(candModel);
for i = 1:numCand
    model = candModel{i}.func;
    logLik = @(theta) -(y-model(theta,x))^2/(2*noiseVar);
    candModel{i}.logpdf = @(theta) candModel{i}.logpdf(theta) + logLik(theta);  % prior -> posterior
end

end

