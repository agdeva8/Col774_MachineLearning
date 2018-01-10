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

%% using normal equation theta=(X'X)^−1*X'*Y without weights...
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
%%%% using normal equation theta=(X'WX)^−1*X'W*Y 'with' weights..
%% computed on my own
disp('computing part b');

%% computing weights given by formula and putting it in m X m diagonal matrix
%% w(i) = exp(-(x-x(i))^2/(2*tau^2)); for the query point x
%% if x is vector(multifeatured) then square is replaced by transposing the term
%% but here its not needed as not taking zeroth feature so only one feature

W = zeros(m,m);
tau = 0.3;
%% calculating weights W and theta for each training example and storing it
figure;
%%%%% plotting the data and the hypothesis function.
plot (X1, Y, 'xk', 'linewidth', 2);

for i=1:m
  for j=1:m
    W(j,j) = exp(-((X(i,2)-X(j,2))^2)/(2*tau^2));
  end;
  theta(:,i) = pinv(X'*W*X)*X'*W*Y;
end;
theta = theta';
h = theta(:,1).*X(:,1) + theta(:,2).*X(:,2);
h1 = [X1, h];
h1 = sortrows (h1,1);
hold on;
plot (h1(:,1), h1(:,2), 'linewidth', 2);