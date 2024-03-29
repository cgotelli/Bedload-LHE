% Matching
% This function is the main part of the algorithm. It is in charge of the particle detection, match between
% frames, mean particle velocity by frame, total amount of pixels corresponding to particles, and the sediment
% discharge computation.

function Matching(camera, filesPath, filenames, SavePath, ProcessingMode, skip, ...
    distMinIsol, areamin, areamax, lim_width, lim_height, distMinVel, distMaxVel, difs_th, x_dev, ...
    fps, imheight, imwidth, maxparticles, filtrar, lowrange, toprange)

dt = 1/fps; % Delta time between frames.

if strcmp(ProcessingMode, 'select') % For selected matfiles
    
    for j = 1:length(filenames)
        
        name    = fullfile(filesPath, filenames{j});
        images  = load(name);
        images  = images.data_filtered;
        numFrames = size(images, 3);
%         disp(strcat('Processing file', " -------> ", filenames{j}))         % Prints file name
%         
%         particles_data = Particle_detection(images, SavePath, filenames{j}); % Detects all particles
%         
%         disp(strcat('We passed the particle detection', " -------> ", filenames{j}))
%         
%         final_particles = Particle_filtering(particles_data, imheight, imwidth, distMinIsol, areamin, areamax, ...
%             lim_width, lim_height, maxparticles); % Filter the best particles for computing mean particle's velocity.
%         
%         disp(strcat('We passed the particle filtering' , " -------> " , filenames{j}))
%         
%         Mean_vel(camera, numFrames, final_particles, distMinVel, distMaxVel, dt, difs_th, x_dev, ...
%             SavePath, filenames{j}); % Computes velocity 
%         
%         disp(strcat('We passed mean velocity computation' , " -------> " , filenames{j}))
%                 
%         Black_surface(images, filter,minarea, maxarea, SavePath, filenames{j}); % Returns am array with the number of black pixels by frame
        Black_surface(images, filtrar, lowrange, toprange, SavePath, filenames{j})
    end
    
elseif strcmp(ProcessingMode, 'all') % For all matfiles in the folder
    
%     parfor j = 1:length(filenames)
    parfor j = 1:length(filenames)

        name    = fullfile(filesPath, filenames(j).name);
        images  = load(name);
        images  = images.data_filtered;
        numFrames = size(images, 3);
        
        disp(strcat(num2str(j), " Processing file -------> " , filenames(j).name))
        
        if mod(j, skip) == 0 || j == 1
            
%             disp(strcat(num2str(j), " Starting complete process for: ", " -----> ", filenames(j).name))
%             
%             particles_data = Particle_detection(images, SavePath, filenames(j).name); % Detects all particles
%             
%             disp(strcat(num2str(j), " We passed the particle detection -------> " , filenames(j).name))
%             
%             final_particles = Particle_filtering(particles_data, imheight, imwidth, distMinIsol, areamin, areamax, ...
%                 lim_width, lim_height, maxparticles); % Filter the best particles for computing mean particle's velocity.
%             
%             disp(strcat(num2str(j), " We passed the particle filtering -------> " , filenames(j).name))
%             
%             Mean_vel(camera, numFrames, final_particles, distMinVel, distMaxVel, dt, difs_th, x_dev, ...
%                 SavePath, filenames(j).name); % Computes velocity and returns the mean velocity in an array
%             
%             disp(strcat(num2str(j), " We passed the mean velocity computation -------> " , filenames(j).name))
% 
%             Black_surface(images, imheight, imwidth, SavePath, filenames(j).name); % Returns am array with the number of black pixels by frame
            Black_surface(images, filtrar, lowrange, toprange, SavePath,  filenames(j).name);
            disp(strcat(num2str(j), " Done with complete process for: "," -----> ", filenames(j).name))
            
        else
            
%             disp(strcat(num2str(j), " Starting partial process for: ", " -----> ", filenames(j).name))
%             
%             Black_surface(images, imheight, imwidth, SavePath, filenames(j).name); % Returns am array with the number of black pixels by frame
            Black_surface(images, filtrar, lowrange, toprange, SavePath,  filenames(j).name);
            disp(strcat(num2str(j), " Done with partial process for: ", " -----> ", filenames(j).name))
        
        end
        
    end
    
end

disp('End of the matching and velocity computation process.')

end
