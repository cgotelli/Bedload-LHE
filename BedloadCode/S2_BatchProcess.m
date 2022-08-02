%% Step 2 - Bed load computation for a batch

% Particle count, identification and velocity calculation
% This code uses PARFEVAL (Parallel Computing Toolbox) to calculate the
% sediment discharge in following a procedure similar to the used by
% Zimmermann and Elgueta in their correspondent articles. It reads matfiles
% containing binary files with the particles in binary format

% -----------------------------------------------------------------------------------------------------------

clear all;
close all;
% clc

%% Computation setup

ProcessingMode = 'all'; % "select" or "all" folders

% What camera are we processing?
camera = "Halle";       % Options: LESO, office, laptop, Halle.
filtrar = true;     % Set to true to filter partices by size in the binary image counting (BS)
n      = 8;             % number of cores to use
skip   = 1;             % number of matfiles to skip for velocity computation. One each "skip" files.

% Loading parameters depending on source of images
[maxparticles, fps, distMaxVel, distMinVel, distMinIsol, areamin, areamax, difs_th, x_dev, ...
    lim_width, lim_height, imwidth, imheight,lowrange, toprange] = paramsComputation(camera);

% Determines files' directories & creates folder to export filtered images
[foldersPath, subFolders] = S2dirBatch(n);

% For loop over all subfolders containing filtered images.
for i = 1:length(subFolders)

    filesPath = fullfile(foldersPath, subFolders(i).name,'Filtered');

    fprintf('\n------------------------------------------\n\n')
    disp(subFolders(i).name)
    fprintf('\n------------------------------------------\n\n')

    filenames = dir(fullfile(filesPath, '*.mat'));
    OutputPath = fullfile(filesPath, '..', 'Output');

    % If the saving folder does not exist, it makes it
    if ~exist(OutputPath, 'dir')
        mkdir(OutputPath)
    end

    Matching(camera, filesPath, filenames, OutputPath, ProcessingMode, skip, distMinIsol, ...
        areamin, areamax, lim_width, lim_height, distMinVel, distMaxVel, difs_th, x_dev, fps,...
        imheight, imwidth, maxparticles, filtrar, lowrange, toprange);

    %Discharge_computation(OutputPath, fps, imheight, imwidth);

end