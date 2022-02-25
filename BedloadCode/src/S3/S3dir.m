%
%
%

function [outputFilesPath, InfoVelFilenames, BSFilenames, ParticlesFilenames, MeanVelFilenames, ...
    SedFilenames, startFrame, endFrame] = S3dir()

outputFilesPath = uigetdir('D:\45fps\202202211456\Output', 'Path where Output matfiles are stored');
        
InfoVelFilenames = dir(fullfile(outputFilesPath, 'AllInfoVel_*.mat'));
BSFilenames = dir(fullfile(outputFilesPath, 'BS_*.mat'));
ParticlesFilenames = dir(fullfile(outputFilesPath, 'Particles_*.mat'));
MeanVelFilenames = dir(fullfile(outputFilesPath, 'MeanVel_*.mat'));
SedFilenames = dir(fullfile(outputFilesPath, 'Sed_*.mat'));

startFrame = str2double(BSFilenames(1).name(end-13:end-4));
endFrame = str2double(BSFilenames(end).name(end-13:end-4));

end
