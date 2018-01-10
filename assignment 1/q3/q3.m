%%%%%%%%%%%%%%%%%%%%%%%%%% Assignment 1 Q3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%using newton method(as asked in question) to maximize the log likelihood function
%completed.. both parts..
%% apparently it turns out as a fact that newton method takes only one iteration 
%%% clear init
close all; clear; clc;

%% loading the data
X = load('q2x.dat');
Y = load('q2y.dat');
[m k] = size(X);

%% including the intercept term.
X = [ones(m,1), X];
k = k+1;

%% plotting data
pltData(X,Y);
disp ('press any key to calculate thetha and hypothesis and make boundary')
pause;

%% using upgradation rule θ := θ − H−1*∇θ(l(θ)).
theta = zeros(k,1);
disp('initial theta = '); disp(theta');
%totalItr = 0;
h = calHypothesis(X, Y, theta);
lTheta = -100; %% lTheta corresponds to the log likelihood 
epsilon = 10^-3;
while (Y'*log(h)+(1-Y)'*(log(1-h))-lTheta) > epsilon
h = calHypothesis(X, Y, theta);
lTheta = Y'*log(h)+(1-Y)'*(log(1-h));
deltaLTheta = calculateDelta(X, Y, theta);
Hinv = calculateHinv(X, Y, theta);
theta = theta - Hinv*deltaLTheta;
end

disp('final theta = '); disp(theta');
hold off;
x1 = X(:,2);
y1 = -theta(1)/theta(3)-theta(2)/theta(3)*x1;
pltData(X,Y);
plot (x1,y1,'linewidth',2);

disp ('logistic regression completed :))');
