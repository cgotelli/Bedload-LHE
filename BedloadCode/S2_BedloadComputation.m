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

%% Computation setup

ProcessingMode        = 'all';   % "select" or "all" folders
minSize     = 10;           % Minimum size to consider a cluster as a particle (in px)
FirstFrame  = 1;            % First image to plot with centroids
single      = 1;            % 1 if it's a single image, 0 for a sequence
fps         = 60;           % Image acquisition fps in the lab
distMaxVel  = 40;           % 40; % Max distance traveled by a particle between images. To avoid impossible pairs.
distMinVel  = 10;           % Min distance traveled by a particle between images. To avoid impossible pairs.
distMinIsol = 18;           % 30; % Separation to define isolated particles. Necessary for getting a mean velocity.

areamin     = 0.5;          % 1.0; % ratio between min area to consider for PIV and mean area.
areamax     = 5;            % 20.; %1.5; % ratio between max area to consider for PIV and mean area.
difs_th     = 0.05;         % logarithmic size threshold for identifying two similar particles.
x_dev       = 10;           % maximum allowed value of horizontal deviation between two consecutive images (in px).
%difs_th_M = 0.08;          % logarithmic size threshold for identifying two similar particles on Major axis.  --> useless
%difs_th_m = 0.08;          % logarithmic size threshold for identifying two similar particles on minor axis.  --> useless
lim_width   = 0.05;         % fraction of the image to exclude in the x axis for each border.
lim_height  = 0.05;         % fraction of the image to exclude in the y axis for each border.
n           = 4;            % number of cores to use

% Determines files' directories & creates folder to export filtered images
[matfilespath, filenames, SavePath] = S2dir(ProcessingMode, n);

%% Matching execution

Matching(matfilespath, filenames, SavePath, ProcessingMode, minSize, distMinIsol, ...
    areamin, areamax, lim_width, lim_height, distMinVel, distMaxVel, difs_th, x_dev, fps)
