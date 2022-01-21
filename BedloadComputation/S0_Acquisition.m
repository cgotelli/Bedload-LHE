%% Image acquisition and processing
% This code uses PARFEVAL (Parallel Computing Toolbox) to process images
% while the camera continues acquiring images. It needs other two files:
% "processImage.m" and "filtering.m".


close all;  % Close all windows
clear all;  % Clear the workspace
imaqreset   % Clear all variables related to the videoinput object 


%% Parameter definitions
% We define the different parameters used by the functions.


% Camera's resolution
xres        = 640;  % Image's width
yres        = 480;  % Image's height
yoffset     = 0;    % yoffset + ydim = total picture height
fps         = 30;   % number of FPS

n           = 4;    % number of cores to use
saveFrames  = 'y';  % Want to save the original frames? (y or n)

c = clock;          % Saves the current date and time

[savePath, mainFolder, matfilesPath, framesPath, fid] = FirstThings(n, c);


%% Videoinput object setup

[v, s] = InitiateVideo(xres, yres, yoffset, fps, fid, matfilesPath, saveFrames, framesPath);

%% Acquisition process

start(v);                   % Starts the camera


