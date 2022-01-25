%% S0 - Image acquisition

% This is the step zero of the process: recording the images/frames of the particles passing through the
% outlet of the flume. This code uses PARFEVAL (Parallel Computing Toolbox) to store the images from the
% camera in *.mat format. It can be modified to include the filtering process (Step 1) in the same real-time
% workflow. However, to make both things in parallel in the same computer can be extremely demanding in
% resources, and the computer may not be capable of doing it. 

% To run it needs the following functions:
% * FrameToMatfile.m
% * FirstThings.m
% * InitiateVideo.m
% * Recording.m
% -----------------------------------------------------------------------------------------------------------

close all;  % Close all windows
clear all;  % Clear the workspace
clc         % Clear console
imaqreset   % Clear all variables related to the videoinput object 

%% Parameters definitions
% We define the different parameters used by the functions.

% What camera are we using?
flume   = "office";     % Options: LESO, office, laptop, Halle. Edit InitiateVideo.m to add options.

% Parallel process
n   = 4;                % number of cores to use

% Image acquisition
fps         = 30;       % number of FPS
saveFrames  = 'n';      % Want to save the original frames? (y or n)
EachHowMany = 5*fps;    % How many frames will have each matfile. It depends on the occupied RAM memory.

%% Prepare folders and LogFile

[savePath, mainFolder, matfilesPath, framesPath, fid] = S0dir(n, saveFrames);

%% Videoinput object setup

[vid, src] = InitiateVideo(flume, fps, fid, matfilesPath, saveFrames, framesPath, EachHowMany);

%% Acquisition process

Recording(vid)

% Execute stop(vid) in the command window to stop the video acquisition.