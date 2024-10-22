
% Model: I.24.6: E = (1/4)*m*(omega^2+omega_0^2)*x^2
% Input: (m,omega,omega_0,x)
% Range of input:
% m: [0,1]; omega,omega_0: [0,pi]; x:[0,1]
% Output: E

clear; close all; clc;

%------------------------------------ True and Candidate Models ---------------------------------------

% Ground-truth model: 0.25*m*(omega^2+omega_0^2)*x^2
% param = [c,e1,...,e4], input = [m,omega,omega_0,x]
model = @(input) 0.25*input(1)*(input(2)^2+input(3)^2)*input(4)^2;

% Candidate models
numCand = 3;
numInput = 4;
% Model 1: 0.25*m*(omega^2+omega_0^2)*x^2 (True model)
candModel{1}.func = @(param,input) param(1)*input(1)^param(2)*(input(2)^param(3)+input(3)^param(4))*input(4)^param(5);
candModel{1}.numParam = 5;
% Model 2: 0.65*m*omega^1.15*omega_0^0.65*x^1.8
candModel{2}.func = @(param,input) param(1)*input(1)^param(2)*input(2)^param(3)*input(3)^param(4)*input(4)^param(5);
candModel{2}.numParam = 5;
% Model 3: 0.1*m*(omega^2+x^2)*omega_0^2
candModel{3}.func = @(param,input) param(1)*input(1)^param(2)*(input(2)^param(3)+input(4)^param(5))*input(3)^param(4);
candModel{3}.numParam = 5;


%------------------------------------ Initial parameter distribution ----------------------------
% Five parameters: [c,e1,...,e4]
% e1: m; e2: omega; e3: omega_0; e4: x
pM = 1/numCand*ones(1,numCand);            % Model prior
MuPrior{1} = [0.25,1,2,2,2]';              % Gaussian Prior
SigmaPrior{1} = eye(candModel{1}.numParam);
MuPrior{2} = [0.65,1,1.15,0.65,1.8]';
SigmaPrior{2} = eye(candModel{2}.numParam);
MuPrior{3} = [0.1,1,2,2,2]';
SigmaPrior{3} = eye(candModel{3}.numParam);
for i = 1:numCand
    candModel{i}.logpdf = @(theta) getLogPrior(theta,'normal',MuPrior{i},SigmaPrior{i});
end

%------------------------------------ Experimental design ---------------------------------------

numRounds = 1;
numSample = 10;
for roundCtr = 1:numRounds
    
    fprintf('Round %d...\n',roundCtr);
    
    % Compute experiment point    
    noiseVar = 1e-2;
    noiseVarHat = noiseVar;
    %selectionCrit = @(x) getSelCritLogDet(x,candModel,noiseVarHat);
    selectionCrit = @(x) getSelCritJSDiv(x,candModel,pM,noiseVarHat);
    option = optimoptions('fmincon','Display','iter','Algorithm','sqp','OptimalityTolerance',1e-3);
    xOpt = findMinFmincon(selectionCrit,numInput,option);
%    xOpt = rand(1,4);
    
    % Generate response
    y = model(xOpt) + randn*sqrt(noiseVar);
    
    % Update posterior over models
    pM = getModelPosterior(xOpt,y,candModel,pM,noiseVarHat);
    disp(pM);
    
    % Update posterior of parameters in each model
    candModel = getLogPosterior(xOpt,y,candModel,noiseVar);
   
end

