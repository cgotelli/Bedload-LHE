%% Exporting images as Matfile

function FrameToMatfile(data, matfilesPath, metadata)

RAW_images = squeeze(data);

save(fullfile(matfilesPath, strcat('RAWimages_', sprintf('%010.0f', metadata(1).FrameNumber), 'to', ...
    sprintf('%010.0f', metadata(numel(metadata)).FrameNumber), '.mat')), 'RAW_images', '-v7.3')

end