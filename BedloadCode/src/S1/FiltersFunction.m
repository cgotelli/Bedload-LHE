%% Filtering images
% This function doesn't include the last modifications. It doesn't include
% the watershed transformation applied in the new filter.

function [filtered_images] = FiltersFunction(data, xdim,ydim, n, GaussFilterSigma, ...
    FilterDiskSize, DilatationDiskSize, minSize)
%
filtered_images = false(ydim, xdim, n);

for i = 1:n

    if length(size(data)) == 4
        img = rgb2gray(data(:,:,:,i)); % Reads the image number i.
    else
        img = data(:,:,i);
    end

    img = imgaussfilt(img, GaussFilterSigma, 'FilterSize', 5); % Gaussian filter with given sigma parameter
    img = imbothat(img,strel('disk', FilterDiskSize)); % Applies bothat filter. This function is for dark particles over a light background.
    img = imbinarize(img, max(0.02, min(graythresh(img),0.1))); % Turn the image into B&W format (logical). The threshold depends on the image.
    img = bwareaopen(img, minSize);        % Removes small objects from image smaller than "low_boundary" number of pixels.
    % imfill(~img,'holes') ;
    if DilatationDiskSize ~= 0
        img = imdilate(img,strel('disk',DilatationDiskSize)); % Dilates white pixels/particles to give a rounded shape.
    end
    filtered_images(:,:,i) = img;          %9/11/2021 modification: '= img' replaces '= ~img'
end
end