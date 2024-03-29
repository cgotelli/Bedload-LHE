% This function asks for the paths of the files to filter using a GUI. It can be done for specific files or
% for all the files inside a folder.
% It returns the list of names of the files to process, the folder where are stored and the path for the
% folder where the filtered matfiles will be saved.
%

function [filenames, filesPath, FilteredPath] = S1dir(n, FileType, ProcessingMode)

% Parallel computing setup
% Before starts, it checks how many cores are in the pool. If the number is *zero*, it creates a pool with *n*
% cores.

p = gcp('nocreate'); % pool

if isempty(p) && n~=1 % If it's empty and the number of cores is not set to one.
    
    p = parpool(n); % Creates parallel pool with *n* cores.
    
end

if strcmp(FileType, 'matfile') % If we want to process matfiles
    
    % Defines directory to use depending on the selected mode: select files, or all files in a folder.
    
    if strcmp(ProcessingMode, 'select') % For selected matfiles
        
        [filenames, filesPath] = uigetfile('D:\GitHub\Bedload-LHE\data\', ...
            'Select RAW Images matfiles to process', '*.mat', 'MultiSelect', 'on'); % Gets the names of the selected files, and stores them in a cell-type variable
        
        % ERROR HANDLE "Please, select at least 2 files to process."
        if ischar(filenames)
            
            errordlg('Please, select at least 2 files to process.','Selection Error');
            error('Please, select at least 2 files to process.')
            
        end
        
    elseif strcmp(ProcessingMode, 'all') % For every matfile inside the 'RAW_matfile' folder
        
        % Main path where we the video files are stored.
        
        filesPath = uigetdir('D:\GitHub\Bedload-LHE\data', 'Path where RAW Images matfiles are stored');
        
        filenames = dir(fullfile(filesPath, '*.mat')); % Gets all the files with *.mat extension inside the folder, and stores the information in a struct-type variable
        
    end
    
elseif strcmp(FileType, 'video') % If we want to process videos
    
    % Defines directory to use depending on the previously selected mode
    
    if strcmp(ProcessingMode, 'select') % For selected video files
        
        [filenames, filesPath] = uigetfile('D:\GitHub\Bedload-LHE\data', 'Select the RAW videos to process', ...
            '*.avi', 'MultiSelect', 'on'); % Gets the names of the selected files, and stores them in a cell-type variable
        
    elseif strcmp(ProcessingMode, 'all') % For every matfile inside the 'RAW_matfile' folder
        
        filesPath = uigetdir('D:\GitHub\Bedload-LHE\data', 'Path where RAW videos are stored');
        filenames = dir(fullfile(filesPath, '*.avi')); % Gets all the files with *.avi extension inside the folder, and stores the information in a struct-type variable
        
    end
    
end

FilteredPath = fullfile(filesPath, '..',strcat('Filtered_', fileparts(filesPath(end-24:end))));

% If the saving folder does not exist, it makes it
if ~exist(FilteredPath, 'dir')
    
    mkdir(FilteredPath)
    
end

end
