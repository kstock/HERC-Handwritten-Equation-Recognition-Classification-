%
% params: 
%         data_x: toy dataset matrix of examples
%         data_y: class values corresponding to data_x examples
%         all_theta_toy: classifier

%number correct
true_pos = 0;

%false positive count for each class
false_pos = zeros(20);

% x-axis: true value
% y-axis: false predicted value
mistakes = zeros(20,20);


%pred = zeros(1000,1);
for i = 1:1000

   pred = predictOneVsAll(all_theta, data_x(i,:));

   
   mistakes( data_y(i), pred) = mistakes( data_y(i), pred) + 1;

   
   if pred == data_y(i)
       true_pos = true_pos + 1;
   end
   
  
    
    
end

%plotconfusion(data_y,pred)

%true_pos

%mistakes

%fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);
