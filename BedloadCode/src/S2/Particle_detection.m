% Particle detection
% Detects all particles on each image. 
% - It depends on the minimum size to consider a cluster of pixels as a
% particle. 
% - It also receives the folder path where to save the images, and the name of the file to process.
% - Returns an array with all detected particles including the following parameters:
% [index of the image; area; Centroid's x-coordinate; Centroid's y-coordinate; MajorAxis; Minor Axis]

function [particles] = Particle_detection(img_array, low_boundary, SavePath, filename)

% If it is a single image
if size(img_array, 3) == 1
        
    img = img_array;                            % Assigns the input array
    img = bwareaopen(img, low_boundary);        % Removes small objects from image smaller than "low_boundary" number of pixels.
    img = imclearborder(img, 8);                % Supress points touching the borders of the image
    s = regionprops(img, 'Area', 'Centroid', 'MajorAxisLength', 'MinorAxisLength'); % Extracts properties from all particles
    areas = cat(1, s.Area);                     % Stores areas
    centroids = cat(1, s.Centroid);             % Stores centroids
    %MajorAxisLength = cat(1, s.MajorAxisLength);% Stores major axis of particles
    %MinorAxisLength = cat(1, s.MinorAxisLength);% Stores minor axis of particles
    
    % Stores all this information into one matrix
    particles = [areas(:) , centroids(:, :)]; 
    
else
    
    % If it is more than one image (an array of images)
    particles = [];                                 % Empty array for particles
    
    for i = 1:size(img_array, 3)                    % Loop over images
        
        img = img_array(:, :, i);                   % Loads image
        img = bwareaopen(~img, low_boundary);       % Delete smaller particles, smaller than given boundary
        %img = imclearborder(img, 8);                % Deletes particles touching border
        s   = regionprops(img, 'Area', 'Centroid'); % Dets properties for all particles
        areas       = cat(1, s.Area);               % Gets areas
        centroids   = cat(1, s.Centroid);           % Get centroids
        %MajorAxisLength = cat(1, s.MajorAxisLength);% Get major axis lenght
        %MinorAxisLength = cat(1, s.MinorAxisLength);% Get minor axis lenght
        
        % Saving information of every particle in one single array. [frame number, area, centroid's x coordinate, centroid's y coordinate, Major Axis Length, Minor Axis Length]
        if isempty(areas(:))
        
            particles = [particles; i, 0 , 0, 0];  % In case there are no particles in the picture
        
        else
            
            particles = [particles; (i)*ones(length(areas(:)), 1), areas(:) , centroids(:, :)]; % all together in one growing array
        
        end
        
    end
    
end

save(fullfile(SavePath, strcat('Particles_', filename(10:end))), 'particles'); % save Particles information as backup.

end
