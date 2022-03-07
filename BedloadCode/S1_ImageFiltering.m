%% Step 1 - Image filtering

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
FileType = 'matfile';   % Choose in what format are the RAW images: "matfile" or "video"
n   = 8;                % number of cores to use

% Choose which elements to process: "select" for specific ones, or "all" for everything inside a folder.
ProcessingMode = 'all';

% What camera are we processing?
camera  = "Halle"; % Options: LESO, office, laptop, Halle.

% Loading the parameters to use for filtering. The values must be determined during calibration.
[GaussFilterSigma, FilterDiskSize, DilatationDiskSize, xdim, ydim, crop, x_0, x_end,...
    y_0, y_end, minSize] = paramsFiltering(camera);

% Determines files' directories & creates folder to export filtered images
[filenames, filesPath, FilteredPath] = S1dir(n, FileType, ProcessingMode);

%% Filtering execution

tic
Filtering(filesPath, filenames, FileType, ProcessingMode, FilteredPath, ...
    xdim, ydim, x_0, x_end, y_0, y_end, ...
    GaussFilterSigma, FilterDiskSize, DilatationDiskSize, crop, minSize)
toc

fprintf("c'est fini\n")