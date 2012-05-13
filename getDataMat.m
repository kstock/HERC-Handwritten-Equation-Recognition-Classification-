%INPUT: (optional): 'folder/location/of/file/as/string/'
%
%IF NO ARG:
%reads files oren_1..oren_10

%OUTPUT: returns data_x of character samples
%                                 data_y of class #
% data_x is of HOG-ified (histogram of oriented gradients) samples
%



%TODO:
%       fix function call stuff
%       make sure kyle didn't fuck it up -kyle
%       I think 2 arg was just a big mistake, not sure
%           what does anymore, was supposed to do
%           some of the stuff in proto.m
%       try different feature extractors (HOG,SIFT?)
%       mess with HOG params
%       fix figure window that pops up!!!
%       de-hardcode some values (search HARDCODED)
%       fix class # so class 1 is char one (more prob with pic #ing)


function [data_x data_y] = getDataMat(varargin)

    %check for input
    nVarargs = length(varargin);
    if nVarargs == 0
        %Read this image if no input provided 
        test = imread( 'images/dataset_proc/oren_9.jpg');%read to get size for loop
        num_files = 10;%default for toyset 1
        data_x = zeros(1000,81);%HARDCODED
        %data_x = zeros(1000,512);%HARDCODED
        data_y = zeros(1000,1);
    elseif strcmp(varargin{1},'directory')%if arg provided, assumes correct input in arg2:/
        jpg_list = dir( strcat(varargin{2},'*.jpg') );%get all jpgs!!
        filenames = cell(1,nVarargs-1);
        for i = 1:length(jpg_list)%make cell array of img paths
            filenames{i} = strcat(varargin{2},jpg_list(i).name);
        end
        test = imread(filenames{1});%read to get size for loop
        num_files = length(filenames);%how many times to loop!
        data_x = zeros(num_files * 100,81);%HARDCODED
        data_y = zeros(num_files * 100,1);       
    else %not directory, just get all the path args
        filenames = cell(1,nVarargs);
        for i = 1:length(filenames)%make cell array of provided img paths
            filenames{i} = varargin{i};
        end
        test = imread(filenames{1});%read to get size for loop
        num_files = length(filenames);%how many times to loop!
        data_x = zeros(num_files * 100,81);%HARDCODED
        data_y = zeros(num_files * 100,1);        
    end

    
    %1000 examples 
    %each with r_len * c_len points
    %data_x = zeros(1000,r_len * c_len);
    
    
    %TODO HARDCODED: fix hardcoded 81
    %there must be settings in the HOG.m file to be tweaked
    %data_x = zeros(1000,81);
    %data_y = zeros(1000,1);

    

    colormap(gray);
    

    %get size info
    [r,c] = size(test);

        
    r_len = floor(r/10);
    c_len = floor(c/10);
    
       
    class = 1;
    data_row = 1;

    %sample_num = 200;
    %tempNAME = 'leftParen';%1,3,;
for file = 1:num_files

    %one arg provided then grab class name from end of file for getClass switch:
    %EX: 'images/logic/exist_1.jpg' -> 'exist'
    if nVarargs ~= 0
       name = regexp(filenames{file},'([^/]*)_','tokens');%returns cell of (captured) 
       class =  getClass( char(name{1}));%convert cell array{1} -> string
       
    %no arg, then grab this default value from prehistoric script times
    else
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
%        binSize = 8 ;
%        magnif = 3 ;
%        Is = vl_imsmooth(single(temp), sqrt((binSize/magnif)^2 - .25)) ;
%        [f,d] = vl_sift(Is);
%        temp2 = d(:);
        
%       'size_temp2'
%       size(temp2)
    
%       if (length(temp2) < 512)
%           temp2 = [temp2; zeros(512 - length(temp2),1)];        
%       end
           
        temp2 = temp2';
 %       size(temp2);
        data_x(data_row,:) = temp2;
        data_y(data_row) = class;

        data_row = data_row + 1;

        %UNCOMMENT TO write out one image for every sample
        %if nVarargs ~= 0
        %    %imwrite(temp,strcat(int2str(name),'_',int2str(sample_num),'.jpg'),'jpg');
        %    imwrite(temp,strcat(tempNAME,'_',int2str(sample_num),'.jpg'),'jpg');
        %    sample_num = sample_num + 1;
        %end
        
        r = r + r_len;
        if r > r_len * 10 %wrap around, new row
            r = r_len;
            c = c + c_len;
            
            if nVarargs == 0 %for script functionality...
                class = class + 1;
            end
        end

    end
    
    if nVarargs == 0 %for script functionality...

        if file < 5
            class = 1;
        else
            class = 11;
        end
    end
    
    

    
end

end %function 