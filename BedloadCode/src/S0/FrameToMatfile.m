% Exporting images as Matfile
% This function exports the given data to a matfile in the given folder path. It need the metadata of the
% video object to set the name of the file.

function FrameToMatfile(data, matfilesPath, metadata)

RAW_images = squeeze(data);

save(fullfile(matfilesPath, strcat('RAWimages_', sprintf('%010.0f', metadata(1).FrameNumber), 'to', ...
    sprintf('%010.0f', metadata(numel(metadata)).FrameNumber), '.mat')), 'RAW_images', '-v7.3')

end