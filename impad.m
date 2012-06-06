%IMPAD pad a grayscale image with whitespace
%   I = impad(I,[s1 s2]) pads a grayscale image with a whitespace
function [B] = impad(I,s)
    v = 255; %white
    B = ones(s)*v;
    
    %check size of new image is greater than original
    if(size(I,1) > s(1))
        error('s(1) too small');
    elseif(size(I,2) > s(2))
        error('s(2) too small');
    end
    
    lc1 = floor(s(1)/2) - floor(size(I,1)/2);
    lc2 = floor(s(2)/2) - floor(size(I,2)/2);
    B(lc1:lc1+size(I,1)-1,lc2:lc2+size(I,2)-1) = I;
    %colormap(gray);
    %imagesc(B);
end