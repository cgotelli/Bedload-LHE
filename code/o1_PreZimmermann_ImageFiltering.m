%% Zimmermann's Method - Image preprocessing

% This script applies the filtering to RAW images obtained from video acquisition. It works for several matfiles
% in the same folder or for a single file.
% It requires:
% * FiltersFunction: function with all filters to be applied.
% * Directory of the folder containing the videos


%% Working directories

% Cleans and closes everything.
clc;
close all;
clear all;

% Choose what method to use: all files inside the folder or just one specific file.
ProcessingMode = 'all'; % "single" or "all"

tic % Starts clock. It is used to know how long it takes to run the script.

% Main path where we the video files are stored.
VideoPath = uigetdir('C:\Users\gotelli\Videos', 'Path where files-to-process are stored');
% VideoPath = 'D:\00. Codes\01. MATLAB\02. GSD method - code\03. Matthieu-final\data-halle';

% Defines directory to use depending on the previously selected mode
if strcmp(ProcessingMode,'single') % Only for one file
    
    file = 'attempt13_0001.avi'; % matfile's name
    filenames = dir(fullfile(VideoPath, file)); % Full directory for the specific video
    
elseif strcmp(ProcessingMode, 'all') % For every matfile inside the 'RAW_matfile' folder
    
    filenames = dir(fullfile(VideoPath, '*.avi')); % Gets all the files with *.avi extension inside the folder.
    
end

% Path for saving filtered images
SavePath = fullfile(VideoPath, 'matfiles'); 

% If the saving folder does not exist, it makes it
if ~exist(SavePath, 'dir')
    mkdir(SavePath)
end

%% Parallel computing setup
% Before starts, it checks how many cores are in the pool. If the number is *zero*, it creates a pool with *n*
% cores.

n = 4; % number of cores to use

p = gcp('nocreate'); % pool

if isempty(p) && n~=1 % If it's empty and the number of cores is not set to one.
    
    p = parpool(n); % Creates parallel pool with *n* cores.

end

%% Filtering parameters

% These parameters must be estimated during the image calibration process previous to the sediment counter
% calibration.

GaussFilterSigma    = 0.5;      % Sigma value for Gauss's Filter
FilterDiskSize      = 8;        % Disk size bothat filter
DilatationDiskSize  = 0;        % Disk size for dilation function
xdim    = 2800;                  % Image's width
ydim    = 1000;                  % Image's height
x_0     = 27;                   % bottom-left x-coordinate for cropping the image
x_end   = 619;                  % top-right x-coordinate for cropping the image
y_0     = 1;                    % bottom-left y-coordinate for cropping the image
y_end   = 480;                  % top-right y-coordinate for cropping the image
                                        
%% Series loop over files
% Parallel loop over all files in the folder

for j = 1:length(filenames)
    
    VideoFilePath    = fullfile(VideoPath,strcat(filenames(j).name));   % name of the video
    disp(filenames(j).name)                                             % print name in Command Window
    v       = VideoReader(VideoFilePath);                               % open the video
    d       = v.NumFrames;                                              % number of frames in the video
    data    = zeros(ydim,xdim,d,'uint8');                               % assignation of memory
    
    for i=1:d
        
        data(:,:,i) = readFrame(v);                                     %read frame by frame
    
    end
    
    images = data;              %.frames; % Loads the frame images from the matfile file
    
    fprintf("Filtering\n")      % Prints in console "Filtering" to let you know when the process started
    
    data_filtered = FiltersFunction(images, xdim, ydim, size(images,3), GaussFilterSigma, FilterDiskSize, ...
        DilatationDiskSize);
    
    % Trim each picture to remove the borders and stores them in the given path
    TrimImage(data_filtered, x_0, x_end, y_0, y_end, d, filenames(j).name, SavePath);    
    
end

fprintf("c'est fini\n") % Prints in console <<c'est fini>>
toc % Stops the clock