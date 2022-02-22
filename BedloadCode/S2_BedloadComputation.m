%% Step 2 - Bed load computation

% Particle count, identification and velocity calculation
% This code uses PARFEVAL (Parallel Computing Toolbox) to calculate the
% sediment discharge in following a procedure similar to the used by
% Zimmermann and Elgueta in their correspondent articles. It reads matfiles
% containing binary files with the particles in binary format

% -----------------------------------------------------------------------------------------------------------

% clear all;
close all;
% clc

%% Computation setup

ProcessingMode = 'all';   % "select" or "all" folders

% What camera are we processing?
camera = "Halle";      % Options: LESO, office, laptop, Halle.

n      = 4;            % number of cores to use
skip   = 1;            % number of matfiles to skip for velocity computation. One each "skip" files.

% Loading parameters depending on source of images
[maxparticles, fps, distMaxVel, distMinVel, distMinIsol, areamin, areamax, difs_th, x_dev, ...
    lim_width, lim_height, imwidth, imheight] = paramsComputation(camera);

% Determines files' directories & creates folder to export filtered images
[filesPath, filenames, SavePath] = S2dir(ProcessingMode, n);

%% Matching execution

tic

Matching(camera, filesPath, filenames, SavePath, ProcessingMode, skip, distMinIsol, ...
    areamin, areamax, lim_width, lim_height, distMinVel, distMaxVel, difs_th, x_dev, fps,...
    imheight, imwidth, maxparticles);

%Discharge_computation(SavePath, fps, imheight, imwidth);

toc
