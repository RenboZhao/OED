function xOpt = findMinFmincon(f,numInput,option)

numStarts = 10;
minVal = Inf;
for j = 1:numStarts
    startPt = rand(numInput,1);
    % Minimize selection crit st. x >= 0
    [x,fVal] = fmincon(f,startPt,-eye(numInput),zeros(numInput,1),[],[],[],[],[],option);    
    if  fVal < minVal
        minVal = fVal;
        xOpt = x;
    end
end

end

