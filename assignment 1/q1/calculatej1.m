%% this function calculates j at every possible combination of x and y 
% this is mainly used for plotting
function j1= calculatej1(X,Y,tx,ty)
  for i=1:length(tx)
    for j=1:length(ty)
      theta = [tx(i) ty(j)];
      j1(j,i)=calculatej(X,Y,theta);
    end
  end
end