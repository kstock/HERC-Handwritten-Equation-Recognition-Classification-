%extracts characters from a paper, resizes and puts them into matrices

%INPUT: array of bounding box structs
%OUTPUT: correct size matrices for each bounding box to feed to classifier
%centeredBox is a matrix of rows, each row containing a character
%boxPos contains x,y coordinates for the centroid the corresponding
%character

%TODO
%   determine centroid NOTE: possible error in centroid calculation
%   output image into subfolder
%   deal with case where caracter is greater than the bounding box
%

%Character = segmenter2('images/dataset_proc/oren_9.jpg');
%Im = imread('images/dataset_proc/oren_9.jpg');

%read formula1,turn to grayscale, save over
%x = imread('images/logic/formula1.jpg');
%x = rgb2gray(x);
%imwrite(x,sting,'jpg');

function [centeredBox pos] = extract(string)
%sting = 'images/logic/formula/formula1_crop.jpg';
%sting = 'demo/demo1.jpg';
%sting = 'images/numbers/eight_1.jpg';   
Character = segmenter2(string);

%DO SOME NMS HERE
%Character = nonMaxSupp(Character);
%END NMS STUFF
numBoxes = size(Character,2);
Im = imread(string);

%read in a sample data image to get the correct output size
s = imread('images/data/1_0.jpg');
[a b] = size(s);

%output matrix O
centeredBox = zeros(numBoxes,a*b);
'STARTING LOOP'
for l = 1:numBoxes
    l
    someBox = Character(l).BoundingBox();
    %http://www.mathworks.com/help/toolbox/images/ref/regionprops.html#bqkf8hf

    box = floor(someBox); %??Iono why bounding box has non-integer fields

    %imagesc( Im(238:238+35,842:842+62)) %character(20) from oren_9
    %figure
    %imagesc( Im( box(1):box(1)+box(3),box(2):box(2)+box(4)))
    
    %ensure bounding box is within the image 
    b1 = box(1); 
    b2 = box(1)+box(3); 
    b3 = box(2);
    b4 = box(2)+box(4);
    if(b1 < 1)
        b1 = 1;
        'case1'
    end
    if(b2 > size(Im,2))
        b2 = size(Im,1);
        'case2'
    end
    if(b3 < 1)
        b3 = 1;
        'case3'
    end
    if(b4 > size(Im,1))
        b4 = size(Im,2);
        'case4'
    end
    if(box(3) > 400 || box(4) > 400 )
        'too large'
        continue
    end
    I = Im(b3:b4,b1:b2); %extract pixels contained in bounding box
    %subplot(1,2,1)
    %colormap('gray');
    %imagesc(I);
    %str = sprintf('box: %d pre-padding',l);
    %title(str);
 
    if(size(I,1) > a & size(I,2) > b)
        I2 = I(1:a,1:b);
    elseif(size(I,1) > a)
        t = I(1:a-2,:);
        I2 = impad(t,[a b]);
    elseif(size(I,2) > b)
         t = I(:,1:b-2);
         I2 = impad(t,[a b]);
    else
        I2 = impad(I,[a b]);
    end %I2 now contains padded image
    
    
    %subplot(1,2,2)
    %colormap('gray');
    %imagesc(I2);
    %str = sprintf('box: %d post-padding',l);
    %title(str);
    %pause;
    
    centeredBox(l,:) = I2(:);
    


    %output the new image
    %output_name = [ num2str(l) '.jpg'];
    %imwrite(I2, colormap('gray'), output_name ,'JPEG'); %change this to output to a subfolder
end

pos = bbpos(Character) %this output needs to get used
end