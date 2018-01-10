function delta = calculateDelta(X,Y,theta)
  [m k] = size(X);
  h = calHypothesis(X,Y,theta);
  for j=1:k
    delta(j,1) = (Y-h)'*X(:,j);
  end
end