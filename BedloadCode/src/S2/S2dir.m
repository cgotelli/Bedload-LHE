% S2dir
% - This function asks for the paths of the files to filter using a GUI. It can be done for specific files or
% for all the files inside a folder.
% - It returns the list of names of the files to process, the folder where are stored and the path for the
% folder where the filtered matfiles will be saved.
%

function [filesPath, filenames, SavePath] = S2dir(ProcessingMode, n)

if strcmp(ProcessingMode, 'select')
    
    [filenames, filesPath] = uigetfile('D:\GitHub\Bedload-LHE\data\', ...
        'Select Filtered matfiles to process', '*.mat', 'MultiSelect', 'on'); % Gets the names of the selected files, and stores them in a cell-type variable
    
    % ERROR HANDLE "Please, select at least 2 files to process."
    if ischar(filenames)
        
        errordlg('Please, select at least 2 files to process.','Selection Error');
        error('Please, select at least 2 files to process.')
        
    end
    
elseif strcmp(ProcessingMode, 'all')
    
    filesPath = uigetdir('D:\GitHub\Bedload-LHE\data', 'Path where Filtered matfiles are stored');
    
    filenames = dir(fullfile(filesPath, '*.mat')); % Gets all the files with *.mat extension inside the folder, and stores the information in a struct-type variable
    
end

% If the saving folder does not exist, makes it
SavePath = fullfile(filesPath, '..', 'Output');

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
