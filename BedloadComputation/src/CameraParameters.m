%% Camera Parameters
% Function that creates the necessary variables for recording images. It receives as input the flume 
% we are using and loads the default parameters here below. These parameters were computed/calibrated before
% and then included in this function by hand.

function [vid, src, diskLogger] = CameraParameters(flume)


if flume == "LESO"
    
    vid = videoinput('dcam', 1, 'Y8_640x480');
    src = getselectedsource(vid);
    
    src.Gain                = 192;
    src.Shutter             = 91;
    src.Brightness          = 16;
    vid.FramesPerTrigger    = 300;
    vid.LoggingMode         = 'disk';
    diskLogger              = VideoWriter('D:\Videos.avi', 'Grayscale AVI');
    diskLogger.FrameRate    = 60;
    vid.DiskLogger          = diskLogger;
    vid.TriggerRepeat       = 2;
    
elseif flume == "Office"
    
    vid = videoinput('winvideo', 1, 'RGB24_640x480');
    src = getselectedsource(vid);
    
    vid.FramesPerTrigger = 1800;
    
    src.Gain                = 0;
    src.Saturation          = 32;
    src.Brightness          = 127;
    src.Exposure            = -8;
    src.Contrast            = 32;
    src.WhiteBalance        = 4000;
    vid.FramesPerTrigger    = 300;
    vid.TriggerRepeat       = Inf;
    
    vid.LoggingMode = 'disk';
    diskLogger = VideoWriter('D:\Videos\office\BedloadComputation.avi', 'Uncompressed AVI');
    vid.DiskLogger = diskLogger;
    diskLogger.FrameRate = 30;
    
elseif flume == "laptop"
    
    src.Gain = 192;
    
elseif flume == "Halle"
    
    src.Gain = 192;
    
end



end