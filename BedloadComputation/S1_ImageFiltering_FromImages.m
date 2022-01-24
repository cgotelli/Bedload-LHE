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

% Choose what method to use: all files inside the folder or just one specific file.
ProcessingMode = 'all'; % "select" or "all"

% User defined parameters.
% These parameters must be estimated during the image calibration process previous to the sediment counter
% calibration.

GaussFilterSigma    = 0.5;      % Sigma value for Gauss's Filter
FilterDiskSize      = 8;        % Disk size bothat filter
DilatationDiskSize  = 0;        % Disk size for dilation function
xdim    = 640;                  % Image's width
ydim    = 480;                  % Image's height
x_0     = 27;                   % bottom-left x-coordinate for cropping the image
x_end   = 619;                  % top-right x-coordinate for cropping the image
y_0     = 1;                    % bottom-left y-coordinate for cropping the image
y_end   = 480;                  % top-right y-coordinate for cropping the image
n       = 4;                    % number of cores to use
                                        
%% Series loop over files
% Parallel loop over all files in the folder

for j = 1:length(filenames)
    
    VideoFilePath    = fullfile(MatfilesPath,strcat(filenames(j).name));   % name of the video
    disp(filenames(j).name)                                             % print name in Command Window
    vid       = VideoReader(VideoFilePath);                               % open the video
    dim       = vid.NumFrames;                                              % number of frames in the video
    data    = zeros(ydim,xdim,dim,'uint8');                               % assignation of memory
    
    for i=1:dim
        
        data(:,:,i) = readFrame(vid);                                     %read frame by frame
    
    end
    
    images = data;              %.frames; % Loads the frame images from the matfile file
    
    fprintf("Filtering\n")      % Prints in console "Filtering" to let you know when the process started
    
    data_filtered = FiltersFunction(images, xdim, ydim, size(images,3), GaussFilterSigma, FilterDiskSize, ...
        DilatationDiskSize);
    
    % Trim each picture to remove the borders and stores them in the given path
    TrimImage(data_filtered, x_0, x_end, y_0, y_end, dim, filenames(j).name, SavePath);    
    
end

fprintf("c'est fini\n") % Prints in console <<c'est fini>>
toc % Stops the clock