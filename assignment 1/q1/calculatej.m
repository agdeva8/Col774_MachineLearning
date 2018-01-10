%% calculates cost function for given x, y and theta
function j= calculatej(X,Y,theta)
  m = length(Y);
  htheta = X * (theta');
  delta = Y - htheta;

  j = 1/(2*m)*(delta') * delta;
end
