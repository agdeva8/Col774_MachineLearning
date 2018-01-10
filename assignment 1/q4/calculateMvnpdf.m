function prob = calculateMvnpdf(x1,x2,mu,sig)
  detSigma = det(sig);
  for i=1:length(x1)
    for j=1:length(x2)
      xx = [x1(i),x2(j)];
      prob(j,i) = exp(-(xx-mu)*pinv(sig)*(xx-mu)')/sqrt(((2*pi)^2)*detSigma);
    end
  end
end