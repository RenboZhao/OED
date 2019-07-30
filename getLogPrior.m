function logPdf = getLogPrior(X,type,varargin)
% Type: distribution type
% X: d by n matrix

switch type
    case 'normal'
        Mu = varargin{1};
        Sigma = varargin{2};
        logPdf = trace(-.5*(X-Mu)'*(Sigma\(X-Mu)));
        % gradLogPdf = -Sigma\(X-Mu);
end


end

