%code stolen from:
%http://stackoverflow.com/questions/6972918/detect-a-rectangle-bound-of-an-
%character-or-object-in-black-white-or-binary-imag
%TODO:

%1)   understand fully how this works
%       bwlabel:
%       http://www.mathworks.com/help/toolbox/images/ref/bwlabel.html

%2)   extract through bounding boxes
%       then pad to same size as images for classifier!
%

%3)   get pics of results, post to blog with explanations

%PROBLEMS:
%   identifiers extra "characters"



%Read image
Im = imread('proc_5.jpg');

Im_saved = Im; %added by me
%Im = Im(1:159,:);


%Make binary
Im(Im < 128) = 1;
Im(Im >= 128) = 0;

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
    if D.Area > 10
        nrValidDetections = nrValidDetections + 1;
        Character(nrValidDetections).BoundingBox = D.BoundingBox;
    end
end


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

end
