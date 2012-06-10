%takes a square image and removes the grid
function [rb] = removeborder(I)
    gridsize = 10;

    rb = I;
    [a b] = size(rb);
    ydiff = floor(a/10);
    xdiff = floor(b/10);
    margin = 33;
    
    for ii = 1:gridsize+1
        startx = floor((ii-1)*xdiff)-floor(margin/2);
        starty = floor((ii-1)*ydiff)-floor(margin/2);
        
        
        if(startx < 1)
            startx = 1;
        end
        endx = startx + margin;
        
        if(starty < 1)
            starty = 1;
        end
        endy = starty + margin;
        
        if(endx+margin > b)
            endx = b;
        end
        
        if(endy+(margin) > a)
            endy = a;
        end
        
        
        rb(starty:endy,1:b) = 255;
        rb(1:a,startx:endx) = 255;
        
    end

    %imshow(rb)
    %size(rb)
end