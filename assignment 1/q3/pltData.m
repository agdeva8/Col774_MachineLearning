function s = pltData(X,Y)
  [m k] = size(X);
  for i=1:m
    if Y(i,1) == 1
      markerType = 'ok';
    else
      markerType = '+r';
    end
    plot (X(i,2), X(i,3), markerType, 'linewidth', 2, 'markersize', 10);
    hold on;
  end
end