% Matching
% This function is the main part of the algorithm. It is in charge of the particle detection, match between
% frames, mean particle velocity by frame
%

function Matching(filesPath, filenames, SavePath, ProcessingMode, minSize, distMinIsol, ...
    areamin, areamax, lim_width, lim_height, distMinVel, distMaxVel, difs_th, x_dev, fps)

if strcmp(ProcessingMode, 'select') % For selected matfiles
    
    parfor j = 1:length(filenames)
        
        name    = fullfile(filesPath, filenames{j});
        disp(filenames{j})
        images  = load(name);
        images  = images.data_filtered;
        tam     = size(images);                                             % Array's size
        height  = tam(1);                                                   % Image's height
        width   = tam(2);                                                   % Image's width
        
        disp(strcat('Processing file:', " ", filenames{j}))        % Prints file name
        
        particle_info = Particles(images, minSize, SavePath, filenames{j});
        
        disp(strcat('We passed the particle detection: ', " ", filenames{j}))
        
        final_particles = Particles_Filtered(particle_info, height, width, distMinIsol, areamin, areamax, ...
            lim_width, lim_height); % Requieres particles, image's size and distance threshold.
        
        disp(strcat('We passed the particle filtering:' , " " , filenames{j}))
        
        [velocity, mvel] = Mean_vel(final_particles, distMinVel, distMaxVel, 1/60, difs_th, x_dev, ...
            SavePath, filenames{j}); %difs_th_M, difs_th_m % Matrix with timestep and correspondent velocity
        
        disp(strcat('We passed mean velocity computation: ' , " " , filenames{j}))
        
        Plot_velocity(velocity, images, 250);
                
        BS = Black_surface(images, height, width, SavePath, filenames{j});
        
        sed = Sed_discharge_BS(mvel, particle_info, fps, height, width, BS, SavePath, filenames{j});
        
        disp(strcat('We passed the sediment discharge computation: ' , " " , filenames{j}))
        
    end
    
elseif strcmp(ProcessingMode, 'all') % For all matfiles in the folder
    
    parfor j = 1:length(filenames)
        
        name    = fullfile(filesPath, filenames(j).name);
        disp(filenames(j).name)
        images  = load(name);
        images  = images.data_filtered;
        tam     = size(images);                                             % Array's size
        height  = tam(1);                                                   % Image's height
        width   = tam(2);                                                   % Image's width
        
        disp(strcat('Processing file: ' , " " , filenames(j).name))        % Prints file name
        
        particle_info = Particles(images, minSize, SavePath, filenames(j).name);
        
        disp(strcat('We passed the particle detection: ' , " " , filenames(j).name))
                
        final_particles = Particles_Filtered(particle_info, height, width, distMinIsol, areamin, areamax, ...
            lim_width, lim_height); % Requieres particles, image's size and distance threshold.
        
        disp(strcat('We passed the particle filtering: ' , " " , filenames(j).name))
                
        [velocity, mvel] = Mean_vel(final_particles, distMinVel, distMaxVel,1/60, difs_th, x_dev, ...
            SavePath, filenames(j).name); %difs_th_M, difs_th_m % Matrix with timestep and correspondent velocity
        
        disp(strcat('We passed the mean velocity computation: ' , " " , filenames(j).name))
        
        Plot_velocity(velocity, images, 250);
        
        BS = Black_surface(images, height, width, SavePath, filenames(j).name);
        
        sed = Sed_discharge_BS(mvel, particle_info, fps, height, width, BS, SavePath, ...
            filenames(j).name);
        
        disp(strcat('We passed the sediment discharge computation: ' , " " , filenames(j).name))
                
    end
    
end

disp('End of the matching and bed load computation process.')

end
