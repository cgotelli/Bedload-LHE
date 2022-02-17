% Complete workflow for estimating bed load sediment transport for a set of time windows. A time window is
% understood as the photos taken with the camera from the start of the pump until it is stopped. As in one day
% you can have more than one cycle of the pump (to scan the bed in between), it is possible that for one day
% you have multiple folders of photos. For each folder inside a given directory, it processes all the
% RAW_images files inside the subfolders. These folders to process are the ones created with the
% S0_Acquisition script that.


FileType = 'matfile';   % Choose in what format are the RAW images: "matfile" or "video"
n   = 4;                % number of cores to use


ProcessingMode = 'all';   % "select" or "all" folders

maxparticles= 15;           % Maximum number of particles to process by frame (~15)

fps         = 30;           % Frame rate for acquisition in the flume
distMaxVel  = 120;           % Max distance traveled by a particle between images. To avoid impossible pairs.
distMinVel  = 10;           % Min distance traveled by a particle between images. To avoid impossible pairs.
distMinIsol = 18;           % Separation to define isolated particles. Necessary for getting a mean velocity.
areamin     = 0.5;          % Lower threshold area to consider a particle in the counting process. In terms of mean.
areamax     = 5;            % Upper threshold area to consider a particle in the counting process. []
difs_th     = 0.05;         % logarithmic size threshold for identifying two similar particles.
x_dev       = 10;           % maximum allowed value of horizontal deviation between two consecutive images (in px).
lim_width   = 0.05;         % fraction of the image to exclude in the x axis for each border.
lim_height  = 0.05;         % fraction of the image to exclude in the y axis for each border.
skip        = 1;            % number of matfiles to skip for velocity computation. One each "skip" files.
imwidth     = 2700;         % image width
imheight    = 500;          % image height

% What camera are we using?
camera  = 'Halle'; % Options: LESO, office, laptop, Halle.

p = gcp('nocreate');

if isempty(p) && n~=1
    p = parpool(n);    
end

%% S1

% loads parameters
[GaussFilterSigma, FilterDiskSize, DilatationDiskSize, xdim, ydim, crop, x_0, x_end,...
    y_0, y_end, minSize] = paramsFiltering(camera);

% Get a list of all files and folders in this folder.
filesPath = uigetdir('D:', 'Path where subfolders are stored');
files = dir(filesPath);
dirFlags = [files.isdir];               % Get a logical vector that tells which is a directory.
subDirs = files(dirFlags);              % Extract only those that are directories.
subDirsNames = {subDirs(3:end).name};   % Get only the folder names into a cell array.
%%
for i = 1:length(subDirsNames)
    
    RAW_path{i} = fullfile(filesPath,subDirsNames{i},'RAW_matfiles');
    RAW_filenames = dir(fullfile(RAW_path{i}, '*.mat'));
    FilteredPath = fullfile(RAW_path, '..', 'Filtered');
    
    Filtering(RAW_path, RAW_filenames, FileType, ProcessingMode, FilteredPath, ...
        xdim, ydim, x_0, x_end, y_0, y_end, ...
        GaussFilterSigma, FilterDiskSize, DilatationDiskSize, crop, minSize)
    
    
    
%     Filtered_path = fullfile(filesPath,subDirsNames{i},'RAW_images');

end






%% S2





% [filesPath, filenames, SavePath] = S2dir(ProcessingMode, n);

Matching(filesPath, filenames, SavePath, ProcessingMode, skip, distMinIsol, ...
    areamin, areamax, lim_width, lim_height, distMinVel, distMaxVel, difs_th, x_dev, fps,...
    imheight, imwidth, maxparticles);

%Discharge_computation(SavePath, fps, imheight, imwidth);

