%Modified ml-class program for 155 project
%regularized logistic regression, one-vs-all classifier
%takes a long time to train, 50 iterations per class;
%Elapsed time is 540.475975 seconds; (9 min)
%
%OUTPUTS: all_theta, one vs all classifier



%DEPENDENCIES:

%data_x, data_y existing as .mat files
%These are the outputs of getDataMat.m

%

%TODO
%       test different values of lambda
%       de-hardcode some values
%
%At some point need to fully cannabalize this code instead of just being
%   parasitic; understand and optimize




%% Machine Learning Online Class - Exercise 3 | Part 1: One-vs-all

%  Instructions
%  ------------
% 
%  This file contains code that helps you get started on the
%  linear exercise. You will need to complete the following functions 
%  in this exericse:
%
%     lrCostFunction.m (logistic regression cost function)
%     oneVsAll.m
%     predictOneVsAll.m
%     predict.m
%
%  For this exercise, you will not need to change any code in this file,
%  or any other files other than those mentioned above.
%

%% Initialization
%clear ; close all; clc

%% Setup the parameters you will use for this part of the exercise
input_layer_size  = 24963;  % 20x20 Input Images of Digits
num_labels = 20;          % 10 labels, from 1 to 10   
                          % (note that we have mapped "0" to label 10)

%% =========== Part 1: Loading and Visualizing Data =============
%  We start the exercise by first loading and visualizing the dataset. 
%  You will be working with a dataset that contains handwritten digits.
%

% Load Training Data
fprintf('Loading and Visualizing Data ...\n')
load('data_x.mat');
load('data_y.mat');


%load('ex3data1.mat'); % training data stored in arrays X, y
X = data_x;
y = data_y;
m = size(X, 1);

% Randomly select 100 data points to display
rand_indices = randperm(m);
sel = X(rand_indices(1:100), :);

%displayData(sel);

fprintf('Program paused. Press enter to continue.\n');
%pause;

%% ============ Part 2: Vectorize Logistic Regression ============
%  In this part of the exercise, you will reuse your logistic regression
%  code from the last exercise. You task here is to make sure that your
%  regularized logistic regression implementation is vectorized. After
%  that, you will implement one-vs-all classification for the handwritten
%  digit dataset.
%

fprintf('\nTraining One-vs-All Logistic Regression...\n')

%regulaization, test different values!!
lambda = 0.1;

%time computation
tic()

[all_theta] = oneVsAll(X, y, num_labels, lambda);

toc()

fprintf('Program paused. Press enter to continue.\n');
pause;


%% ================ Part 3: Predict for One-Vs-All ================
%  After ...
pred = predictOneVsAll(all_theta, X);

fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);

