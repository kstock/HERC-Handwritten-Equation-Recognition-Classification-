%code stolen from:
%http://stackoverflow.com/questions/6972918/detect-a-rectangle-bound-of-an-
%character-or-object-in-black-white-or-binary-imag

%INPUT: 
%     (optional)string that is the location of an image
%               if none is provided, 'images/dataset_proc/oren_9.jpg' is
%               used

%OUTPUT:
%       Character:  struct array with fields: BoundingBox
%

%TODO:
%0) fix name! segmeter2 -> segmenter
%1)   understand fully how this works
%       bwlabel:
%       http://www.mathworks.com/help/toolbox/images/ref/bwlabel.html

%2)   extract through bounding boxes
%       then pad to same size as images for classifier!
%

%PROBLEMS:
%   identifiers extra "characters"

function [Character] = segmeter2(varargin)

%check for input
nVarargs = length(varargin);

if nVarargs == 0
    %Read this image if no input provided 
    Im = imread('images/dataset_proc/oren_9.jpg');
    %Im = imread('equation1.jpg');
else
   %if arg provided, read first input  
%   Im = imread(str(varargin(1)));
   Im = imread(varargin{1});

end


Im_saved = Im; %added by me
%Im = Im(1:159,:);


%Make binary
Im(Im < 190) = 1;  %changed the threshold value from 128 to 190
Im(Im >= 190) = 0;


%Segment out all connected regions
ImL = bwlabel(Im); 

%Get labels for all distinct regions
labels = unique(ImL);

%Remove label 0, corresponding to background
labels(labels==0) = [];

%Get bounding box for each segmentation
Character = struct('BoundingBox',zeros(1,4));
nrValidDetections = 0;
for i=1:length(labels)
    D = regionprops(ImL==labels(i));
    if (D.Area > 100)
        nrValidDetections = nrValidDetections + 1;
        Character(nrValidDetections).BoundingBox = D.BoundingBox;
    end %end if
end%end for i=1:length(labels) 


%Visualize results
figure(1);
%imagesc(ImL); %removed by me
colormap('gray') %added by me
imagesc(Im_saved); %added by me


%xlim([0 200]); %no idea what this does yet, but it fucks shit up

for i=1:nrValidDetections
    rectangle('Position',[Character(i).BoundingBox(1) ...
                          Character(i).BoundingBox(2) ...
                          Character(i).BoundingBox(3) ...
                          Character(i).BoundingBox(4)]);
    %str = sprintf('%d',i);
    %text(Character(i).BoundingBox(1), Character(i).BoundingBox(2), str);

end %end for i=1:nrValidDetections
pause


end%end function
