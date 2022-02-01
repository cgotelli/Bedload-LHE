% Matching
% This function is the main part of the algorithm. It is in charge of the particle detection, match between
% frames, mean particle velocity by frame, total amount of pixels corresponding to particles, and the sediment
% discharge computation.

function Matching(filesPath, filenames, SavePath, ProcessingMode, skip, minSize,...
    distMinIsol, areamin, areamax, lim_width, lim_height, distMinVel, distMaxVel, difs_th, x_dev, ...
    fps, imheight, imwidth, maxparticles)

dt = 1/fps; % Delta time between frames.

if strcmp(ProcessingMode, 'select') % For selected matfiles
    
    parfor j = 1:length(filenames)
        
        name    = fullfile(filesPath, filenames{j});
        images  = load(name);
        images  = images.data_filtered;
        
        disp(strcat('Processing file', " -------> ", filenames{j}))         % Prints file name
        
        particles_data = Particle_detection(images, minSize, SavePath, filenames{j}); % Detects all particles
        
        disp(strcat('We passed the particle detection', " -------> ", filenames{j}))
        
        final_particles = Particle_filtering(particles_data, imheight, imwidth, distMinIsol, areamin, areamax, ...
            lim_width, lim_height, maxparticles); % Filter the best particles for computing mean particle's velocity.
        
        disp(strcat('We passed the particle filtering' , " -------> " , filenames{j}))
        
        Mean_vel(final_particles, distMinVel, distMaxVel, dt, difs_th, x_dev, ...
            SavePath, filenames{j}); % Computes velocity 
        
        disp(strcat('We passed mean velocity computation' , " -------> " , filenames{j}))
                
        Black_surface(images, imheight, imwidth, SavePath, filenames{j}); % Returns am array with the number of black pixels by frame
        
    end
    
elseif strcmp(ProcessingMode, 'all') % For all matfiles in the folder
    
    parfor j = 1:length(filenames)

        name    = fullfile(filesPath, filenames(j).name);
        images  = load(name);
        images  = images.data_filtered;
        
        disp(strcat(num2str(j), " Processing file -------> " , filenames(j).name))
        
        if mod(j, skip) == 0 || j == 1
            
            disp(strcat(num2str(j), " Starting complete process for: ", " -----> ", filenames(j).name))
%             tic
            particles_data = Particle_detection(images, minSize, SavePath, filenames(j).name); % Detects all particles
%             toc
            disp(strcat(num2str(j), " We passed the particle detection -------> " , filenames(j).name))
%             tic
            final_particles = Particle_filtering(particles_data, imheight, imwidth, distMinIsol, areamin, areamax, ...
                lim_width, lim_height, maxparticles); % Filter the best particles for computing mean particle's velocity.
%             toc
            disp(strcat(num2str(j), " We passed the particle filtering -------> " , filenames(j).name))
%             tic
            Mean_vel(final_particles, distMinVel, distMaxVel, dt, difs_th, x_dev, ...
                SavePath, filenames(j).name); % Computes velocity and returns the mean velocity in an array
%             toc
            disp(strcat(num2str(j), " We passed the mean velocity computation -------> " , filenames(j).name))
%             tic
            Black_surface(images, imheight, imwidth, SavePath, filenames(j).name); % Returns am array with the number of black pixels by frame
%             toc
            disp(strcat(num2str(j), " Done with complete process for: "," -----> ", filenames(j).name))
            
        else
            disp(strcat(num2str(j), " Starting partial process for: ", " -----> ", filenames(j).name))
            Black_surface(images, imheight, imwidth, SavePath, filenames(j).name); % Returns am array with the number of black pixels by frame
            disp(strcat(num2str(j), " Done with partial process for: ", " -----> ", filenames(j).name))
        end
        
    end
    
end

disp('End of the matching and velocity computation process.')

end
