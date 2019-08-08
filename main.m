% Model: I.24.6: E = (1/4)*m*(omega^2+omega_0^2)*x^2
% Input: (m,omega,omega_0,x)
% Range of input: 
% m: [0,1]; omega,omega_0: [0,pi]; x:[0,1]
% Output: E

% Ground-truth model
model = @(m,omega,omega_0,x) (1/4)*m*(omega^2+omega_0^2)*x^2;

% Candidate models
numCand = 3;
cand{1} = model;
cand{2} = @(m,omega,omega_0,x) 0.65*m*omega^1.15*omega_0^0.65*x^1.8;
cand{3} = @(m,omega,omega_0,x) 0.1*m*(omega^2+omega^2)*omega_0^2;
%cand{3} = @(m,omega,omega_0,x) (0.51*m^1.75*omega^2*x^2+0.49*m^1.76*omega^0.02*omega_0^2*x^2)/(m^0.63*omega^0.03*x^0.01+m^0.86);
%cand{4} = @(m,omega,omega_0,x) (0.2*m*omega^2*omega_0^1.04*x^2+2.07*m*omega_0^2*x^2)/(0.83*m^3.45-9.3*m^0.37*omega_0^0.7*x^0.45);

% Discretize parameter space
% Five parameters: [c,e_1,...,e_4]
% c in [0.1,0.5], and e_i in [0.5,2.5] 
numParam = 5;
hTheta1 = 0.01;                          % Interval for c
hTheta2 = 0.1;                           % Interval for e_i
paramSpace{1} = 0.1:hTheta1:0.5;         % c 
paramSpace{2} = 0.5:hTheta2:2.5;         % e_1
paramSpace{3} = paramSpace{2};           % e_2
paramSpace{4} = paramSpace{2};           % e_3
paramSpace{5} = paramSpace{2};           % e_4

% Discritize input space
hInput = 0.1;
inputSpace{1} = 0:hInput:1;              % m
inputSpace{2} = 0:hInput:3.2;            % omega
inputSpace{3} = inputSpace{2};           % omega_0
inputSpace{4} = 0:hInput:1;              % x


% Initial parameter distribution 
pM = 1/numCand*ones(1,numCand);         % Model prior
pThetaMarg = cell(1,numParam);
for j = 1:numParam
    pThetaMarg{j} = 1/length(paramSpace{j})*ones(1,length(paramSpace{j}));  % Uniform over each param
end
pTheta = outerProd(pThetaMarg);          % To compute the KL-div, we need the same support of params over all models
pThetaMat = zeros([numCand,size(pTheta)]);
S.subs = repmat({':'},1,numParam+1);
S.type = '()';
for i = 1:numCand
    S.subs{1} = i;
    pThetaMat = subsasgn(pThetaMat,S,pTheta);
end

% Draw parameter samples for each model
numSample = 200;
for i = 1:numCand
    
end

% Select experiment point
JSdiv = JSDiv(pThetaMat,pM,'d'); 

