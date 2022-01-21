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
    diskLogger.FrameRate    = 30;
    vid.DiskLogger          = diskLogger;
    vid.TriggerRepeat       = 2;
    
elseif flume == "Office" % Logitech Webcam C210 (winvideo-1)
    
    % Creates video object from camera
    vid = videoinput('winvideo', 1, 'RGB24_640x480');
    src = getselectedsource(vid);
    
    % Camera parameters
    src.Gain                = 0;
    src.Saturation          = 32;
    src.Brightness          = 127;
    src.Exposure            = -8;
    src.Contrast            = 32;
    src.WhiteBalance        = 4000;
    src.FrameRate           = '30.0000';
    
    
    vid.FramesPerTrigger    = 1800;
    vid.LoggingMode         = 'disk';
    diskLogger              = VideoWriter('D:\Videos\office\BedloadComputation.avi');
    diskLogger.FrameRate    = 30;    
    vid.DiskLogger          = diskLogger;    
    vid.TriggerRepeat       = 2;
    
    
    

    
elseif flume == "laptop" % Clemente's ASUS
    
    src.Gain = 192;
    
elseif flume == "Halle" % Main channel parameters. To be calibrated.
    
    src.Gain = 192;
    
end



end