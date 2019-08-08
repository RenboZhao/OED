function xOpt = findMinFmincon(f,numInput,option)

numStarts = 1;
minVal = Inf;
for j = 1:numStarts
    startPt = ones(numInput,1);
    % Minimize selection crit st. x >= LB (-x <= -LB)
    LB = 0.5;
    [x,fVal] = fmincon(f,startPt,-eye(numInput),-LB*ones(numInput,1),[],[],[],[],[],option);    
    if  fVal < minVal
        minVal = fVal;
        xOpt = x;
    end
end

end

