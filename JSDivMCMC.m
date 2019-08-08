function div = JSDivMCMC(distCell,weightVec,varDim)
% weightVec: row vector
% Compute the J-S divergence among n distributions, with weights specified in weightVec. 

pNom = @(x) 0;
numDist = length(distCell);
for i = 1:numDist
    pNom = @(x) pNom(x) + weightVec(i)*distCell{i}(x);
end

divVec = cellfun(@(p) KLDivMCMC(p,pNom,varDim),distCell,'un',1);
div = dot(weightVec,divVec);
    
% div = @(x) 0;
% for i = 1:length(divVec)
%     div = @(x) div(x) + weightVec(i)*divVec{i}(x);
% end

end

