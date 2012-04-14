%
% params: 
%         data_x: toy dataset matrix of examples //output getDataMat.m
%         data_y: class values corresponding to data_x examples//output
%                                                              //getDataMat.m

%TODO: 
%       cross-validation!
%           fix indices
%       vectorize?
%       confusion matrices?
%       save thetas?
%number correct
true_pos = 0;

%false positive count for each class
false_pos = zeros(20);

% x-axis: true value
% y-axis: false predicted value
mistakes = zeros(20,20);

load('data_x.mat');
load('data_y.mat');

%load('all_theta_toy.mat');
%pred = zeros(1000,1);

k = 5;
acc = zeros(k,1);



%naive way to do 5 fold cross-validation
%need to replace with a better idea!!
for i = 1:k

    if i == 1
        
        train_x1 = data_x([101:500,601:end],:);
        train_y1 = data_y([101:500,601:end],:);
        
        test_x1 = data_x([1:100,501:600],:);
        test_y1 = data_y([1:100,501:600],:);     
        
        %{
        train_x1 = data_x(201:end,:);
        train_y1 = data_y(201:end,:);
        
        test_x1 = data_x(1:200,:);
        test_y1 = data_y(1:200,:);  
     %}

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
        %
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
    
        all_theta = oneVsAll(train_x1,train_y1,20,.1);

        pred = predictOneVsAll(all_theta, test_x1);
       
        
        
        acc(i) = mean(double(pred == test_y1)) * 100;
        fprintf('\n Validation set %d Accuracy: %f\n', i, acc(i));
        
        
        %
        %making confusion matrix code
        %commented out for now, might reincorporate after
        %cross-validation is fixed
        %{
        for i = 1:1000

           pred = predictOneVsAll(all_theta, test_x1(i,:));


           mistakes( data_y(i), pred) = mistakes( data_y(i), pred) + 1;


           if pred == test_y(i)
               true_pos = true_pos + 1;
           end



        end

                %}

        
end
%plotconfusion(data_y,pred)

fprintf('\nCross Validation mean accuracy: %f\n',  mean(acc) );


%true_pos

%mistakes

%fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);
