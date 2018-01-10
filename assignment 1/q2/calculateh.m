%% here all the calculations are there for the locally weighted linear regression
% computed weights, theta and h itself
% and outputed a matrix with first column data points and the second value
% h itself
function h = calculateh(X, Y, tau)
  m = length(X);
  for i=1:m
    for j=1:m
      W(j,j) = exp(-((X(i,2)-X(j,2))^2)/(2*tau^2));
    end
    theta(:,i) = pinv(X'*W*X)*X'*W*Y;
  end
  theta = theta';
  h_temp = theta(:,1).*X(:,1) + theta(:,2).*X(:,2);
  h = [X(:,2), h_temp];
  h = sortrows (h,1);
end