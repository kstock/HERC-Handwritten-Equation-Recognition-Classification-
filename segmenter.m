% This is a program for extracting objects from an image. Written for vehicle number     plate segmentation and extraction
% Authors : Jeny Rajan, Chandrashekar P S
% U can use attached test image for testing
% input - give the image file name as input. eg :- car3.jpg
clc;
clear all;
%k=input('Enter the file name','s'); % input image; color image
im=imread('proc_1.jpg');
 im1 = im(1:159,:);
%im1=rgb2gray(im);
im1=medfilt2(im1,[3 3]); %Median filtering the image to remove noise%
BW = edge(im1,'sobel'); %finding edges 
[imx,imy]=size(BW);
msk=[0 0 0 0 0;
 0 1 1 1 0;
 0 1 1 1 0;
 0 1 1 1 0;
 0 0 0 0 0;];
B=conv2(double(BW),double(msk)); %Smoothing  image to reduce the number of connected     components
L = bwlabel(B,8);% Calculating connected components
mx=max(max(L))
% There will be mx connected components.Here U can give a value between 1 and mx for L     or in a loop you can extract all connected components
% If you are using the attached car image, by giving 17,18,19,22,27,28 to L you can     extract the number plate completely.
[r,c] = find(L==17);  
rc = [r c];
[sx sy]=size(rc);
n1=zeros(imx,imy); 
for i=1:sx
x1=rc(i,1);
y1=rc(i,2);
n1(x1,y1)=255;
end % Storing the extracted image in an array
figure,imshow(im);
figure,imshow(im1);
figure,imshow(B);
figure,imshow(n1,[]);