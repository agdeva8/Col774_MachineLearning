%%% its an indicator function
function Ians = I(Y,val) 
  for i=1:length(Y)
    if Y(i) == val
      Ians(i,1) = 1;
    else
      Ians(i,1) = 0;
    end
  end
end