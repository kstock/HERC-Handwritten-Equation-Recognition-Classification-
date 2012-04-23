%extracts characters from a paper, resizes and puts them into matrices

%INPUT: array of bounding box structs
%OUTPUT: correct size matrices for each bounding box to feed to classifier

%TODO
%   determine centroid NOTE: possible error in centroid calculation
%   output image into subfolder
%   deal with case where caracter is greater than the bounding box
%

%Character = segmeter2('images/dataset_proc/oren_9.jpg');
%Im = imread('images/dataset_proc/oren_9.jpg');

%read formula1,turn to grayscale, save over
%x = imread('images/logic/formula1.jpg');
%x = rgb2gray(x);
%imwrite(x,sting,'jpg');


sting = 'images/logic/formula1.jpg';
Character = segmeter2(sting);
Im = imread(sting);


for l = 1:size(Character,2)
    
someBox = Character(l).BoundingBox();
%http://www.mathworks.com/help/toolbox/images/ref/regionprops.html#bqkf8hf


box = floor(someBox); %??Iono why bounding box has non-integer fields

%imagesc( Im(238:238+35,842:842+62)) %character(20) from oren_9
%imagesc( Im( box(1):box(1)+box(3),box(2):box(2)+box(4)))
b1 = box(1);
b2 = box(1)+box(3);
b3 = box(2);
b4 = box(2)+box(4);
if(b1 < 1)
    b1 = 1
end
if(b2 > size(Im,1))
    b2 = size(Im,1);
end
if(b3 < 1)
    b3 = 1;
end
if(b4 > size(Im,2))
    b4 = size(Im,2);
end
I = Im( b1:b2, b3:b4);

%find the centroid of I

avg = [0 0];
count = 0;
[x y] = size(I);
for i = 1:x
    for j = 1:y
        if(I(i,j) < 130)
           avg(1) = avg(1) + j;
           agv(2) = avg(2) + i;
           count = count + 1;
        end
    end
end
%x and y centroid coordinates relative to the bounding box
if(count > 0)
x = floor(avg(1)/count)
y = floor(avg(1)/count)
else
    x = 1;
    y = 1;
end

%uncomment this block to test centroid coordinate
%{
imshow(I)
hold on
plot(x,y,'b*');
hold off
pause
%}

%there may be a problem with this centroid...
%either way the rest of this code should work

%read in a sample data image to get the correct output size
s = imread('images/data/1_0.jpg');
[a b] = size(s);

%center of box is x,y
%top left corner of box is x-(a/2), y-(b/2) relative to the bounding box

top_x = floor(x-(a/2))+box(1)
top_y = floor(y-(b/2))+box(2)

[s1 s2] = size(Im);
if(top_x < 1)
    top_x = 1;
    'error1'
end

if (top_x + a > s2)
    top_x = s2-a;
    'error2'
end

if(top_y < 1)
    top_y = 1;
    'error3'
end

if (top_y + b > s1)
    top_y = s1-b;
    'error4'
end

'final check'
top_y
top_y+b
top_x
top_x+b

I2 = Im(top_y:top_y+b, top_x:top_x+a);


%imshow(I2)

%output the new image
output_name = [ num2str(l) '.jpg'];
imwrite(I2, output_name ,'JPEG'); %change this to output to a subfolder
end
