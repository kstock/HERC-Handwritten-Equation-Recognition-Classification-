%extracts characters from a paper, resizes and puts them into matrices

%INPUT: array of bounding box structs
%OUTPUT: correct size matrices for each bounding box to feed to classifier

%TODO
%   determine centroid NOTE: possible error in centroid calculation
%   output image
%   deal with case where caracter is greater than the bounding box
%

%Character = segmeter2('images/dataset_proc/oren_9.jpg');
%Im = imread('images/dataset_proc/oren_9.jpg');

%read formula1,turn to grayscale, save over
sting = 'images/logic/formula1.jpg';
x = imread('images/logic/formula1.jpg');
x = rgb2gray(x);
imwrite(x,sting,'jpg');

Character = segmeter2(sting);
Im = imread(sting);


someBox = Character(20).BoundingBox();
%http://www.mathworks.com/help/toolbox/images/ref/regionprops.html#bqkf8hf


box = floor(someBox); %??Iono why bounding box has non-integer fields

%imagesc( Im(238:238+35,842:842+62)) %character(20) from oren_9
%imagesc( Im( box(1):box(1)+box(3),box(2):box(2)+box(4)))
I = Im( box(1):box(1)+box(3),box(2):box(2)+box(4));
%imshow(I)

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
x = floor(avg(1)/count);
y = floor(avg(1)/count);

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

top_x = floor(x-(a/2))+box(1);
top_y = floor(y-(b/2))+box(2);
I2 = Im(  top_y:top_y+b , top_x:top_x+a );

%imshow(I2)

%output the new image
imwrite(I2,'1.jpg','JPEG'); %change this to output to a subfolder
