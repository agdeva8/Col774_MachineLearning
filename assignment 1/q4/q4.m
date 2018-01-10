%%%%%%%%%%%%%%%%%%%%%%%%%%% Assignment1 Q4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% applying the GDA algorithm 
%%% clearing the init 
close all; clear; clc;

%% loading the data
X = load('q4x.dat');
Y = textread('q4y.dat','%s'); %%% reading the text file
[m k] = size(X);

%% sorting the data acccording to alaska or canada
% and changing values of Y ( 1 for Alaska and 0 for Canada)
j = 1;
for i=1:m
  if strcmp(Y(i), 'Alaska')
    yTemp(i) = 1;
    xAlaska(j,:) = X(i,:);
    j = j+1;
  else
    yTemp(i) = 0;
    xCanada(i-j+1,:) = X(i,:);
  end
end
Y = yTemp';

%% plotting the data 
figure(1);
plot(xAlaska(:,1), xAlaska(:,2), 'or', 'linewidth', 2, 'markersize', 10);

xlabel ('x1');
ylabel ('x2');
title ('data');

hold on;

plot(xCanada(:,1), xCanada(:,2), '+k', 'linewidth', 2, 'markersize', 10);
legend ('Alaska', 'Canada');
hold off;
disp ('press any key to continue');
pause;

%% computing the maximum likelihood parameters
phi = 1/m*sum(I(Y,1));
mu0 = (X'*I(Y,0))/sum(I(Y,0));
mu1 = (X'*I(Y,1))/sum(I(Y,1));
muy = mu0*((1-Y)') + mu1*(Y');
muy = muy'; mu0 = mu0'; mu1 = mu1';
sigma = calSigma(X,muy);

disp ('mu0 = ');
disp (mu0);
disp ('mu1 = ');
disp (mu1);
disp ('sigma = ');
disp (sigma);

disp ('press any key to continue');
pause;

%% plotting the multivariate normal/gaussian distributtion with mesh
figure(2);
x1 = linspace(min(X(:,1)),max(X(:,1)),100);
x2 = linspace(min(X(:,2)),max(X(:,2)),100);
F1 = calculateMvnpdf(x1,x2,mu0,sigma); %% canada
mesh(x1,x2,F1);

xlabel ('x1');
ylabel ('x2');
title ('guassian distribution');

hold on;

F2 = calculateMvnpdf(x1,x2,mu1,sigma);
mesh(x1,x2,F2);
hold off;

disp ('press any key to continue');
pause;

%% plotting the contours on data points and the boundary separating it 
% TODO : finding the equation of the boundary
figure(3);
plot(xAlaska(:,1), xAlaska(:,2), 'or', 'linewidth', 2, 'markersize', 10);
hold on;
plot(xCanada(:,1), xCanada(:,2), '+k', 'linewidth', 2, 'markersize', 10);

disp ('press any key to continue');
pause;
contour(x1,x2,F1,'k','linewidth',1.5);
disp ('press any key to continue');
pause;
contour(x1,x2,F2,'r','linewidth',1.5);

axis();

disp ('press any key to continue');
pause;
contour(x1,x2,F1-F2,[0,0],'b','linewidth',3);

legend ('Alaska','Canada','AlaskaContour','CanadaContour');
xlabel ('x1');
ylabel ('x2');
title ('gaussian distribution contours and the seprating boundary');

hold off;
%%%% finding equation of the line 
%hold on;
%plot (99,429,'*b','linewidth',4,'markersize',20);
disp ('press any key to continue');
pause;


%%%%%%%%%%%%%%%%%%%%%%%%%%% using different sigma %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% calculating sigma 0
sigma0 = zeros(k,k);
for i=1:m
  update = I(Y(i),0)*(X(i,:)-muy(i,:))'*(X(i,:)-muy(i,:));
  sigma0 = sigma0 + update;
end
sigma0 = sigma0/length(xCanada);
disp ('sigma0 = ');
disp (sigma0);

%%%% calculating sigma 1
sigma1 = zeros(k,k);
for i=1:m
  update = I(Y(i),1)*(X(i,:)-muy(i,:))'*(X(i,:)-muy(i,:));
  sigma1 = sigma1 + update;
end
sigma1 = sigma1/length(xAlaska);
disp ('sigma1 = ');
disp (sigma1);

disp ('press any key to continue');
pause;

%% plotting the contours with the data points 

Fb1 = calculateMvnpdf(x1,x2,mu0,sigma0); %% canada
Fb2 = calculateMvnpdf(x1,x2,mu1,sigma1);

figure(4);
plot(xAlaska(:,1), xAlaska(:,2), 'or', 'linewidth', 2, 'markersize', 10);
hold on;
plot(xCanada(:,1), xCanada(:,2), '+k', 'linewidth', 2, 'markersize', 10);

disp ('press any key to continue');
pause;
contour(x1,x2,Fb1,'k','linewidth',1.5);
disp ('press any key to continue');
pause;
contour(x1,x2,Fb2,'r','linewidth',1.5);

axis();

disp ('press any key to continue');
pause;
contour(x1,x2,Fb1-Fb2,[0,0],'b','linewidth',3);

legend ('Alaska','Canada','AlaskaContour','CanadaContour');
xlabel ('x1');
ylabel ('x2');
title ('gaussian distribution contours and the seprating boundary');
hold off;

disp ('press any key to continue');
pause;
close all;
disp (' ');
disp ('Gaussian Discrmimant Analysis completed :))');