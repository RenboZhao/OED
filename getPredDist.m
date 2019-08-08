function dist = getPredDist(respMeanVec,noiseVar)

dist = @(y) 0;
numSamp = length(respMeanVec);
for i = 1:numSamp
    dist = @(y) dist(y) + (1/numSamp)*normpdf(y,respMeanVec(i),sqrt(noiseVar));
end

end
