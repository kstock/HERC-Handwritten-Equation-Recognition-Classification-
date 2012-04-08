%load('ex3weights.mat');


test = imread('ds3.jpg');
test = test(1:200,1:200);
%test = rgb2gray(test);

colormap(gray)


%imagesc(test)


%temp = test(1:300,1:300);

size_ex = 20;


r = size_ex;
c = size_ex;

data_x = zeros(100,size_ex * size_ex);
data_y = zeros(100,1);


data_row = 1;
class = 10;

while c <= size_ex * 10

    
    %if first row
    if c - size_ex <= 0
            
        %if first cell in row
        if r - size_ex <= 0
            temp = test(1:r,1:c);
        else
            temp = test(r-19:r,1:c); 
        end
        
        
    %if second row    
    else
        %if first cell in row
        if r - size_ex <= 0
            temp = test(1:r,c - size_ex + 1:c);
        else
            temp = test(r - size_ex + 1:r,c - size_ex + 1:c); 
        end
    end
    
    %imagesc(temp)
    
    %pad 3px border with whitespace 
    %NOTE: if there is real information in this border, it will be lost
    whitetemp = temp;
    whitetemp(1:20,1:3) = 255;
    whitetemp(1:3,1:20) = 255;
    whitetemp(17:20,1:20) = 255;
    whitetemp(1:20,17:20) = 255;
    
    %imagesc(whitetemp)
    
    %pause
    
    
    temp2 = reshape(whitetemp,1,20*20);
    
    data_x(data_row,:) = temp2;
    data_y(data_row) = class;
    
    data_row = data_row + 1;
    
    
    r = r + 20;
    if r > 200 %wrap around, new row
        r = 20;
        c = c + 20;
        
        
        %inc class 10 is for 0, 1 for 1, etc
        if class == 10
            class = 1;
        else class = class + 1;
        end
    end
    
    
end
%}

%imagesc(test)

%test = test(:,1:20);
%test = reshape(test,1,400);

%test = double(test);

%predict(Theta1,Theta2,test)