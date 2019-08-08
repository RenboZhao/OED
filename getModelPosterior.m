function pM = getModelPosterior(x,y,candModel,pM,noiseVar)

% (x,y): observed data

numCand = length(candModel);
modelLik = ones(1,numCand);
numSample = 1000;
for i = 1:numCand
    model = candModel{i}.func;
    f = @(theta) 1/sqrt(2*pi*noiseVar)*exp(-(y-model(theta,x))^2/(2*noiseVar));       % p((x,y)|theta,M)
    sampleMat = sampleHMC(candModel{i}.logpdf,candModel{i}.numParam,numSample,1);     % sampleMat: numParam x numSample
    sampleCell = num2cell(sampleMat,1);     % Each column forms a cell
    f_x = cellfun(f,sampleCell);
    modelLik(i) = max(eps,mean(f_x));                   % p((x,y)|M)
end

pM = pM.*modelLik/sum(pM.*modelLik);


end

