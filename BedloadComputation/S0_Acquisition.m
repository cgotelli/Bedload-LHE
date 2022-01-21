%% Image acquisition and processing
% This code uses PARFEVAL (Parallel Computing Toolbox) to process images
% while the camera continues acquiring images. It needs other two files:
% "processImage.m" and "filtering.m".


close all;  % Close all windows
clear all;  % Clear the workspace
clc         % Clear console
imaqreset   % Clear all variables related to the videoinput object 


%% Parameter definitions
% We define the different parameters used by the functions.

% Camera's resolution
xres        = 640;  % Image's width
yres        = 480;  % Image's height
yoffset     = 0;    % yoffset + ydim = total picture height

% Parallel process
n           = 4;    % number of cores to use

% Image acquisition
fps         = 30;   % number of FPS
saveFrames  = 'y';  % Want to save the original frames? (y or n)
EachHowMany = 5*fps;% How many frames will have each matfile. It depends on the occupied RAM memory.
howLong     = 1;    % Time in minutes

% Prepare folders and LogFile
[savePath, mainFolder, matfilesPath, framesPath, fid] = FirstThings(n);

%% Videoinput object setup

[vid, src] = InitiateVideo(xres, yres, yoffset, fps, fid, matfilesPath, saveFrames, framesPath, EachHowMany);

%% Acquisition process

Recording(vid)

