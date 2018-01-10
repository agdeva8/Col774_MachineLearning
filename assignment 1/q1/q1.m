% this is the main program ... 
% here captital variables are used to denote vectors or matrices

%% clearing all init 
close all; clear; clc;

%% loading data %%
X = load('q1x.dat');
Y = load('q1y.dat');

[m k] = size(X);
%%%% Normalizing features ... 
%% scaling the features so that contour plot as circle rather than
%% eliptical and gradient descent finds the much straight and shorter
%% path to the minimum,,
%% usually more usefull for multi features example..... 
for i=1:k
  mu = mean(X(:,i));
  sigma = std(X(:,i));
  if sigma ~= 0
    X(:,i) = (X(:,i)-mu)/sigma;
  end;
end


epsilon = 0.001;
alpha=0.1;
%%% intercept term
X = [ones(m,1),X];
[m k] = size(X);

theta = zeros(1, k);
% j_theta = calculatej(X,Y,theta) % cost function
j_theta = calculatej(X,Y,theta) + 1;
itr=0;
while j_theta-calculatej(X,Y,theta) > epsilon
  itr= itr+1;
%j_hist = zeros(50,1);
%for itr=1:50
  j_theta = calculatej(X,Y,theta); % cost function
  j_hist(itr) = j_theta;
  theta_0(itr) = theta(1);
  theta_1(itr) = theta(2);
  %disp('j_theta='),disp(j_theta);
  htheta = X * (theta');
  delta = (htheta - Y)' * X;
  theta = theta - alpha*1/m*delta;
  %disp(theta);
end
disp('theta = ');
disp(theta);

%% plottting J_theta wrt number of iterations
figure(1);
plot(j_hist,'linewidth',2);
xlabel ('number of  itr');
ylabel ('jTheta');
title ('cost function as the number of itrs');

%% giving the time to user to see the graphs properly
disp ('press any key to continue');
pause;

%% plotting the data and the hypothesis function
figure(2);
% plotting data on the another figure:
plot(X(:,2) , Y ,'+k','linewidth',2);
xlabel ('x1');
ylabel ('x2');
title ('data and the hypothesis function');

hold on;
% plotting the hypothesis function 
figure(2),plot(X(:,2), X * (theta'),'linewidth',2);
hold off;

%% giving the time to user to see the graphs properly
disp ('press any key to continue');
pause;

%% plotting the 3D mesh and contour 
tx = -1:0.06:(theta(1)*2); % tx <==> theta_0
ty = -1:0.06:(theta(2)*2); % ty <==> theta_1
%tx = -1:0.1:9;
%ty = -1:0.1:9;
tz = calculatej1(X , Y , tx , ty);

figure(3);
% plotting the 3D mesh..
mesh (tx, ty, tz);
xlabel ('teta_0');
ylabel ('theta_1');
zlabel ('j_theta');
title  ('3D cost function');
%%% comment line(90) and uncomment below lines till end 
%%% to see the display animation of making the plot ...
%for i = 1:length(tx)
  %mesh (tx(i), ty, tz(:,i));
  %hold on;
  %pause (0.2);
%end;

%% giving the time to user to see the graphs properly
disp ('press any key to continue');
pause;

%% plotting contour of the cost function and showing the animation of 
%  convergence
figure(4);
% plotting the contour... 
contour (tx,ty,tz,'linewidth',2);
xlabel ('theta_x');
ylabel ('theta_1');
zlabel ('j_theta');
title  ('Cost function countour');
% making the animation of convergence .... 
hold on;
for k=1:length(theta_0)
     figure(4),plot (theta_0(1,k), theta_1(1,k), 'or','linewidth',2)
     pause(0.2);
%      hold on;
end

%% giving the time to user to see the graphs properly
disp ('press any key to continue');
pause;
close all;