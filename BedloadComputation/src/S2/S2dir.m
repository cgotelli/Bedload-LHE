% This function asks for the paths of the files to filter using a GUI. It can be done for specific files or
% for all the files inside a folder.
% It returns the list of names of the files to process, the folder where are stored and the path for the
% folder where the filtered matfiles will be saved.
%

function [matfilespath, filenames,SavePath] = S2dir(mode, n)

if strcmp(mode, 'single')
    
    matfilespath = 'D:\00. Codes\01. MATLAB\02. GSD method - code\Matthieu-final\data13\matfiles\'; %'D:\LESO\doble_01\RAW_matfiles\Filtered\'; % Folder where the matfile is
    
    matfile = 'Filtered_attempt13_0001.mat'; %'Filtered_MatfileFrames_doble_01.mat'; % Matfile's name
    
    filenames = dir(fullfile(matfilespath, matfile)); % Full matfile's directory
    
elseif strcmp(mode, 'all')
    
    matfilespath = 'D:\00. Codes\01. MATLAB\02. GSD method - code\Matthieu-final\data13\matfiles\'; % Folder where the matfiles are
    
    filenames = dir(fullfile(matfilespath, '*.mat')); % Search for all matfiles within specified directory

end

% If the saving folder does not exist, makes it
SavePath = fullfile(matfilespath, 'Particles');

if ~exist(SavePath, 'dir')
    
    mkdir(SavePath)

end


%% Parallel computing setup (Not using for now)

% Before starts, it checks how many cores are in the pool. If the number is
% zero, it creates a pool with n cores.

p = gcp('nocreate');

if isempty(p) && n~=1
    
    p = parpool(n);

end

end
