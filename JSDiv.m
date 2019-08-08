function div = JSDiv(distArray,weightVec,type)
% Type: 'd' or 'c'
% weightVec: row vector

nDist = size(distArray,1);
if type == 'd'
    pNom = squeeze(weightVec'.*distArray);      % Nominal distribution 
    distCell = mat2cell(distArray,ones(1,nDist));
    divs = cellfun(@(p) KLDiv(p,pNom,'d'),distCell);
    div = dot(divs,weightVec);
end



end

