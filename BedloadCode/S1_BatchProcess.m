%% Step 1 - Image filtering for a batch

% This script applies the filtering to RAW images obtained from video acquisition. It works for several matfiles
% in the same folder or for a single file.
% It requires:
% * FiltersFunction: function with all filters to be applied.
% * Directory of the folder containing the videos
% -----------------------------------------------------------------------------------------------------------

close all;  % Close all windows
clear all;  % Clear the workspace
% clc         % Clear console

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

% for para las subcarpetas
% filenames, filesPath, FilteredPath

for i = 1:length(subFolders)

    filesPath = fullfile(foldersPath, subFolders(i).name,'RAW_matfiles');
    
    disp('\n------------------------------------------\n')
    disp(subFolders(i).name)
    disp('\n------------------------------------------')

    filenames = dir(fullfile(filesPath, '*.mat'));
    FilteredPath = fullfile(filesPath, '..', 'Filtered');

    % If the saving folder does not exist, it makes it
    if ~exist(FilteredPath, 'dir')
        mkdir(FilteredPath)
    end

    Filtering(filesPath, filenames, FileType, ProcessingMode, FilteredPath, ...
        xdim, ydim, x_0, x_end, y_0, y_end, ...
        GaussFilterSigma, FilterDiskSize, DilatationDiskSize, crop, minSize, maxSize)

end
