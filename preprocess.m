%INPUT: type string: 'directory/string/

%OUTPUT: nothing, fake return 1

%Gets all *.ext in a folder, runs removeborder on them then overwrites
%them.
%
function [ret] = preprocess(directory)
%directory = 'images/logic/';



colormap(gray)

files = dir( strcat(directory,'*.jpg'));

for i = 1:length(files)
    
    name = files(i).name;
    
    test = imread( strcat(directory,name) );
    
    %if rgb, make gray
    if length(size(test)) == 3
        test = rgb2gray(test);
    end
    
    test = removeborder(test);
    
    
    test(test >= 230) = 255;
    test(test < 230) = 255;
    
    imwrite(test,strcat(directory,name),'jpg');
    %imagesc(test)

end
ret = 1;% :( stupid, this is only a void function needs no return really

end%function