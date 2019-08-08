function sampleMat = sampleHMC(logpdf,numParam,numSample,useNumGrad)

% sampleMat: numParam x numSample 

burnin = 1000;
startPt = randn(numParam,1);
HMC = hmcSampler(logpdf,startPt,'UseNumericalGradient',useNumGrad);
%HMC = tuneSampler(HMC);
sampleMat = drawSamples(HMC,'Burnin',burnin,'StartPoint',startPt,'NumSamples',numSample);
sampleMat  = sampleMat';

end

