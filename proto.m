function [parse,pos] = proto(str) 

load('images/data/cvbaseline-model.mat') ; % change to the model path

[im,pos] = extract(str);

[numPic,n] = size(im);
parse = zeros(numPic,1);

for i = 1:numPic
    %temp = imread( strcat(dir2, int2str(i),'.jpg' ) );
    label = model.classify(model, reshape(im(i,:),[159 157]));
    label
    getClass(label);
    parse(i) = getClass(label)%imread( strcat(direct, int2str(i),'.jpg' ) );
    
end

end


%{
%this is my messy playground, it will be cleaned up in a few days

load('images/data/cvbaseline-model.mat') ; % change to the model path
%load('images/data/old trains/50train tilde neg/baseline-model.mat') ; % change to the model path


%direct = 'images/extracted/formula1Filtered/';
direct = 'images/fakeFormula/funct2/';
%direct = 'images/data/holdout/five/';

pics = dir(strcat(direct,'*jpg'));
%pics = pics(4:end);
numPic = length(pics);%length(dir(direct))-3;


parse = zeros(numPic,1);


for i = 1:numPic
    %temp = imread( strcat(dir2, int2str(i),'.jpg' ) );
    label = model.classify(model, imread(strcat(direct, pics(i).name)));
    label
    parse(i) = getClass(label);%imread( strcat(direct, int2str(i),'.jpg' ) );
end

%}

% : (

%{

%this is my messy playground, it will be cleaned up in a few days

%load('images/data/baseline-model.mat') ; % change to the model path
%load('images/data/old trains/50train tilde neg/baseline-model.mat') ; % change to the model path
load('images/data/cvbaseline-model.mat') ; % change to the model path


%direct = 'images/extracted/formula1Filtered/';
%direct = 'images/fakeFormula/funct7/';
%direct = 'images/data/holdout/rightParen/';
%direct = 'images/data/herc-data/nine/';

direct = 'images/data/holdout/';
%direct = 'images/data/herc-data/';


numberOfLabels = 32;

numSamplesEach = 20;



classes = dir(direct) ;
classes = classes([classes.isdir]) ;
classes = {classes(3:numberOfLabels+2).name} ;



images = {} ;
imageClass = {} ;
for ci = 1:length(classes)
  ims = dir(fullfile(direct, classes{ci}, '*.jpg'))' ;
  ims = vl_colsubset(ims, numSamplesEach) ;
  ims = cellfun(@(x)fullfile(classes{ci},x),{ims.name},'UniformOutput',false) ;
  images = {images{:}, ims{:}} ;
  imageClass{end+1} = ci * ones(1,length(ims)) ;
end

%load('cvStuff.mat');



numPic = length(images);


%pics = dir(direct);
%pics = pics(4:end);
%numPic = length(dir(direct))-3;



parse = zeros(numPic,1);

count = 1;
correct = 0;

correctLabel = 1;
for i = 1:numPic
    %temp = imread( strcat(dir2, int2str(i),'.jpg' ) );
    label = model.classify(model, imread(fullfile(strcat(direct, images{i}))));
     

    if strcmp(label,classes{correctLabel})
        correct = correct + 1;
    %else
     %   label
      %  classes{correctLabel}
    end
   
    
    count = count + 1;
    
    if count > numSamplesEach
       correctLabel = correctLabel + 1
       count = 1;
    end
    
   %{ 
    if ~ strcmp(label,'rightParen')
        count = count + 1;
    end
    %}
    %parse(i) = getClass(label);%imread( strcat(direct, int2str(i),'.jpg' ) );
end


correct
correct/numPic
%save('parse.mat','parse');

%}

%{ 
%PROTOTPYE 1: used logistic reg

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


&END PROTO1
%}









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