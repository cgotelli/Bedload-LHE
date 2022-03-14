function RAW_images = mat2im(imgMatfile, savePath, extension)


for i = 1:length(imgMatfile) 
    imwrite(imgMatfile(:,:,i),fullfile(savePath, strcat('frame', sprintf(strcat('_%010d','.',extension), i))))
    
    
end
end