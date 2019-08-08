function pdf = KDE(responseMat)

pdf = @(theta) 0;
[numParam,numSamples] = size(responseMat);
for i = 1:numSamples
    pdf = @(theta) pdf(theta) + mvnpdf(theta,responseMat(:,i),eye(numParam));    % N(theta_i,I)
end


end

