%
% params: 
%         data_x: toy dataset matrix of examples //output getDataMat.m
%         data_y: class values corresponding to data_x examples//output
%                                                              //getDataMat.m

%TODO: 
%       increase accuracy!!
%       less clumsy way than acc_str to save output!!
%       use matlab's cross-validation function/relitavize CV
%       test with Infty data
%       test with MNIST data?
%       compare different classification algorithms?
%       vectorize?
%       save thetas?


%holds output of each folds results
acc_str = '';

% ROW: true value
% COL: false predicted value
% z-axis: different cross-validation folds
mistakes = zeros(20,20,5);

%load('data_x.mat');
%load('data_y.mat');

k = 5;
acc = zeros(k,1);


%tested different values of lambda, .1 seemed to work best
%check images/plots/lambdaVSacc#.jpg for plots of lambda vs mean CV acc
tic()
for lambda = .1%[.09,.11,.125]%[.15,.2,.5,.75]%[0,.1,1,10,20]

%naive way to do 5 fold cross-validation
%need to replace with a better idea!!
for i = 1:k

    if i == 1
        
        train_x1 = data_x([101:500,601:end],:);
        train_y1 = data_y([101:500,601:end],:);
        
        test_x1 = data_x([1:100,501:600],:);
        test_y1 = data_y([1:100,501:600],:);

    elseif i == 2
        
        train_x1 = data_x([1:100,201:600,701:end],:);
        train_y1 = data_y([1:100,201:600,701:end],:);
        
        test_x1 = data_x([101:200,601:700],:);
        test_y1 = data_y([101:200,601:700],:);
        
    elseif i == 3
        train_x1 = data_x([1:200,301:700,801:end],:);
        train_y1 = data_y([1:200,301:700,801:end],:);
        
        test_x1 = data_x([201:300,701:800],:);
        test_y1 = data_y([201:300,701:800],:);
        
    elseif i == 4
        train_x1 = data_x([1:300,401:800,901:end],:);
        train_y1 = data_y([1:300,401:800,901:end],:);
        
        test_x1 = data_x([301:400,801:900],:);
        test_y1 = data_y([301:400,801:900],:);
    else
         train_x1 = data_x([1:400,501:900],:);
        train_y1 = data_y([1:400,501:900],:);
        
        test_x1 = data_x([401:500,901:end],:);
        test_y1 = data_y([401:500,901:end],:);
    end
    
        %train theta classifier on training data
        all_theta = oneVsAll(train_x1,train_y1,20,lambda);

        %{ 
        if i == 2
           hog_theta_cvf2 = all_theta;
        end
          %}  
        
        
        %make predictions
        pred = predictOneVsAll(all_theta, test_x1);
       
        %confusion matrix
        mistakes(:,:,i) = confusionmat(test_y1,pred);
 
        %accuracy measure
        acc(i) = mean(double(pred == test_y1)) * 100;
        
        %string output 
        fprintf('\n lambda= %d Validation set %d Accuracy: %f \n', lambda, i, acc(i));
        acc_str = strcat(acc_str, ...
                 sprintf('lambda= %d Validation set %d Accuracy: %f \n', lambda,i, acc(i)));        
end



fprintf('\nlambda=%d Cross Validation mean accuracy: %f \n', lambda, mean(acc) );

acc_str = strcat(acc_str, ...
                 sprintf('\nlambda=%d Cross Validation mean accuracy: %f \n',lambda,mean(acc) ));

end

toc()