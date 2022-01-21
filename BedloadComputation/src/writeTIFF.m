function writeTIFF(data, n , fileName, relativeFrame)
% writeTIFF saves acquired images to separate TIFF files.
%
% writeTIFF is called by saveImageData.

for ii = 1:n
    fullFileName = fullfile(fileName,strcat('frame',sprintf('_%010d.tif', relativeFrame + ii - 1)));
    imwrite(data(:,:,:,ii), fullFileName, 'tiff');
end

end