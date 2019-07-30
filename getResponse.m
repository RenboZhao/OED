function response = getResponse(model,input,noiseStd)
% Generate noisy response (Gaussian noise)
% Input should a matrix, with each row representing an input instance.

disp('Generating response...');
[m,n] = size(input);
response = zeros(1,m);
for i = 1:m
    response(i) = model(input(i,:)) + randn*noiseStd;
end


end

