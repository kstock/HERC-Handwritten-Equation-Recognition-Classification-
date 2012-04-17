%TODO:
%      make this into a dataset generator, apply transformations
%           (blur?jittering?affine?linear?) to images
%
%
%possibly helpful:
%http://www.csse.uwa.edu.au/~pk/research/matlabfns/
%http://blogs.mathworks.com/steve/category/spatial-transforms/
%http://www.mathworks.com/help/toolbox/images/ref/imrotate.html

%http://www.mathworks.com/products/demos/image/create_gallery/tform.html
%playing, problem with things resizing,cropping and adding black( 0
%filling)
%
%
%Try varying these 4 parameters.
scale = 1.2;       % scale factor
angle = 40*pi/180; % rotation angle
tx = 0;            % x translation
ty = 0;            % y translation

sc = scale*cos(angle);
ss = scale*sin(angle);

T = [ sc -ss;
      ss  sc;
      tx  ty];
