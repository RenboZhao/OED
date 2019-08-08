function div = JSDivUMCMC(distCell,weightVec,varDim)
% weightVec: row vector
% Compute the weighted KL divergence among n distributions, with weights specified in weightVec. 

div = 0;
numDist = length(distCell);
for i = 1:numDist
    for j = 1:numDist
        div = div + weightVec(i)*weightVec(j)*KLDivMCMC(distCell{i},distCell{j},varDim);
    end
end


    
end

