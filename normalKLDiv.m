function div = normalKLDiv(Mu1,Sigma1,Mu2,Sigma2)

% Mu1, Mu2: column vectors

div = 0.5*(log(det(Sigma2)/det(Sigma1))+trace(Sigma2\Sigma1)+(Mu2-Mu1)'*(Sigma2\(Mu2-Mu1))-length(Mu1));


end

