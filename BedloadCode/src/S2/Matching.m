% Matching
% This function is the main part of the algorithm. It is in charge of the particle detection, match between
% frames, mean particle velocity by frame
%
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
        
        fprintf(strcat('Processing file:', filenames{j}, '\n'))        % Prints file name
        
        particle_info = Particles(images, minSize, SavePath, filenames{j});
        
        %part_1=particle_info(particle_info(:,1)==1,:); %show the particles detected in the first image
        
        %mean(part_1(:,2))
        
        fprintf('We passed the particle detection\n') % Prints file name
        
        %     toc
        
        % Plot filtered images with detected centroids %
        % plot_centroids(images, particle_info, FirstFrame, single)
        
        
        % To check if the values for min and max area are well chosen
        % [f,x] = ecdf(particle_info(:,2));
        
        
        % Filtering particles before computing velocity %
        %     tic
        
        final_particles = Particles_Filtered(particle_info, height, width, distMinIsol, areamin, areamax, ...
            lim_width, lim_height); % Requieres particles, image's size and distance threshold.
        
        %final_particles(final_particles(:,1)==1,:)
        
        fprintf('We passed the particle filtering \n') % Prints file name
        
        %     toc
        % Plot final particles %
        %     plot_centroids(images, final_particles, FirstFrame, single)
        
        % Mean velocity computation using filtered particles. Frame-by-Frame results.%
        % velocity = [frame number, particle's centroid x coord in image i, particle's centroid y coord in image i,
        % particle's centroid x coord in image i+1, particle's centroid y coord in image i+1, distance between
        % centroids, velocity, area difference in log2 scale].
        %
        % mvel = mean velocity frame-by-frame
        %     tic
        
        [velocity, mvel] = Mean_vel(final_particles, distMinVel, distMaxVel,1/60, difs_th, x_dev, ...
            SavePath, filenames{j}); %difs_th_M, difs_th_m % Matrix with timestep and correspondent velocity
        
        fprintf('We passed the mean velocity computation\n') % Prints file name
        
        %     toc
        
        Plot_velocity(velocity, images, 250);
        
        %velocity(velocity(:,1)==1,:)
        
        % Sediment discharge %
        % Sediment discharge is calculated from the total ammount of particles passing over a specific section of
        % the image. That section is determined using the mean velocity for each frame, and the centroid of all
        % particles falling within that area. Sediment discharge is calculated in px^3. It's necessary to include
        % the final conversion to kg using a reference distance in the images.
        
        %     tic
        
        BS = Black_surface(images, height, width, SavePath, filenames{j});
        
        sed = Sed_discharge_BS(mvel, particle_info, fps, height, width, BS, SavePath, filenames{j});
        
        fprintf('We passed the sediment discharge computation \n') % Prints file name
        
        
        
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
        
        fprintf(strcat('Processing file: ', filenames(j).name, '\n'))        % Prints file name
        
        particle_info = Particles(images, minSize, SavePath, filenames(j).name);
        
        %part_1=particle_info(particle_info(:,1)==1,:); %show the particles detected in the first image
        
        %mean(part_1(:,2))
        
        fprintf('We passed the particle detection\n') % Prints file name
        
        %     toc
        
        % Plot filtered images with detected centroids %
        % plot_centroids(images, particle_info, FirstFrame, single)
        
        
        % To check if the values for min and max area are well chosen
        % [f,x] = ecdf(particle_info(:,2));
        
        
        % Filtering particles before computing velocity %
        %     tic
        
        final_particles = Particles_Filtered(particle_info, height, width, distMinIsol, areamin, areamax, ...
            lim_width, lim_height); % Requieres particles, image's size and distance threshold.
        
        %final_particles(final_particles(:,1)==1,:)
        
        fprintf('We passed the particle filtering \n') % Prints file name
        
        %     toc
        % Plot final particles %
        %     plot_centroids(images, final_particles, FirstFrame, single)
        
        % Mean velocity computation using filtered particles. Frame-by-Frame results.%
        % velocity = [frame number, particle's centroid x coord in image i, particle's centroid y coord in image i,
        % particle's centroid x coord in image i+1, particle's centroid y coord in image i+1, distance between
        % centroids, velocity, area difference in log2 scale].
        %
        % mvel = mean velocity frame-by-frame
        %     tic
        
        [velocity, mvel] = Mean_vel(final_particles, distMinVel, distMaxVel,1/60, difs_th, x_dev, ...
            SavePath, filenames(j).name); %difs_th_M, difs_th_m % Matrix with timestep and correspondent velocity
        
        fprintf('We passed the mean velocity computation\n') % Prints file name
        
        %     toc
        
        Plot_velocity(velocity, images, 250);
        
        %velocity(velocity(:,1)==1,:)
        
        % Sediment discharge %
        % Sediment discharge is calculated from the total ammount of particles passing over a specific section of
        % the image. That section is determined using the mean velocity for each frame, and the centroid of all
        % particles falling within that area. Sediment discharge is calculated in px^3. It's necessary to include
        % the final conversion to kg using a reference distance in the images.
        
        %     tic
        
        BS = Black_surface(images, height, width, SavePath, filenames(j).name);
        
        sed = Sed_discharge_BS(mvel, particle_info, fps, height, width, BS, SavePath, ... 
            filenames(j).name);
        
        fprintf('We passed the sediment discharge computation \n') % Prints file name
                
    end
    
end

disp('End of the matching and bed load computation process.')

end
