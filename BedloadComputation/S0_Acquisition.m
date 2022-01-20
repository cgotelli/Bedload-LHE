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

[vid, src, diskLogger] = CameraParameters(flume);

first_part = 'C:\Users\EPFL-LHE\Documents\MATLAB\videos_23_11\attempt13\attempt13_' ;

extension = '.avi';


for i=1:20
    start(vid);
    pause(30);
    name=strcat(first_part, sprintf('%04d',i+1), extension);
    diskLogger = VideoWriter(name, 'Grayscale AVI');
    vid.DiskLogger = diskLogger;
end



% stop(vid)
