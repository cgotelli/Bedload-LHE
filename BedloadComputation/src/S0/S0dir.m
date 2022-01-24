% This function initializes all the folders, register the clock, starts the LogFile, and starts the parallel
% pool if is not already running.

function [savePath, mainFolder, matfilesPath, framesPath, fid] = S0dir(n, saveFrames)

% Saves the current date and time
c = clock;

% Asks for the directory where to store the RAW images.
savePath = uigetdir('D:\Videos\office', 'Select where to save the RAW images data');

% In the given paths creates a folder with the starting time in the name
mainFolder = fullfile(savePath, strcat(sprintf('%d',c(1)), sprintf('%02.0f',c(2)), sprintf('%02.0f', ...
    c(3)), sprintf('%02.0f', c(4)), sprintf('%02.0f', c(5)))); % Where to keep all the files
mkdir(mainFolder)

% Inside this folder, it creates a subfolder where to store the matfiles of the images
matfilesPath = fullfile(mainFolder, 'RAW_matfiles'); % Creates folder for mat-files
mkdir(matfilesPath)

% If the saveframe option is yes, it also creates a folder to store the video frames in tif/jpeg/png format.
if saveFrames == 'y'
    
    framesPath = fullfile(mainFolder, 'frames'); % Creates folder for frames
    mkdir(framesPath)    
else 
    framesPath = matfilesPath;
end

% Creates and open logfile inside the main RAW data folder.
fid = fopen(fullfile(mainFolder, strcat('LogFile_', sprintf('%d',c(1)), sprintf('%02.0f',c(2)), ...
    sprintf('%02.0f',c(3)), sprintf('%02.0f',c(4)), sprintf('%02.0f',c(5)), '.txt')), 'a');



% Before starts, it checks how many cores are in the pool. If the number is zero, it creates a 
% pool with n cores.

p = gcp('nocreate');

if isempty(p) && n~=1
    
    p = parpool(n);
    
end

end