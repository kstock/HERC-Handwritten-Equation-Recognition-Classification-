%This loops through the toy dataset and tries to get rid of the
%bounding boxes
%passes the ds_# original scans though oren's removeboder script 
%commented out code from the first try
%merge with removeborder?


colormap(gray)

for i = 1:10
    
    test = imread( strcat( 'ds_',int2str(i),'.jpg') );
    test = rgb2gray(test);
    
    test = removeborder(test);
      
    imwrite(test,strcat('oren_',int2str(i),'.jpg'),'jpg');
    %imagesc(test)

end

%{
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
%}