% 
% 
% Check this link:
% https://ch.mathworks.com/help/imaq/videoinput.html?searchHighlight=videoinput&s_tid=srchtitle
% to learn how this Matlab Object works. 
% 
% To know the name of the camera adaptor, check this other link:
% https://ch.mathworks.com/help/imaq/imaqhwinfo.html

function [vid, src] = InitiateVideo(flume, fps, fid, matfilesPath, saveFrames, framesPath, EachHowMany)


if flume == "LESO"
    
    vid = videoinput('dcam', 1, 'Y8_640x480');
    src = getselectedsource(vid);
    
    src.Gain                = 192;
    src.Shutter             = 91;
    src.Brightness          = 16;
    vid.FramesPerTrigger    = 300;
    vid.LoggingMode         = 'disk';
    diskLogger              = VideoWriter('D:\Videos.avi', 'Grayscale AVI');
    diskLogger.FrameRate    = 30;
    vid.DiskLogger          = diskLogger;
    vid.TriggerRepeat       = 2;
    
elseif flume == "Office"    % Logitech Webcam C210 (winvideo-1)
    
    vid = videoinput('winvideo', 1, 'RGB24_640x480'); % Creates videoinput object
    src = getselectedsource(vid); % Return currently selected video source object
    
    % Camera's resolution
    xres        = 640;  % Image's width
    yres        = 480;  % Image's height
    yoffset     = 0;    % yoffset + ydim = total picture height
    
    
    % Acquisition parameters
    % vid.ReturnedColorspace = 'grayscale';
    vid.FramesPerTrigger = inf; % How many frames get per trigger.
    vid.ROIPosition = [0 yoffset xres yres-yoffset];
    vid.FramesAcquiredFcnCount = EachHowMany; % Number of frames stored in the memory needed to run the Callback Function "FramesAcquiredFcn".
    vid.LoggingMode = 'memory'; % Where to store the temporal data: memory, disk or disk&memory.
    vid.FramesAcquiredFcn = {@SaveFrames, fid, matfilesPath, saveFrames, framesPath}; % your normal callback code
    vid.StopFcn = {@closing, fid}; % When the camera stops recording, triggers the '@closing' Function. It creates the sample Video and closes the logfile.
    
    src.Brightness = 128;
    
    % The callback Function "FramesAcquiredFcn" triggers the '@processImage'
    % Function Handle when the number of frames specified before is reached.
    % This function is THE Function. It's in charge of processing the images in
    % parallel to accelerate the process and be able to do it in real time.
    
        
elseif flume == "laptop" % Clemente's ASUS
    
    vid = videoinput('winvideo', 1, 'MJPG_1280x720');
    vid.ReturnedColorspace = 'grayscale';
    vid.FramesPerTrigger = Inf;
    vid.LoggingMode = 'memory'; % Where to store the temporal data: memory, disk or disk&memory.
    vid.FramesAcquiredFcnCount = EachHowMany; % Number of frames stored in the memory needed to run the Callback Function "FramesAcquiredFcn".
    vid.FramesAcquiredFcn = {@SaveFrames, fid, matfilesPath, saveFrames, framesPath}; % your normal callback code
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
    
    src.Gain = 192;
    
end

end