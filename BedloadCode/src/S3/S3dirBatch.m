%
%
%

function [foldersPath, subFolders] = S3dirBatch()


foldersPath = uigetdir('G:\', 'Path where folders with Filtered Images matfiles are stored');
d = dir(foldersPath);
subFolders  = d([d(:).isdir]);
subFolders = subFolders(~ismember({subFolders(:).name}, {'.','..'}));
subFolders = subFolders(~ismember({subFolders(:).name}, {'.','..', 'runSummary'}));


% outputFilesPath = uigetdir('G:\Calibration bed load', 'Path where Output matfiles are stored');
% 
% InfoVelFiles    = dir(fullfile(outputFilesPath, 'AllInfoVel_*.mat'));
% BSFiles         = dir(fullfile(outputFilesPath, 'BS_*.mat'));
% ParticlesFiles  = dir(fullfile(outputFilesPath, 'Particles_*.mat'));
% MeanVelFiles    = dir(fullfile(outputFilesPath, 'MeanVel_*.mat'));
% SedFiles        = dir(fullfile(outputFilesPath, 'Sed_*.mat'));

% startFrame  = str2double(BSFiles(1).name(end-13:end-4));
% endFrame    = str2double(BSFiles(end).name(end-13:end-4));

end
