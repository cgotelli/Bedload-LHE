
function videoMatfile = vid2mat(filePath)

splits = regexp(filePath,filesep,'split');
folderPath = fullfile(splits{1:end-1});
vid     = VideoReader(filePath);            %open the video
videoMatfile = read(vid);                   %read frame by frame
RAW_images = squeeze(videoMatfile);
save(fullfile(folderPath,splits{end}(1:end-4)), 'RAW_images', '-v7.3');

end