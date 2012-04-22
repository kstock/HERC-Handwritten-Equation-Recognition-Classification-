%extracts characters from a paper, resizes and puts them into matrices

%INPUT: array of bounding box structs
%OUTPUT: correct size matrices for each bounding box to feed to classifier

%TODO
%   everything!!


Character = segmeter2('images/dataset_proc/oren_9.jpg');
Im = imread('images/dataset_proc/oren_9.jpg');


someBox = Character(20).BoundingBox()
%http://www.mathworks.com/help/toolbox/images/ref/regionprops.html#bqkf8hf


box = floor(someBox)%??Iono why bounding box has non-integer fields

%imagesc( Im(238:238+35,842:842+62)) %character(20) from oren_9
imagesc( Im( box(1):box(1)+box(3),box(2):box(2)+box(4)))