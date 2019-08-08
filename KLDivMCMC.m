function div = KLDivMCMC(p,q,varDim)
% p,q: density functions
% varDim: number of variables 

logp = @(x) log(p(x));
epsilon = 1e-3;
f = @(x) log(p(x)/max(epsilon,q(x)));
numSample = 1000;
sampleMat = sampleHMC(logp,varDim,numSample,1);                                   % sampleMat: numParam x numSample
sampleCell = num2cell(sampleMat,1);              % Each column forms a cell
f_x = cellfun(f,sampleCell);
div = mean(f_x);                                                                  % Ergodic thoerem



end

