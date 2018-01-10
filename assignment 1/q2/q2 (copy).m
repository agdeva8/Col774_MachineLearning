%%%%%%%%%%%%%%%%%%% assignment 1 question 2 main file %%%%%%%%%%%%%%%%%%%%%%%%%%
%%% In this question we have to use normal equation so no need of 
%%% normailising the features.

%%% clear init
close all; clear; clc;

%% loading the data..
X = load('q3x.dat');
Y = load('q3y.dat');

%% adding the intercept term
%% to make X the design matrix 
[m k] = size(X);
X = [ones(m,1) X];

%% using normal equation theta=(X'X)^‚àí1*X'*Y without weights...
disp('computing the part a');
%% using pinv instead of inv to compute inverse of not 
%% singular matrix of X'X 
theta = pinv(X'*X)*(X')*Y;
disp('theta = ');
disp(theta);

%%% plotting data and our hypothesis on the same graph
X1 = load('q3x.dat');
plot (X1, Y, '+k','linewidth', 2, 'markersize', 5);
hold on;
plot (X1, X*theta,'linewidth', 2, 'color', 'r');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% part B;
%%%% using normal equation theta=(X'WX)^‚àí1*X'W*Y 'with' weights..
%% computed on my own
disp('computing part b');

%% computing weights given by formula and putting it in m X m diagonal matrix
%% w(i) = exp(-(x-x(i))^2/(2*tau^2)); for the query point x
%% if x is vector(multifeatured) then square is replaced by transposing the term
%% but here its not needed as not taking zeroth feature so only one feature

W = zeros(m,m);
tauArray = [0.8, 0.3, 0.1, 2, 10]; %% bandwidth parameter
tauColor = ['r', 'b', 'g', 'y', 'm'];
%tau = 0.3;
%% calculating weights W and theta for each training example and storing it
figure;
%%%%% plotting the data and the hypothesis function.
plot (X1, Y, 'xk', 'linewidth', 2);
xlabel ('data_points');
ylabel ('hypothesis');
title ('Q2_PartB_WeightedLocalRegression');
legendName{1} = 'name';
legend (legendName,"location",'southeast');

for t=1:length(tauArray)
  h = calculateh(X, Y, tauArray(t));
  hold on; pause (3);
  plot (h(:,1), h(:,2), 'linewidth', 3, 'color', tauColor(t));
  legendName{t+1} = strcat('tau = ', num2str(0.8));
  legend (legendName);
end;