%% Filtering images
% This function doesn't include the last modifications. It doesn't include
% the watershed transformation applied in the new filter.

function [filtered_images] = FiltersFunction(data, xdim,ydim, n, GaussFilterSigma, ...
    FilterDiskSize, DilatationDiskSize, minSize)
%
filtered_images = false(ydim, xdim, n);

xlc = [50 35 1 1];
ylc = [500 0 0 500];
xrc = [2712 2712 2685 2677 ];
yrc = [0 500 500 0];
masklc = poly2mask(xlc,ylc,500,2712);
maskrc = poly2mask(xrc,yrc,500,2712);
complete_mask = masklc + maskrc;

for i = 1:n

    if length(size(data)) == 4
        img = rgb2gray(data(:,:,:,i)); % Reads the image number i.
    else
        img = data(:,:,i);
    end

    img = imgaussfilt(img, GaussFilterSigma, 'FilterSize', 21); % Gaussian filter with given sigma parameter
    %     img = medfilt2(img);
    img = imbothat(img,strel('disk', FilterDiskSize)); % Applies bothat filter. This function is for dark particles over a light background.
    img = imadjust(img);
    %img = imbinarize(img, max(0.02, min(graythresh(img),0.1))); % Turn the image into B&W format (logical). The threshold depends on the image.
    img = imbinarize(img, graythresh(img)); % Turn the image into B&W format (logical). The threshold depends on the image.
    img = bwareaopen(img, minSize);         % Removes small objects from image smaller than "low_boundary" number of pixels.
    img = img.*~complete_mask;

    % imfill(~img,'holes') ;
    if DilatationDiskSize ~= 0
        img = imdilate(img,strel('disk',DilatationDiskSize)); % Dilates white pixels/particles to give a rounded shape.
    end
    filtered_images(:,:,i) = img;          %9/11/2021 modification: '= img' replaces '= ~img'
end
end