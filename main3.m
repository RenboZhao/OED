% Model: I.24.6: E = (1/4)*m*(omega^2+omega_0^2)*x^2
% Input: (m,omega,omega_0,x)
% Range of input:
% m: [0,1]; omega,omega_0: [0,pi]; x:[0,1]
% Output: E

clear; close all; clc;

%------------------------------------ Initial parameter distribution ----------------------------

% Five parameters: [c,e1,...,e4]
% e1: m; e2: omega; e3: omega_0; e4: x
% If uniform, then c in [0.1,0.5], and e_i in [0.5,2.5].
numCand = 3;
pM = 1/numCand*ones(1,numCand);         % Model prior
numParam = 5;
MuPrior{1} = [0.25,1,2,2,2]';              % Gaussian Prior
SigmaPrior{1} = eye(numParam);
MuPrior{2} = [0.65,1,1.15,0.65,1.8]';
SigmaPrior{2} = eye(numParam);
MuPrior{3} = [0.1,1,2,2,2]';
SigmaPrior{3} = eye(numParam);
% paramPdf = cell(1,3);
logpdf = cell(1,3);                             % To be used in HMC
for i = 1:numCand
    %paramPdf{i} = @(X) mvnpdf(X,MuPrior{i},SigmaPrior{i});   % Gaussian (X: n by d, d: dim)
    logpdf{i} = @(theta) getLogPrior(theta,'normal',MuPrior{i},SigmaPrior{i});
end

%------------------------------------ True and Candidate Models ---------------------------------------


% Ground-truth model: 0.25*m*(omega^2+omega_0^2)*x^2
% param = [c,e1,...,e4], input = [m,omega,omega_0,x]
numInput = 4;
model = @(input) 0.25*input(1)*(input(2)^2+input(3)^2)*input(4)^2;

% Candidate models
% Model 1: 0.25*m*(omega^2+omega_0^2)*x^2 (True model)
candModel{1} = @(param,input) param(1)*input(1)^param(2)*(input(2)^param(3)+input(3)^param(4))*input(4)^param(5);
% Model 2: 0.65*m*omega^1.15*omega_0^0.65*x^1.8
candModel{2} = @(param,input) param(1)*input(1)^param(2)*input(2)^param(3)*input(3)^param(4)*input(4)^param(5);
% Model 3: 0.1*m*(omega^2+x^2)*omega_0^2
candModel{3} = @(param,input) param(1)*input(1)^param(2)*(input(2)^param(3)+input(4)^param(5))*input(3)^param(4);

%------------------------------------ Experimental design ---------------------------------------

numRounds = 5;

for roundCtr = 1:numRounds
    
    fprintf('Round %d...\n',roundCtr);
    
    % Compute experiment point
    noiseVarHat = 1;
    bestThetaMAPCell = cell(1,numCand);
    for i = 1:numCand
        [bestThetaMAP,bestThetaMat]= findMaxHMC(logpdf{i},numParam,1);            % No numerical gradient
        %printVec(size(bestThetaMat,2));
        %bestThetaMAPCell{i} = bestThetaMat;                                      % Not used due to numerical instability
        bestThetaMAPCell{i} = bestThetaMAP;
    end
    selectionCrit = @(x) getSelectionCriterion(x,candModel,bestThetaMAPCell,noiseVarHat);
    option = optimoptions('fmincon','Display','off','Algorithm','sqp');
    xOpt = findMinFmincon(selectionCrit,numInput,option);
    
    
    % Generate response
    noiseVar = 1;
    y = model(xOpt) + randn*sqrt(noiseVar);
        
    % Update prior to posterior
    logpdf = getLogPosterior(xOpt,y,candModel,noiseVar,logpdf);
end

