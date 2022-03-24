%% S3 - Post-processing for a batch
%
%
%
%
% -----------------------------------------------------------------------------------------------------------

clear all;
close all;

camera = "Halle";

fps = 45; % Image acquisition fps in the lab

[foldersPath, subFolders] = S3dirBatch();

if ~exist(fullfile(foldersPath, 'runSummary'), 'dir')
    mkdir(fullfile(foldersPath, 'runSummary'))
end

for i = 1:length(subFolders)

    fprintf('\n------------------------------------------\n\n')
    disp(subFolders(i).name)
    fprintf('\n------------------------------------------\n\n')

    %     outputFilesPath = uigetdir('G:\Calibration bed load', 'Path where Output matfiles are stored');

    outputFilesPath = fullfile(foldersPath, subFolders(i).name,'Output');

    InfoVelFiles    = dir(fullfile(outputFilesPath, 'AllInfoVel_*.mat'));
    BSFiles         = dir(fullfile(outputFilesPath, 'BS_*.mat'));
    ParticlesFiles  = dir(fullfile(outputFilesPath, 'Particles_*.mat'));
    MeanVelFiles    = dir(fullfile(outputFilesPath, 'MeanVel_*.mat'));
    SedFiles        = dir(fullfile(outputFilesPath, 'Sed_*.mat'));



    [BS_fileName, BS] = joinOutputs(BSFiles);
    copyfile(BS_fileName, fullfile(foldersPath, 'runSummary'))
    disp('Done black surface per frame')

    [VelDetail_fileName, VelDetail] = joinOutputs(InfoVelFiles);
    copyfile(VelDetail_fileName, fullfile(foldersPath, 'runSummary'))
    disp('Done velocity computing information per frame')

    [MeanVel_fileName, MeanVel] = joinOutputs(MeanVelFiles);
    copyfile(MeanVel_fileName, fullfile(foldersPath, 'runSummary'))
    disp('Done mean velocity per frame')

    [Sediment_fileNamem, Sediment] = joinOutputs(SedFiles);
    copyfile(Sediment_fileNamem, fullfile(foldersPath, 'runSummary'))
    disp('Done sediment discharge per frame')

end

