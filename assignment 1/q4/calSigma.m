function sigma = calSigma(x,muy)
  [m k] = size(x);
  sigma = zeros(k,k);
  for i=1:m
    sigma = sigma + (x(i,:)-muy(i,:))'*(x(i,:)-muy(i,:));
  end
  sigma = sigma/m;
end
  