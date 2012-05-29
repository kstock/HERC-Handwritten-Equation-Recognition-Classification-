%Gets all *.ext in a folder, thresholds to black and white
function bw = bwthresh(directory)
%directory = 'images/logic/';

    files = dir( strcat(directory,'*.jpg'));
    
    for i = 1:length(files)
    
        name = files(i).name;
        test = imread( strcat(directory,name) );
    
        %threshold to black and white at a value of 200
        test(test < 200) = 0;
        test(test >= 200) = 255;
    
        imwrite(test,strcat(directory,name),'jpg');
    end
end