    
%reads files oren_1..oren_10, creates data_x of character samples
%                                     data_y of class #
%
%
%TODO:
%       fix figure window that pops up!!!
%       de-hardcode some values
%       fix class # so class 1 is char one (more prob with pic #ing)

    colormap(gray);


    %get size info
    test = imread( 'oren_1.jpg' );
    [r,c] = size(test);

        
    r_len = floor(r/10);
    c_len = floor(c/10);
    

    %1000 examples 
    %each with r_len * c_len points
    data_x = zeros(1000,r_len * c_len);
    data_y = zeros(1000,1);

       
    class = 1;
    data_row = 1;

for file = 1:10

    test = imread( strcat('oren_', int2str(file),'.jpg') );
    
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

        
        temp2 = reshape(temp,1,r_len*c_len);

        data_x(data_row,:) = temp2;
        data_y(data_row) = class;

        data_row = data_row + 1;


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
    %}

    %imagesc(test)

    %test = test(:,1:20);
    %test = reshape(test,1,400);

    %test = double(test);

    %predict(Theta1,Theta2,test)