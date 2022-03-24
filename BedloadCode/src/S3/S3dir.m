%
%
%

function [outputFilesPath, InfoVelFiles, BSFiles, ParticlesFiles, MeanVelFiles, ...
    SedFilenames, startFrame, endFrame] = S3dir()

outputFilesPath = uigetdir('G:\Calibration bed load', 'Path where Output matfiles are stored');

InfoVelFiles    = dir(fullfile(outputFilesPath, 'AllInfoVel_*.mat'));
BSFiles         = dir(fullfile(outputFilesPath, 'BS_*.mat'));
ParticlesFiles  = dir(fullfile(outputFilesPath, 'Particles_*.mat'));
MeanVelFiles    = dir(fullfile(outputFilesPath, 'MeanVel_*.mat'));
SedFilenames    = dir(fullfile(outputFilesPath, 'Sed_*.mat'));

startFrame  = str2double(BSFiles(1).name(end-13:end-4));
endFrame    = str2double(BSFiles(end).name(end-13:end-4));

end
