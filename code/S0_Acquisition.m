vid = videoinput('dcam', 1, 'Y8_640x480');
src = getselectedsource(vid);

src.Gain = 192;
src.Shutter = 91;
src.Brightness = 16;


vid.FramesPerTrigger = 300;
vid.LoggingMode = 'disk';
diskLogger = VideoWriter('C:\Users\EPFL-LHE\Documents\MATLAB\videos_23_11\attempt13\attempt13_0001.avi', 'Grayscale AVI');
diskLogger.FrameRate = 60;
vid.DiskLogger = diskLogger;
vid.TriggerRepeat = 2;  % TriggerRepeat is zero based and is always one
% less than the number of triggers.

first_part = 'C:\Users\EPFL-LHE\Documents\MATLAB\videos_23_11\attempt13\attempt13_' ;
last_part = '.avi';


for i=1:20
    start(vid);
    pause(30);
    name=strcat(first_part, sprintf('%04d',i+1), last_part);
    diskLogger = VideoWriter(name, 'Grayscale AVI');
    vid.DiskLogger = diskLogger;
end




