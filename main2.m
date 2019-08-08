% Model: I.24.6: E = (1/4)*m*(omega^2+omega_0^2)*x^2
% Input: (m,omega,omega_0,x)
% Range of input: 
% m: [0,1]; omega,omega_0: [0,pi]; x:[0,1]
% Output: E

clear; close all; clc;

% Ground-truth model
model = @(m,omega,omega_0,x) (1/4)*m*(omega^2+omega_0^2)*x^2;

% Candidate models
numCand = 3;
cand{1} = model;
cand{2} = @(m,omega,omega_0,x) 0.65*m*omega^1.15*omega_0^0.65*x^1.8;
cand{3} = @(m,omega,omega_0,x) 0.1*m*(omega^2+omega^2)*omega_0^2;


% Discritize input space
% hInput = 0.1;
% inputSpace{1} = 0:hInput:1;              % m
% inputSpace{2} = 0:hInput:3.2;            % omega
% inputSpace{3} = inputSpace{2};           % omega_0
% inputSpace{4} = 0:hInput:1;              % x


% Initial parameter distribution 
% Five parameters: [c,e_1,...,e_4]
% e_1: m; e_2: omega; e_3: omega_0; e_4: x
% If uniform, then c in [0.1,0.5], and e_i in [0.5,2.5].
pM = 1/numCand*ones(1,numCand);         % Model prior
numParam = 5;
%L = [0.1,0.5,0.5,0.5,0.5];              % Lower bound of param range
%U = [0.5,2.5,2.5,2.5,2.5];              % Upper bound of param range
%paramPdf{1} = @(x) unifpdf(x,L,U);      % Uniform
MuPrior = [0.25,1,2,2,2]';
SigmaPrior = eye(numParam);
paramPdf{1} = @(X) mvnpdf(X,MuPrior,SigmaPrior);   % Gaussian (X: n by d, d: dim)
for i = 2:numCand
    paramPdf{i} = paramPdf{1};
end
logpdf = @(X) getLogPrior(X,'normal',MuPrior,SigmaPrior);

% Draw parameter samples for each model
numSample = 1000;
startPt = ones(5,1);                     % Will be replaced by the MAP estimate
for i = 1:numCand
    HMC = hmcSampler(logpdf,startPt);
    ThetaMAP = estimateMAP(HMC);
    paramSamples = drawSamples(HMC,'NumSamples',numSample,'StartPoint',ThetaMAP);
    responsePred = 
end


