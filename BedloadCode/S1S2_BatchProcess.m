%% Step 1 and Step 2 - Image filtering and matching for a batch

close all;  % Close all windows
clear all;  % Clear the workspace
clc         % Clear console

%% Filtering setup
% We define the different parameters used by the functions.
FileType    = 'matfile';   % Choose in what format are the RAW images: "matfile" or "video"
n           = 8;                % number of cores to use

% Choose which elements to process: "select" for specific ones, or "all" for everything inside a folder.
ProcessingMode = 'all';

% What camera are we processing?
camera  = "Halle"; % Options: LESO, office, laptop, Halle.

% Loading the parameters to use for filtering. The values must be determined during calibration.
[GaussFilterSigma, FilterDiskSize, DilatationDiskSize, xdim, ydim, crop, x_0, x_end,...
    y_0, y_end, minSize, maxSize] = paramsFiltering(camera);

% Determines files' directories & creates folder to export filtered images
[foldersPath, subFolders] = S1dirBatch(n);

% For loop over all subfolders containing RAW images.
for i = 1:length(subFolders)
    
    % Bedload computation step
    filesPath = fullfile(foldersPath, subFolders(i).name,'RAW_matfiles');
    
    fprintf('\n------------------------------------------\n\n')
    disp(subFolders(i).name)
    fprintf('\n------------------------------------------\n\n')

    filenames = dir(fullfile(filesPath, '*.mat'));
    FilteredPath = fullfile(filesPath, '..', 'Filtered');

    % If the saving folder does not exist, it makes it
    if ~exist(FilteredPath, 'dir')
        mkdir(FilteredPath)
    end

    Filtering(filesPath, filenames, FileType, ProcessingMode, FilteredPath, ...
        xdim, ydim, x_0, x_end, y_0, y_end, ...
        GaussFilterSigma, FilterDiskSize, DilatationDiskSize, crop, minSize, maxSize)

    % Bedload computation step

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
        imheight, imwidth, maxparticles);

    Discharge_computation(OutputPath, fps, imheight, imwidth);
    

end
