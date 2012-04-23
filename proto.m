% : (



%this is my messy playground, it will be cleaned up in a few days


%{

load('data_x.mat');%output getDataMat
load('data_y.mat');
load('hog_theta_cvf2');%output result


x = imread('images/logic/x.jpg');
x = rgb2gray(x);
x = removeborder(x);

forAll = imread('images/logic/forAll.jpg');
forAll = rgb2gray(forAll);
forAll = removeborder(forAll);

exist = imread('images/logic/exist_1.jpg');
exist = rgb2gray(exist);
exist = removeborder(exist);


colormap('gray') %added by me

num = 1;
imwrite(x,strcat('x_',int2str(num),'.jpg'),'jpg');
imwrite(forAll,strcat('forAll_',int2str(num),'.jpg'),'jpg');
%imwrite(exist,strcat('exist_',int2str(num),'.jpg'),'jpg');


[forAll_mat x_mat_y] = getDataMat('images/logic/forAll_1.jpg');

[forAll_mat2 x_mat_y] = getDataMat('images/logic/forAll_2.jpg');


[exist_mat x_mat_y] = getDataMat('images/logic/exist_1.jpg');
[exist_mat2 x_mat_y] = getDataMat('images/logic/exist_2.jpg');

[x_mat x_mat_y] = getDataMat('images/logic/x_1.jpg');
[x_mat2 x_mat_y] = getDataMat('images/logic/x_2.jpg');

%data_x = [exist_mat; exist_mat2; forAll_mat;forAll_mat2; x_mat;x_mat2];
%data_x = [exist_mat; forAll_mat; x_mat];
%data_x = [ exist_mat2;forAll_mat;x_mat2];
%data_y = [ones(100,1); 2*ones(100,1); 3*ones(100,1)];




data_x = [forAll_mat;forAll_mat2;exist_mat;exist_mat2;x_mat2];%x_mat;x_mat2];
data_y = [ones(200,1); 2*ones(200,1); 6*ones(100,1)];
%}





directory = 'images/logic/';

%get all the .jpg data files in directory
file = dir( strcat(directory,'*.jpg') );

data_x = zeros(length(file) * 100, 81);
data_y = zeros(length(file) * 100,1);

for i = 1:length(file)
    
    [data_x((i-1)*100 + 1:i*100,:) data_y((i-1)*100 + 1:i*100)] = getDataMat( strcat(directory, file(i).name ));
    
    
end




all_theta = oneVsAll(data_x,data_y,5,.1);

%make predictions
pred = predictOneVsAll(all_theta, data_x);


%accuracy measure
acc = mean(double(pred == data_y)) * 100





dir2 = 'images/extracted/formula1Filtered/';
test_x = zeros(7,81);

for i = 1:7
    temp = imread( strcat(dir2, int2str(i),'.jpg' ) );
    temp2 = HOG(temp);

    test_x(i,:) = temp2;%imread( strcat(dir2, int2str(i),'.jpg' ) );
end

pred = predictOneVsAll(all_theta, test_x);


%{
data_x = zeros(7,81);


directory = 'images/extracted/formula1Filtered';

files = dir( strcat(directory,'*.jpg'));

for i = 1:length(files)
   data_x(i,:) = getDataMat( strcat( directory, files(i).name) );
end

    
all_theta = oneVsAll(data_x,data_y,3,.1);

%all_theta = oneVsAll(train_x,train_y,2,lambda);

%make predictions
pred = predictOneVsAll(all_theta, data_x)


%accuracy measure
%acc = mean(double(pred == data_y)) * 100


%}
%{
for i = 1:1
    
i + 321
four = data_x(332+i,:);
two = data_x(315,:);

fourtyTwo = [four;two];

%make predictions
pred = predictOneVsAll(hog_theta_cvf2, fourtyTwo)
       
end

%}