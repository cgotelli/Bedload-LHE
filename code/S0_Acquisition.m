%
% Acquisition code for the different cameras we can use (even for testing). 
% 
% * LESO: Is the prototype flume where to test this code and the calibration procedure.
% * Office: When working in the office with the webcam for testing the code.
% * Halle: The real flume for the experiments.
% 




flume = "Office"; % Options: LESO, Office, laptop, Halle.

% Camera parameters for acquisition. These values must be calibrated for the specific conditions of the
% experiment. What parameters to set, refer to "Image Acquisition" App from Matlab.

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
    
    src.Gain                = 0;
    src.Saturation          = 32;
    vid.FramesPerTrigger    = 300;
    vid.TriggerRepeat       = Inf;
    
elseif flume == "Halle"

    src.Gain = 192;
    
end 



first_part = 'C:\Users\EPFL-LHE\Documents\MATLAB\videos_23_11\attempt13\attempt13_' ;
extension = '.avi';


for i=1:20
    start(vid);
    pause(30);
    name=strcat(first_part, sprintf('%04d',i+1), extension);
    diskLogger = VideoWriter(name, 'Grayscale AVI');
    vid.DiskLogger = diskLogger;
end




