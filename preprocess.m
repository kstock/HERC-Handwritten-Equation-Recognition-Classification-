%This loops through the toy dataset and tries to get rid of the
%bounding boxes
%currently it gets rid of the first few, then starts to miss parts later
%due to the scans not being correctly aligned

colormap(gray)

for i = 1:10
    
    test = imread( strcat( 'ds_',int2str(i),'.jpg') );
    test = rgb2gray(test);

   
    col = 1;
    
    white_width = 15;
    
    for j = 1:10
       
        test(:,col:col+white_width) = 255;%255 is white
        
        col = col + floor(n/10);
    end
    
    row = 1;
    for j = 1:10
       
        test(row:row+white_width,:) = 255;%255 is white
        
        row = row + floor(m/10);
    end
    
    
    size(test)
    imwrite(test,strcat('proc_',int2str(i),'.jpg'),'jpg');
    %imagesc(test)

end