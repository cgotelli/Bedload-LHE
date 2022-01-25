%% Step 2 - Bed load computation

% Particle count, identification and velocity calculation
% This code uses PARFEVAL (Parallel Computing Toolbox) to calculate the
% sediment discharge in following a procedure similar to the used by
% Zimmermann and Elgueta in their correspondent articles. It reads matfiles
% containing binary files with the particles in binary format

% -----------------------------------------------------------------------------------------------------------

clear all;
close all;
clc

%% Parameters definition

mode        = 'single'; % "single" or "all" folders
minSize     = 10;       % Minimum size to consider a cluster as a particle (in px)
FirstFrame  = 1;        % First image to plot with centroids
single      = 1;        % 1 if it's a single image, 0 for a sequence
fps         = 60;       % Image acquisition fps in the lab
distMaxVel  = 40;       % 40; % Max distance traveled by a particle between images. To avoid impossible pairs.
distMinVel  = 10;       % Min distance traveled by a particle between images. To avoid impossible pairs.
distMinIsol = 18;       % 30; % Separation to define isolated particles. Necessary for getting a mean velocity.

areamin     = 0.5;      % 1.0; % ratio between min area to consider for PIV and mean area.
areamax     = 5;        % 20.; %1.5; % ratio between max area to consider for PIV and mean area.
difs_th     = 0.05;     % logarithmic size threshold for identifying two similar particles.
x_dev       = 10;       % maximum allowed value of horizontal deviation between two consecutive images (in px).
%difs_th_M = 0.08;      % logarithmic size threshold for identifying two similar particles on Major axis.  --> useless
%difs_th_m = 0.08;      % logarithmic size threshold for identifying two similar particles on minor axis.  --> useless
lim_width   = 0.05;     % fraction of the image to exclude in the x axis for each border.
lim_height  = 0.05;     % fraction of the image to exclude in the y axis for each border.
n           = 4;        % number of cores to use

%%
% Determines files' directories & creates folder to export filtered images
[matfilespath, filenames,SavePath] = S2dir(mode, n);

%% Loop over files looking for particles to get velocity
particle_info = []; % Empty array for saving particle information

% For loop over all matfiles. During calibration it should be only single files because it will be sample by
% sample: 1 video -> 1 sample
parfor j = 1:length(filenames)
    
    % Load data %
    data    = load(fullfile(filenames(j).folder, filenames(j).name));   % Load one file at a time
    images  = data.data_filtered;                                       % Read images from datafile
    tam     = size(images);                                             % Array's size
    height  = tam(1);                                                   % Image's height
    width   = tam(2);                                                   % Image's width
    
    fprintf(strcat('File:', filenames(j).name, '\n'))                   % Prints file name
    
    % 1st step: Get particles' information: Frame number, 'Area', 'Centroid','MajorAxisLength','MinorAxisLength' of all particles %%%
    tic
    
    particle_info = Particles(images, minSize, savepath, filenames(j).name);
   
    %part_1=particle_info(particle_info(:,1)==1,:); %show the particles detected in the first image
    
    %mean(part_1(:,2))
    
    fprintf('We passed the particle detection\n') % Prints file name
    
    toc
    
    % Plot filtered images with detected centroids %
    % plot_centroids(images, particle_info, FirstFrame, single) 
     
    
    % To check if the values for min and max area are well chosen
    % [f,x] = ecdf(particle_info(:,2));
    
    
    % Filtering particles before computing velocity %
    tic
    
    final_particles = Particles_Filtered(particle_info, height, width, distMinIsol,areamin,areamax,lim_width,lim_height); % Requieres particles, image's size and distance threshold.
    
    %final_particles(final_particles(:,1)==1,:)
    
    fprintf('We passed the particle filtering \n') % Prints file name
    
    toc
    % Plot final particles %
%     plot_centroids(images, final_particles, FirstFrame, single) 

    % Mean velocity computation using filtered particles. Frame-by-Frame results.%
    % velocity = [frame number, particle's centroid x coord in image i, particle's centroid y coord in image i,
    % particle's centroid x coord in image i+1, particle's centroid y coord in image i+1, distance between
    % centroids, velocity, area difference in log2 scale].
    % 
    % mvel = mean velocity frame-by-frame
    tic
    
    [velocity, mvel] = Mean_vel(final_particles, distMinVel, distMaxVel,1/60, difs_th, x_dev, ...
        savepath, filenames(j).name); %difs_th_M, difs_th_m % Matrix with timestep and correspondent velocity
    
    fprintf('We passed the mean velocity computation\n') % Prints file name
    
    toc
    
    plot_velocity(velocity,images,250);

    %velocity(velocity(:,1)==1,:)
    
    % Sediment discharge %
    % Sediment discharge is calculated from the total ammount of particles passing over a specific section of
    % the image. That section is determined using the mean velocity for each frame, and the centroid of all
    % particles falling within that area. Sediment discharge is calculated in px^3. It's necessary to include
    % the final conversion to kg using a reference distance in the images.
    
    tic
    
    BS = black_surface(images,height,width,savepath, filenames(j).name);
    
    sed = sed_discharge_BS(mvel,particle_info,fps,height,width,BS,savepath, filenames(j).name);
    
    fprintf('We passed the sediment discharge computation \n') % Prints file name
    
    toc

end
