function [maxparticles, fps, distMaxVel, distMinVel, distMinIsol, areamin, areamax, difs_th, x_dev, ...
    lim_width, lim_height, imwidth, imheight,lowrange, toprange] = paramsComputation(camera)

if strcmp(camera, "Halle")
    
    maxparticles= 1000;         % Maximum number of particles to process by frame (~15)
    
    fps         = 50;           % Frame rate for acquisition in the flume
    distMaxVel  = 150;          % Max distance traveled by a particle between images. To avoid impossible pairs.
    distMinVel  = 70;           % Min distance traveled by a particle between images. To avoid impossible pairs.
    distMinIsol = 30;           % Separation to define isolated particles. Necessary for getting a mean velocity.
    areamin     = 0;            % Lower threshold area to consider a particle in the counting process. In terms of mean.
    areamax     = 100;          % Upper threshold area to consider a particle in the counting process. In terms of mean.
    difs_th     = 0.1;               % logarithmic size threshold for identifying two similar particles.
    x_dev       = 20;                % maximum allowed value of horizontal deviation between two consecutive images (in px).
    lim_width   = 0.05;         % fraction of the image to exclude in the x axis for each border.
    lim_height  = 0.05;         % fraction of the image to exclude in the y axis for each border. 
    imwidth     = 2712;         % image width
    imheight    = 500;           % image height
    lowrange = 0;                  % Low range for particle size filtering in black surface computation
    toprange = 300;             % Top range for particle size filtering in black surface computation
elseif strcmp(camera, "LESO")
    
    maxparticles= 1000;           % Maximum number of particles to process by frame (~15)
    
    fps         = 30;           % Frame rate for acquisition in the flume
    distMaxVel  = 120;           % Max distance traveled by a particle between images. To avoid impossible pairs.
    distMinVel  = 30;           % Min distance traveled by a particle between images. To avoid impossible pairs.
    distMinIsol = 18;           % Separation to define isolated particles. Necessary for getting a mean velocity.
    areamin     = 0.1;          % Lower threshold area to consider a particle in the counting process. In terms of mean.
    areamax     = 5;            % Upper threshold area to consider a particle in the counting process. []
    difs_th     = 0.02;         % logarithmic size threshold for identifying two similar particles.
    x_dev       = 10;           % maximum allowed value of horizontal deviation between two consecutive images (in px).
    lim_width   = 0.05;         % fraction of the image to exclude in the x axis for each border.
    lim_height  = 0.05;         % fraction of the image to exclude in the y axis for each border.
    imwidth     = 640;          % image width
    imheight    = 300;          % image height
    lowrange = 0;               % Low range for particle size filtering in black surface computation
    toprange = 100;           % Top range for particle size filtering in black surface computation
    
end

end