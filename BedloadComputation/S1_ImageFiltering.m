%% Step 1 - Image filtering

% This script applies the filtering to RAW images obtained from video acquisition. It works for several matfiles
% in the same folder or for a single file.
% It requires:
% * FiltersFunction: function with all filters to be applied.
% * Directory of the folder containing the videos
% -----------------------------------------------------------------------------------------------------------

close all;  % Close all windows
clear all;  % Clear the workspace
clc         % Clear console

%% Parameter definitions
% We define the different parameters used by the functions.

% Choose in what format are the RAW images: "matfile" or "video"
FileType = 'matfile';

% Choose which elements to process: "select" for specific ones, or "all" for everything inside a folder.
ProcessingMode = 'all'; 

% User defined parameters.
% These parameters must be estimated during the image calibration process previous to the sediment counter
% calibration.

n       = 4;                    % number of cores to use
GaussFilterSigma    = 0.5;      % Sigma value for Gauss's Filter
FilterDiskSize      = 8;        % Disk size bothat filter
DilatationDiskSize  = 0;        % Disk size for dilation function
xdim    = 1280;                  % Image's width
ydim    = 720;                  % Image's height
x_0     = 27;                   % bottom-left x-coordinate for cropping the image
x_end   = 619;                  % top-right x-coordinate for cropping the image
y_0     = 1;                    % bottom-left y-coordinate for cropping the image
y_end   = 480;                  % top-right y-coordinate for cropping the image

                                        
%% Series loop over files

% Determines files' directories & creates folder to export filtered images
[filenames, filesPath, FilteredPath] = S1dir(n, FileType, ProcessingMode);

% Filtering process
Filtering(filesPath, filenames, FileType, ProcessingMode, FilteredPath, ...
    xdim, ydim, x_0, x_end, y_0, y_end, ...
    GaussFilterSigma, FilterDiskSize, DilatationDiskSize)

fprintf("c'est fini\n")