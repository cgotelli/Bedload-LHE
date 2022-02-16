% Particle filtering
% Filters particles for later calculation of mean velocity following the same algorithm
% used by Zimmermann.
% - It receives the array with the detected particles on each frame. The received array has
% the following structure: [frame number, area, centroid's x coordinate, centroid's y coordinate, Major Axis
% Length, Minor Axis Length]
% - It also receives the parameters for the filtering process. These parameters must be set by a
% previous calibration process.
% - It returns a table with all filtered particles including the following
% parameters: [image index; area; x; y; MajorAxis; Minor Axis]

function final_particles = Particle_filtering(particles_array, height, width, distMin, areamin, areamax, ...
    lim_width, lim_height, maxparticles)


num_frames  = particles_array(end, 1);            % Total number of frames to process
minSize     = areamin*mean(particles_array(:,2)); % Minimum particle size to use.
maxSize     = areamax*mean(particles_array(:,2)); % Maximum particle size to use.

% Within a zone far from borders
filtered_particles = particles_array(particles_array(:,3) > lim_width*width,:);                         % 10% of the size away from left border
filtered_particles = filtered_particles(filtered_particles(:,3) < (1-lim_width)*width,:);   % 10% of the size away from right border
filtered_particles = filtered_particles(filtered_particles(:,4) > lim_height*height,:);     % of the size away from top border
filtered_particles = filtered_particles(filtered_particles(:,4) < (1-lim_height)*height,:); % of the size away from bottom border

% Selection by size. The main idea is to select particles that represents the mean behaviour.
filtered_particles = filtered_particles(filtered_particles(:,2) < maxSize,:);
filtered_particles = filtered_particles(filtered_particles(:,2) > minSize,:);

% tic
% Conditions to fill the matrix based on the number of particles detected on each frame.
if isempty(filtered_particles) % If no particle is detected in any image inside the array: creates an array of zeros and the index of the image inside the array.
    
    filtered_particles = [linspace(1,num_frames,num_frames)', zeros(1,num_frames)', zeros(1,num_frames)', zeros(1,num_frames)'];
    
else % If its not empty, checks on each frame if it has particles or not. If it doesn't detect any particle, fills with a row of zeros at the end of the matrix.
    
    for h = 1:num_frames
        
        if isempty(filtered_particles(filtered_particles(:, 1) == h))
            filtered_particles = [filtered_particles(1:h-1, :); h, 0, 0, 0; filtered_particles(h:end, :)];
            %             filtered_particles = [filtered_particles; h, 0, 0, 0];
            
        end
        
    end
    
end

% To check how many filtered particles are left per image. In average it should be around 11 (based on
% Zimmermann). To check this, use breakpoints in any of the following 4 lines.
a   = unique(filtered_particles(:, 1));
out = [a, histc(filtered_particles(:, 1), a)];
partnum_mean    = mean(out(:, 2));
partnum_std     = std(out(:, 2));

% Filtering particles by the distance with the closest particles.
aux = 0; % Aux variable
final_particles = []; % Initiates array for final particles

for h = 1:num_frames % Loop over all frames
    
    % For each frame it looks for all particles that have at least one particle within a minimal distance to
    % skip them. Idx and D are cells.
    [Idx,D] = rangesearch(filtered_particles(filtered_particles(:, 1) == h, 3:4), ...
        filtered_particles(filtered_particles(:, 1) == h, 3:4), distMin);
    % Once it has the list of those particles, selects all the rest.
    
    aux2 = 0;
    % Loop over each particle within the image.
    for k = 1:length(D)
        % Gets the number of particles within the range. It's at least 1, because the particle itself it's
        % inside that range.
        tam = size(Idx{k});
        
        if tam(2) == 1 % If there is only one particle inside the circle (the particle itself), it saves the data.
            
            final_particles = [final_particles; filtered_particles(k+aux, 1:4)];  %19/10/2021 modif to return also minor and major axis lengths
            aux2 = aux2 + 1;
        end
        
        if aux2 == maxparticles
            
            break
            
        end
        
    end
    
    aux = aux + length(D); % updates the particle's position index
    
end

end
