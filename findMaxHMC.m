function [bestThetaMAP,bestThetaMat] = findMaxHMC(logpdf,numParam,useNumGrad)

% Returns several local maxima. 

numStarts = 10;
bestThetaMat = zeros(numParam,numStarts);
maxPdfVal = -Inf;
for j = 1:numStarts
    startPt = rand(numParam,1);
    HMC = hmcSampler(logpdf,startPt,'UseNumericalGradient',useNumGrad);
    ThetaMAP = estimateMAP(HMC);
    bestThetaMat(:,j) = ThetaMAP;
    pdfVal = logpdf(ThetaMAP);
    if  pdfVal > maxPdfVal
        maxPdfVal = pdfVal;
        bestThetaMAP = ThetaMAP;
    end
end

bestThetaMat = unique(bestThetaMat','rows')';


end

