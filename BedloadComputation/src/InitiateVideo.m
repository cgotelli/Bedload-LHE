function [v, s] = InitiateVideo(xres, yres, yoffset, fps, fid, matfilesPath, saveFrames, framesPath)

% Check this link:
% https://ch.mathworks.com/help/imaq/videoinput.html?searchHighlight=videoinput&s_tid=srchtitle
% to learn how this Matlab Object works. 
% 
% To know the name of the camera adaptor, check this other link:
% https://ch.mathworks.com/help/imaq/imaqhwinfo.html

v = videoinput('winvideo', 1, 'RGB24_640x480'); % Creates videoinput object
s = getselectedsource(v); % Return currently selected video source object

% Acquisition parameters
% vid.ReturnedColorspace = 'grayscale';
v.FramesPerTrigger = inf; % How many frames get per trigger.

v.ROIPosition = [0 yoffset xres yres-yoffset];
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

v.StopFcn = {@closing,fid}; % When the camera stops recording, triggers the '@closing' Function. It creates the sample Video and closes the logfile.

end