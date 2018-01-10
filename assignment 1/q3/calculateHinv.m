function Hinv = calculateHinv(X, Y, theta);
  [m k] = size(X);
  h = calHypothesis(X, Y, theta);
  for i=1:k
    for j=i:k
    H(i,j) = X(:,j)'*(X(:,i).*h.*(h-1));
    H(j,i) = H(i,j);
    end
  end
  Hinv = pinv(H);
end