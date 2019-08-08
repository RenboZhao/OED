function div = KLDiv(p,q,type)

% Type: 'c' or 'd'

if type == 'd'
    
    p = squeeze(p)/sum(p(:));                           % Normalization
    q = squeeze(q)/sum(q(:));
    
    n = numel(p);
    pZeroInd = find(p < eps);
    qZeroInd = find(q < eps);
    
    if isempty(setdiff(qZeroInd,pZeroInd)) == 0         % Non-empty difference
        div = Inf;
        return;
    else
        p = p(setdiff(1:n,pZeroInd));
        q = q(setdiff(1:n,pZeroInd));
    end
        
    div = sum(p.*log2(p./q));
    
elseif type == 'c'
    
    h = 1e-2;                                           % Discretization interval per dim
    
    
    
    
end

end

