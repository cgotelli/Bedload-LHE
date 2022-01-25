% writeImage saves acquired images to different files with the given extension/format. It is called by
% saveImageData.
% 

function writeImage(data, n , fileName, relativeFrame, extension)

for i = 1:n
    
    fullFileName = fullfile(fileName, strcat('frame', sprintf(strcat('_%010d','.',extension), relativeFrame + i - 1)));
    
    imwrite(data(:, :, :, i), fullFileName, extension);
    
end

end