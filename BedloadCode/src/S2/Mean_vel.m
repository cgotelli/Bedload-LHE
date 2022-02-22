% Mean_vel
% Calculates the velocity matching particles between frames i and (i+1).
% - It receives the array of filtered particles, the parameters for doing the match of particles between
% frames, the path where to save the outputs, and the name of the file to process.
% - It returns the velocitiy of each particle frame by frame, and the mean velocity of this particles also
% frame by frame.

function [velocity, mvel] = Mean_vel(camera, final_particles, distMin, distMax, dt, difs_th, x_dev, ...
    SavePath, filename)

num_frames  = final_particles(end,1,1); % Total number of frames to process
pairs       = [];                       % Empty array for pairs of particles
mvel        = zeros(num_frames-1,2);    % Empty array for mean velocity (the last frame is not counted as there is no num_frames+1 frame to compute the velocity)

for i = 1:num_frames-1                  % For loop over the first n-1 frames.
    
    % Frame i
    areas1  = final_particles(final_particles(:, 1) == i, 2); % Gets areas from all particles in frame i
    iks1    = final_particles(final_particles(:, 1) == i, 3); % Gets centroid's x coordinates for particles in frame i
    igrec1  = final_particles(final_particles(:, 1) == i, 4); % Gets centroid's y coordinates for particles in frame i
    
    %Frame i+1
    areas2  = final_particles(final_particles(:, 1) == i + 1, 2); % Gets areas from all particles in frame i+1
    iks2    = final_particles(final_particles(:, 1) == i + 1, 3); % Gets centroid's x coordinates for particles in frame i+1
    igrec2  = final_particles(final_particles(:, 1) == i + 1, 4); % Gets centroid's y coordinates for particles in frame i+1
    
    aux = 0; % Aux variable
    
    % For each particle in frame i, tries to find one particle that fullfills all requierements in frame i+1.
    % Once it reaches this condition, continues to the next particle in frame i.
    for j = 1:size(iks1)
        
        for k = 1:size(iks2)
            
            if strcmp(camera, "LESO") % Particles going from top to bottom
                
                difs = (log2(areas1(j))-log2(areas2(k)))/log2(areas1(j)); % Difference in areas
                
                % If the absolute difference between areas is lower than the threshold, and the position in y
                % for the particle in i+1 lies beyond the given radius for the particle in frame i, and the
                % position in x for the particle in fram i+1 lies within the requiered range for the particle
                % in frame i; then you have a match.
                if abs(difs) < difs_th && ...
                        igrec1(j) + distMin < igrec2(k) && ...
                        abs(iks1(j) - iks2(k)) < x_dev % This 10 it's to be sure that we have "straight" paths
                    % If there is a match, you calculate the distance between centroids. This distance is in px!.
                    
                    distance = pdist([iks1(j), igrec1(j); iks2(k), igrec2(k)], 'euclidean');
                    
                    % If the distance is within range, you finally establish a pair of particles and continue with
                    % the next particle in frame i.
                    if distance > distMin && distance < distMax
                        
                        vel = distance/dt; % Velocity (in px!)
                        
                        % Add all information to an array. This way it is possible to track the particles in the
                        % images and check validity of the results. The structure of the array is as shown below:
                        % pairs = [frame number, i-frame centroid's x-coordinate, i-frame centroid's y-coordinate,
                        % (i+1)-frame centroid's-x coordinate,(i+1)-frame centroid's y-coordinate,
                        % distance between particles, velocity, difference of areas]
                        pairs = [pairs; i, iks1(j), igrec1(j), iks2(k), igrec2(k), distance, vel, difs];
                        
                        aux = aux + 1; % updates aux variable
                        
                        break % After the match, it stops looking and moves to the following particle to be matched
                        
                    end
                    
                end
                
            elseif strcmp(camera, "Halle") % Particles going from bottom to top
                
                difs = (log2(areas1(j))-log2(areas2(k)))/log2(areas1(j)); % Difference in areas
                
                % If the absolute difference between areas is lower than the threshold, and the position in y
                % for the particle in i+1 lies beyond the given radius for the particle in frame i, and the
                % position in x for the particle in fram i+1 lies within the requiered range for the particle
                % in frame i; then you have a match.
                if abs(difs) < difs_th && ...
                        igrec1(j) - distMin > igrec2(k) && ...
                        abs(iks1(j) - iks2(k)) < x_dev % This 10 it's to be sure that we have "straight" paths
                    % If there is a match, you calculate the distance between centroids. This distance is in px!.
                    
                    distance = pdist([iks1(j), igrec1(j); iks2(k), igrec2(k)], 'euclidean');
                    
                    % If the distance is within range, you finally establish a pair of particles and continue with
                    % the next particle in frame i.
                    if distance > distMin && distance < distMax
                        
                        vel = distance/dt; % Velocity (in px!)
                        
                        % Add all information to an array. This way it is possible to track the particles in the
                        % images and check validity of the results. The structure of the array is as shown below:
                        % pairs = [frame number, i-frame centroid's x-coordinate, i-frame centroid's y-coordinate,
                        % (i+1)-frame centroid's-x coordinate,(i+1)-frame centroid's y-coordinate,
                        % distance between particles, velocity, difference of areas]
                        pairs = [pairs; i, iks1(j), igrec1(j), iks2(k), igrec2(k), distance, vel, difs];
                        
                        aux = aux + 1; % updates aux variable
                        
                        break % After the match, it stops looking and moves to the following particle to be matched
                        
                    end
                    
                end
                
            end
            
        end
        
    end
    
    % If it doesn't find any pair, it fills with NaNs
    if aux == 0
        
        pairs = [pairs; i, NaN, NaN, NaN, NaN, NaN, NaN, NaN];
        
    end
    
    % After it finishes looking for pairs, saves the results.
    velocity    = pairs; % All the data in pairs is stored
    mv          = mean(velocity(velocity(:, 1) == i, 7)); % Mean velocity in the frame
    
    %
    if isnan(mv)
        
        mv = NaN;
        
    end
    
    mvel(i, :) = [i, mv]; % Only mean velocity Frame-by-Frame
    
end

save(fullfile(SavePath, strcat('MeanVel_', filename(10: end))), 'mvel');        % saves mean velocity frame by frame
save(fullfile(SavePath, strcat('AllInfoVel_', filename(10: end))), 'velocity'); % saves all the information of velocity

end
