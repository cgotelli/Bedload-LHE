function [particles] = Particles(img_array, low_boundary, folder,filename)
% Detects all particles on each image. It depends on the minimum size to consider a cluster of pixels as a
% particle.
% Returns a list of all detected particles with the following parameters:
% [index of the image; area; x; y; MajorAxis; Minor Axis]

% If it's only one image
if size(img_array, 3) == 1
    fprintf('Only one image\n') % Prints a message
    img = img_array;
    img = bwareaopen(img, low_boundary);
    img = imclearborder(img, 8);
    s = regionprops(img, 'Area', 'Centroid', 'MajorAxisLength', 'MinorAxisLength');
    areas = cat(1, s.Area);
    centroids = cat(1, s.Centroid);
    MajorAxisLength = cat(1, s.MajorAxisLength);
    MinorAxisLength = cat(1, s.MinorAxisLength);
    particles = [areas(:) , centroids(:, :), MajorAxisLength(:), MinorAxisLength(:)];

    % If it's a sequence of images    
else
    fprintf("It's an array of images\n") % Prints a message
    particles = []; % Empty array for particles
    for i = 1:size(img_array, 3) % Loop over images
        img = img_array(:, :, i); % Loads image
        img = bwareaopen(~img, low_boundary); % Delete smaller particles, smaller than given boundary
        img = imclearborder(img, 8); % Deletes particles touching border
        s = regionprops(img, 'Area', 'Centroid', 'MajorAxisLength', 'MinorAxisLength'); % Dets properties for all particles
        areas = cat(1, s.Area); % Gets areas
        centroids = cat(1, s.Centroid); % Get centroids
        MajorAxisLength = cat(1, s.MajorAxisLength); % Get major axis lenght
        MinorAxisLength = cat(1, s.MinorAxisLength); % Get minor axis lenght
        % Saving information of every particle in one single array. [frame number, area, centroid's x coordinate, centroid's y coordinate, Major Axis Length, Minor Axis Length]
        if length(areas(:)) == 0
            particles = [particles; i, 0 , 0,0, 0, 0];  %in case there is no particles in the picture
        else
            particles = [particles; (i)*ones(length(areas(:)), 1), areas(:) , centroids(:, :), MajorAxisLength(:), MinorAxisLength(:)]; % all together in one growing array
        end
    end
end
save(fullfile(folder, strcat('Particles_', filename)), 'particles'); % save Particles information as backup.
end