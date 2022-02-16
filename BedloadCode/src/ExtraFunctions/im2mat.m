% Funtion that takes all images of given extension inside a folder and saves them into a matfile
function RAW_images = im2mat(filesPath, extension)

filenames = dir(fullfile(filesPath, strcat('*.', extension)));
img = imread(fullfile(filenames(1).folder, filenames(1).name));
RAW_images = zeros([size(img), length(filenames)], 'uint8');
RAW_images(:,:,1) = img;

for i = 2:length(filenames) 

    img = imread(fullfile(filenames(i).folder, filenames(i).name));
    RAW_images(:, :, i) = img;
    
end
save(fullfile(filesPath, 'imagesMatfile.mat'), 'RAW_images', '-v7.3');
end
