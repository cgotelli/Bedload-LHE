%modifications: line 6-7 inversion of xdim and ydim (apparently images are stored in the opposite way as expected, line 9-10 and 17 addition of a line rgb2gray (images need to be in gray)

%% Filtering images
function [x] = Filters(data, xdim,ydim, n, GaussFilterSigma,FilterDiskSize,DilatationDiskSize)
% 
x=false(ydim,xdim,n);
%x = false(xdim,ydim,n);
for i = 1:n
	%img = data(:,:,:,i);
	img = data(:,:,i);
    img = imgaussfilt(img,GaussFilterSigma); % Gaussian filter with given sigma parameter
	img = imbothat(img,strel('disk',FilterDiskSize)); % Applies bothat filter. This function is for dark particles over a light background.

    %Maxime's filters
%     T = adaptthresh(img,0.4,'ForegroundPolarity','dark');
% 	img = imbinarize(img, T); % Turn the image into B&W format (logical). The threshold depends on the image.
%    img = rgb2gray(img);
    img = ~imbinarize(img, graythresh(img)); % Turn the image into B&W format (logical). The threshold depends on the image.
    img = imdilate(img,strel('disk',DilatationDiskSize)); % Dilates white pixels/particles to give a rounded shape.
    x(:,:,i) = img;
end
