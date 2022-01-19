function [velocity,mvel] = mean_vel(final_particles, distMin, distMax, dt, difs_th, x_dev, folder, filename) %difs_th_M, difs_th_m,
% Calculates the velocity matching particles between frames i and (i+1). It returns the detail of all
% particles matched and the also the mean velocity per frame.

num_frames = final_particles(end,1,1); % Total number of frames to process
pairs = []; % Empty array for pairs of particles
mvel = zeros(num_frames-1,2); % Empty array for mean velocity (the last frame is not counted as there is no num_frames+1 frame to compute the velocity)

for i = 1:num_frames-1 %For loop over the first n-1 frames.
    
    % Frame i
    areas1 = final_particles(final_particles(:,1)==i,2); % Gets areas from all particles in frame i
    iks1 = final_particles(final_particles(:,1)==i,3); % Gets centroid's x coordinates for particles in frame i
    igrec1 = final_particles(final_particles(:,1)==i,4); % % Gets centroid's y coordinates for particles in frame i
    %M1 = final_particles(final_particles(:,1)==i,5); % Gets Major Axis length from all particles in frame i --> comparison of minor or major axis seems detrimental
    %m1 = final_particles(final_particles(:,1)==i,6); % Gets minor axis length from all particles in frame i
    
    %Frame i+1
    areas2 = final_particles(final_particles(:,1)==i+1,2); % Gets areas from all particles in frame i+1
    iks2 = final_particles(final_particles(:,1)==i+1,3); % Gets centroid's x coordinates for particles in frame i+1
    igrec2 = final_particles(final_particles(:,1)==i+1,4); % Gets centroid's y coordinates for particles in frame i+1
    %M2 = final_particles(final_particles(:,1)==i+1,5); % Gets Major Axis length from all particles in frame i+1
    %m2 = final_particles(final_particles(:,1)==i+1,6); % Gets minor axis length from all particles in frame i+1
    
    aux = 0; % Aux variable
    % For each particle in frame i, tries to find one particle that fullfills all requierements in frame i+1.
    % Once it reaches this condition, continues to the next particle in frame i.
    for j = 1:size(iks1)
        for k = 1:size(iks2)
            difs = (log2(areas1(j))-log2(areas2(k)))/log2(areas1(j)); % Difference in areas 
            % If the absolute difference between areas is lower than the threshold, and the position in y for
            % the particle in i+1 lies within the given range for the particle in frame i, and the position in
            % x for the particle in fram i+1 lies within the requiered range for the particle in frame i; then
            % you have a match.
            if abs(difs) < difs_th && igrec1(j) + distMin <igrec2(k)&& abs(iks1(j)-iks2(k))<x_dev%10 % This 10 it's to be sure that we have "straight" paths %10 is replaced by x_dev
                % If there is a match, you calculate the distance between centroids. This distance is in px!.
                distance = pdist([iks1(j),igrec1(j);iks2(k),igrec2(k)],'euclidean');
                % If the distance is within range, you finally establish a pair of particles and continue with
                % the next particle in frame i.
                %difs_M = (log2(M1(j))-log2(M2(k)))/log2(M1(j)); % Difference in Major axis length
                %difs_m = (log2(m1(j))-log2(m2(k)))/log2(m1(j)); % Difference in minor axis length
                if distance > distMin && distance < distMax    %abs(difs_M) < difs_th_M && abs(difs_m) < difs_th_m && 
                    vel = distance/dt; % Velocity (in px!)
                    % Add all information to an array. This way it is possible to track the particles in the
                    % images and check validity of the results. pairs = [frame number, i-frame centroid's x
                    % coordinate, i-frame centroid's y coordinate, (i+1)-frame centroid's x coordinate,
                    % (i+1)-frame centroid's y coordinate, distance between particles, velocity, difference of
                    % areas]
                    pairs = [pairs; i, iks1(j), igrec1(j), iks2(k), igrec2(k), distance, vel, difs]; 
                    aux = aux + 1; % updates aux variable
                    break
                    %continue
                end
            end
        end
    end
    % If it doesn't find any pair, it fills with zeros
    if aux == 0
        pairs = [pairs;i,NaN,NaN,NaN,NaN,NaN,NaN,NaN];
    end
    % After it finishes looking for pairs, saves the results on arrays.
    velocity = pairs; % Every detail
    mv=mean(velocity(velocity(:,1) == i,7));
    if isnan(mv)
        mv=0;
    end
    mvel(i,:) = [i, mv]; % Only mean velocity Frame-by-Frame
end
%mvel = [mvel;num_frames, mvel(end,2:end)]; % Repeats last values for last frame

save(fullfile(folder, strcat('FrameMeanVel_', filename)), 'mvel'); % save mean velocity 
end