%% Initiate Video
% This function initiates the video and source objects for different cameras. Each camera has a setup that can
% be customized.
%
% Check this link:
% https://ch.mathworks.com/help/imaq/videoinput.html?searchHighlight=videoinput&s_tid=srchtitle
% to learn how video inputs and sources Matlab Object works.
%
% To know the name of the camera adaptor, check this other link:
% https://ch.mathworks.com/help/imaq/imaqhwinfo.html
%
% The callback Function "FramesAcquiredFcn" triggers the '@processImage'
% Function Handle when the number of frames specified before is reached.
% This function is THE Function. It's in charge of processing the images in
% parallel to accelerate the process and be able to do it in real time. We can modify the script to filter the
% images as well, but it requires either small images or a mega fast computer.

function [vid, src] = InitiateVideo(flume, fps, fid, matfilesPath, saveFrames, extension, framesPath, EachHowMany)

if flume == "LESO" % Camera of the prototype

    % Camera's resolution
    %     xres        = 640;  % Image's width
    %     yres        = 480;  % Image's height
    %     yoffset     = 0;    % yoffset + ydim = total picture height

    % CHANGE THIS SETUP TO STORE AS MATFILES INSTEAD OF AVI FILES.
    %vid = videoinput('dcam', 1, 'Y8_640x480');
%     vid.FramesPerTrigger    = 300;
%     vid.LoggingMode         = 'disk';
%     diskLogger              = VideoWriter('D:\Videos.avi', 'Grayscale AVI');
%     diskLogger.FrameRate    = 30;
%     vid.DiskLogger          = diskLogger;
%     vid.TriggerRepeat       = 2;
% 
%     src = getselectedsource(vid);
%     src.Gain                = 192;
%     src.Shutter             = 91;
%     src.Brightness          = 16;


elseif flume == "office"    % Logitech Webcam C210 (winvideo-1)

    % Camera's resolution
    xres        = 640;  % Image's width
    yres        = 480;  % Image's height
    yoffset     = 0;    % yoffset + ydim = total picture height


    % Acquisition parameters
    vid = videoinput('winvideo', 1, 'RGB24_640x480'); % Creates videoinput object
    vid.FramesPerTrigger = inf; % How many frames get per trigger.
    vid.ROIPosition = [0 yoffset xres yres-yoffset];
    vid.FramesAcquiredFcnCount = EachHowMany; % Number of frames stored in the memory needed to run the Callback Function "FramesAcquiredFcn".
    vid.LoggingMode = 'memory'; % Where to store the temporal data: memory, disk or disk&memory.
    vid.FramesAcquiredFcn = {@SaveFrames, fid, matfilesPath, saveFrames, framesPath, extension}; % your normal callback code
    vid.StopFcn = {@closing, fid}; % When the camera stops recording, triggers the '@closing' Function. It creates the sample Video and closes the logfile.
    vid.ReturnedColorspace = 'grayscale';

    src = getselectedsource(vid); % Return currently selected video source object
    src.Brightness = 128;

elseif flume == "laptop" % Clemente's ASUS personal laptop

    %     % Camera's resolution
    %     xres        = 640;  % Image's width
    %     yres        = 480;  % Image's height
    %     yoffset     = 0;    % yoffset + ydim = total picture height

    vid = videoinput('winvideo', 1, 'MJPG_1280x720');
    vid.ReturnedColorspace = 'grayscale';
    vid.FramesPerTrigger = Inf;
    vid.LoggingMode = 'memory'; % Where to store the temporal data: memory, disk or disk&memory.
    vid.FramesAcquiredFcnCount = EachHowMany; % Number of frames stored in the memory needed to run the Callback Function "FramesAcquiredFcn".
    vid.FramesAcquiredFcn = {@SaveFrames, fid, matfilesPath, saveFrames, framesPath, extension}; % your normal callback code
    vid.StopFcn = {@closing, fid}; % When the camera stops recording, triggers the '@closing' Function. It creates the sample Video and closes the logfile.

    src = getselectedsource(vid);
    src.Brightness = 0;
    src.Contrast = 50;
    src.Exposure = -6;
    src.Gamma = 300;
    src.Saturation = 64;
    src.Sharpness = 50;
    src.BacklightCompensation = 'off';
    src.WhiteBalanceMode = 'auto';




elseif flume == "Halle" % Main channel parameters. To be calibrated.

    %     % Camera's resolution
    %     xres        = 640;  % Image's width
    %     yres        = 480;  % Image's height
    %     yoffset     = 0;    % yoffset + ydim = total picture height
    vid = videoinput('gentl', 1, 'Mono8');
    src = getselectedsource(vid);
    src.AcquisitionFrameRate = fps;
    
    vid.ROIPosition = [648 738 2548 1415];

    %vid.ReturnedColorspace = 'grayscale';
    vid.FramesPerTrigger = Inf;
    vid.ReturnedColorspace = 'grayscale';
    vid.LoggingMode = 'memory'; 
    vid.FramesAcquiredFcnCount = EachHowMany; % Number of frames stored in the memory needed to run the Callback Function "FramesAcquiredFcn".
    vid.FramesAcquiredFcn = {@SaveFrames, fid, matfilesPath, saveFrames, framesPath, extension}; % your normal callback code
    vid.StopFcn = {@closing, fid}; % When the camera stops recording, triggers the '@closing' Function. It creates the sample Video and closes the logfile.


end

end