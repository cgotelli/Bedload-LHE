function [savePath, mainFolder, matfilesPath, framesPath, fid] = FirstThings(n)

c = clock;          % Saves the current date and time

% savePath = fullfile(pwd,'RawData'); % Where to save the experiment's files
savePath = uigetdir('D:\Videos\office', 'Select where to save the RAW images data');

mainFolder = fullfile(savePath, strcat(sprintf('%d',c(1)), sprintf('%02.0f',c(2)), sprintf('%02.0f', ... 
    c(3)), sprintf('%02.0f', c(4)), sprintf('%02.0f', c(5)))); % Where to keep all the files
mkdir(mainFolder)

matfilesPath = fullfile(mainFolder, 'matfiles'); % Creates folder for mat-files
mkdir(matfilesPath)

framesPath = fullfile(mainFolder, 'frames'); % Creates folder for frames
mkdir(framesPath)

% Creates and open logfile
fid = fopen(fullfile(mainFolder, strcat('LogFile_', sprintf('%d',c(1)), sprintf('%02.0f',c(2)), ... 
    sprintf('%02.0f',c(3)), sprintf('%02.0f',c(4)), sprintf('%02.0f',c(5)), '.txt')), 'a'); 



% Before starts, it checks how many cores are in the pool. If the number is
% zero, it creates a pool with n cores.
p = gcp('nocreate');

if isempty(p) && n~=1
    
    p = parpool(n);
    
end



end