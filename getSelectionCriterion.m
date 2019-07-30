function crit = getSelectionCriterion(x,candModel,bestThetaMAPCell,noiseVar)

% x: input vector 

numCand = length(candModel);
vec = [];
for i = 1:numCand
    thetaMat = bestThetaMAPCell{i};
    for j = 1:size(thetaMat,2)
        vec = [vec,candModel{i}(bestThetaMAPCell{i}(:,j),x)];
    end
end

mat = ((vec').^2 + vec.^2 - 2*(vec'*vec))/(2*noiseVar);
%disp(size(mat));

crit = -log(det(mat));                  % To be minimized

end

