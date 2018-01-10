function h = calHypothesis(X,Y,theta);
  h = X*theta;
  [m k] = size(X);
  for i=1:m
    h(i) = 1/(1+exp(-h(i)));
  end
end