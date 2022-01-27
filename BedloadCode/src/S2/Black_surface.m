% Black_surface
% Calculates the black area corresponding to the particles surface
% - It receives the array of filtered images, the resolution of images, the folder's path where to export the
% information, and the name of the file to process.

function black_surface = Black_surface(filtered_images, xdim, ydim, SavePath, filename)

n = size(filtered_images, 3);   % Total number of frames to process

black_surface = zeros(n, 1);       % Empty array for storing information

for i = 1:n                     % Loop over all frames
    
    black_surface(i, 1)= xdim*ydim - sum(sum(filtered_images(:, :, i))); % Number of pixels - Number of white pixels
    
end

save(fullfile(SavePath, strcat('BS_', filename(10: end))), 'black_surface'); % Saves black surface array

end
