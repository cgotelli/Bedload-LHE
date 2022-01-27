% Matching
% This function is the main part of the algorithm. It is in charge of the particle detection, match between
% frames, mean particle velocity by frame, total amount of pixels corresponding to particles, and the sediment
% discharge computation.

function Matching(filesPath, filenames, SavePath, ProcessingMode, minSize, distMinIsol, ...
    areamin, areamax, lim_width, lim_height, distMinVel, distMaxVel, difs_th, x_dev, fps)

dt = 1/fps; % Delta time between frames.

if strcmp(ProcessingMode, 'select') % For selected matfiles
    
    parfor j = 1:length(filenames)
        
        name    = fullfile(filesPath, filenames{j});
        images  = load(name);
        images  = images.data_filtered;
        tam     = size(images);                                             % Array's size
        height  = tam(1);                                                   % Image's height
        width   = tam(2);                                                   % Image's width
        
        disp(strcat('Processing file', " -------> ", filenames{j}))         % Prints file name
        
        particles_data = Particle_detection(images, minSize, SavePath, filenames{j}); % Detects all particles
        
        disp(strcat('We passed the particle detection', " -------> ", filenames{j}))
        
        final_particles = Particle_filtering(particles_data, height, width, distMinIsol, areamin, areamax, ...
            lim_width, lim_height); % Filter the best particles for computing mean particle's velocity.
        
        disp(strcat('We passed the particle filtering' , " -------> " , filenames{j}))
        
        [~, mvel] = Mean_vel(final_particles, distMinVel, distMaxVel, dt, difs_th, x_dev, ...
            SavePath, filenames{j}); % Computes velocity 
        
        disp(strcat('We passed mean velocity computation' , " -------> " , filenames{j}))
                
        BS = Black_surface(images, height, width, SavePath, filenames{j}); % Returns am array with the number of black pixels by frame
        
        sed = Discharge_computation(mvel, particles_data, fps, height, width, BS, SavePath, ...
            filenames{j}); % Computes the sediment rate per frame
        
        disp(strcat('We passed the sediment discharge computation' , " -------> " , filenames{j}))
        
    end
    
elseif strcmp(ProcessingMode, 'all') % For all matfiles in the folder
    
    parfor j = 1:length(filenames)
        
        name    = fullfile(filesPath, filenames(j).name);
        images  = load(name);
        images  = images.data_filtered;
        tam     = size(images);                                             % Array's size
        height  = tam(1);                                                   % Image's height
        width   = tam(2);                                                   % Image's width
        
        disp(strcat('Processing file' , " -------> " , filenames(j).name))
        
        particles_data = Particle_detection(images, minSize, SavePath, filenames(j).name); % Detects all particles
        
        disp(strcat('We passed the particle detection' , " -------> " , filenames(j).name))
                
        final_particles = Particle_filtering(particles_data, height, width, distMinIsol, areamin, areamax, ...
            lim_width, lim_height); % Filter the best particles for computing mean particle's velocity.
        
        disp(strcat('We passed the particle filtering' , " -------> " , filenames(j).name))
                
        [~, mvel] = Mean_vel(final_particles, distMinVel, distMaxVel, dt, difs_th, x_dev, ...
            SavePath, filenames(j).name); % Computes velocity and returns the mean velocity in an array
        
        disp(strcat('We passed the mean velocity computation' , " -------> " , filenames(j).name))
        
        BS = Black_surface(images, height, width, SavePath, filenames(j).name); % Returns am array with the number of black pixels by frame
        
        Discharge_computation(mvel, particles_data, fps, height, width, BS, SavePath, ...
            filenames(j).name); % Computes the sediment rate per frame
        
        disp(strcat('We passed the sediment discharge computation' , " -------> " , filenames(j).name))
                
    end
    
end

disp('End of the matching and bed load computation process.')

end
