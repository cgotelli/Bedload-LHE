%% Image acquisition and processing
% This code uses PARFEVAL (Parallel Computing Toolbox) to process images
% while the camera continues acquiring images. It needs other two files:
% "processImage.m" and "filtering.m".

imaqreset % Clear all variables related to the videoinput object 
close all; % Close all windows
clear all;

%% Parameter definitions
% We define the different parameters used by the functions.



xdim = 640; % Image's width
ydim = 480; % Image's height
n = 4; % number of cores to use
fps = 30; % number of FPS
saveFrames = 'y'; % Want to save the original frames? (y or n)

savePath = fullfile(pwd,'data'); % Where to save the experiment's files


c = clock; % Saves the current date and time


mainFolder = fullfile(savePath, strcat(sprintf('%d',c(1)), sprintf('%02.0f',c(2)), sprintf('%02.0f', ... 
    c(3)), sprintf('%02.0f', c(4)), sprintf('%02.0f', c(5)))); % Where to keep all the files
mkdir(mainFolder)


matfilesPath = fullfile(mainFolder, 'matfiles'); % Creates folder for mat-files
mkdir(matfilesPath)

framesPath = fullfile(mainFolder, 'frames'); % Creates folder for frames
mkdir(framesPath)

% Creates and open logfile
fid = fopen(fullfile(mainFolder, strcat('LogFile_', sprintf('%d',c(1)), sprintf('%02.0f',c(2)), ... 
    sprintf('%02.0f',c(3)), sprintf('%02.0f',c(4)), sprintf('%02.0f',c(5)), '.txt')), 'a'); 



% Before starts, it checks how many cores are in the pool. If the number is
% zero, it creates a pool with n cores.
p = gcp('nocreate');

if isempty(p) && n~=1
    
    p = parpool(n);
    
end


%% Videoinput object creation
% Check this link:
% https://ch.mathworks.com/help/imaq/videoinput.html?searchHighlight=videoinput&s_tid=srchtitle
% to learn how this Matlab Object works. To know the name of the camera
% adaptor, check this other link:
% https://ch.mathworks.com/help/imaq/imaqhwinfo.html

v = videoinput('winvideo', 1, 'RGB24_640x480'); % Creates videoinput object
s = getselectedsource(v); % Return currently selected video source object

% Acquisition parameters
% vid.ReturnedColorspace = 'grayscale';
v.FramesPerTrigger = inf; % How many frames get per trigger.
yoffset = 0; % yoffset + ydim = total picture height
v.ROIPosition = [0 yoffset xdim ydim-yoffset];
v.FramesAcquiredFcnCount = 5*fps; % Number of frames stored in the memory needed to run the Callback Function "FramesAcquiredFcn".
v.LoggingMode = 'memory'; % Where to store the temporal data: memory, disk or disk&memory.
 
s.Brightness = 128;
% s.Gain = 300;
% s.Shutter = 100;
% s.FrameRate = num2str(fps);

% The callback Function "FramesAcquiredFcn" triggers the '@processImage'
% Function Handle when the number of frames specified before is reached.
% This function is THE Function. It's in charge of processing the images in
% parallel to accelerate the process and be able to do it in real time.
v.FramesAcquiredFcn = {@SaveFrames, fid, matfilesPath, saveFrames, framesPath}; % your normal callback code

%% Acquisition process

start(v); % Starts the camera

v.StopFcn = {@closing,fid}; % When the camera stops recording, triggers the '@closing' Function. It creates the sample Video and closes the logfile.
