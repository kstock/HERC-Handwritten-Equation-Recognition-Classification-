%INPUT: (optional): 'folder/location/of/file/as/string/'
%
%IF NO ARG:
%reads files oren_1..oren_10

%OUTPUT: returns data_x of character samples
%                                 data_y of class #
% data_x is of HOG-ified (histogram of oriented gradients) samples
%
%
%TODO:
%       try different feature extractors (HOG,SIFT?)
%       fix data_y creation ?with extra params?
%       mess with HOG params
%       fix figure window that pops up!!!
%       de-hardcode some values (search HARDCODED)
%       fix class # so class 1 is char one (more prob with pic #ing)
function [data_x data_y] = getDataMat(varargin)


    %1000 examples 
    %each with r_len * c_len points
    %data_x = zeros(1000,r_len * c_len);
    
    
    %TODO HARDCODED: fix hardcoded 81
    %there must be settings in the HOG.m file to be tweaked
    data_x = zeros(1000,81);
    data_y = zeros(1000,1);


    %check for input
    nVarargs = length(varargin);

    if nVarargs == 0
        %Read this image if no input provided 
        test = imread( 'images/dataset_proc/oren_1.jpg' );
        num_files = 10;
    else
       %if arg provided, read first input  
        %test = imread(str(varargin(1)));
        test = imread(varargin{1});
        num_files = 1;
        data_x = zeros(100,81);
        data_y = zeros(100,1);
    end


    colormap(gray);
    

    %get size info
    [r,c] = size(test);

        
    r_len = floor(r/10);
    c_len = floor(c/10);
    
       
    class = 1;
    data_row = 1;

%    sample_num = 0;
for file = 1:num_files

    
    %no arg, then grab all these files,else already set
    if nVarargs == 0
        test = imread( strcat('images/dataset_proc/oren_', int2str(file),'.jpg'));
    end
    
    
    %make it so that m,n end in a 0
    %fixes errors in matrix size
    test = test(1:r_len * 10, 1: c_len* 10);

    %init var for loop thu page
    r = r_len;
    c = c_len;
    

    while c <= c_len * 10


        %if first row
        if c - c_len <= 0

            %if first cell in row
            if r - r_len <= 0
                temp = test(1:r,1:c);
            else
                temp = test(r - r_len + 1:r,1:c); 
            end


        %if second row    
        else
            %if first cell in row
            if r - r_len <= 0
                temp = test(1:r,c - c_len + 1:c);
            else
                temp = test(r - r_len + 1:r,c - c_len + 1:c); 
            end
        end
        
        
        %for when we were using plain pixels
        %the results of this is now plain_pixels_data_x.mat
        %temp2 = reshape(temp,1,r_len*c_len);

        

        temp2 = HOG(temp);
        
        data_x(data_row,:) = temp2';
        data_y(data_row) = class;

        data_row = data_row + 1;

        %UNCOMMENT TO write out one image for every sample
        %imwrite(temp,strcat(int2str(class),'_',int2str(sample_num),'.jpg'),'jpg');
        %sample_num = sample_num + 1;

        r = r + r_len;
        if r > r_len * 10 %wrap around, new row
            r = r_len;
            c = c + c_len;
            class = class + 1;
        end


    end
    
    if file < 5
        class = 1;
    else
        class = 11;
    end
    

    
end

end %function 