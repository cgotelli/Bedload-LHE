%% S3 - Post-processing for a batch
%
%
%
%
% -----------------------------------------------------------------------------------------------------------

clear all;
close all;

[foldersPath, subFolders] = S3dirBatch();

if ~exist(fullfile(foldersPath, 'runSummary'), 'dir')
    mkdir(fullfile(foldersPath, 'runSummary'))
end

tsBS        = [];
tsSediment  = [];
tsMeanVel   = [];

for i = 1:length(subFolders)

    fprintf('\n------------------------------------------\n\n')
    disp(subFolders(i).name)
    fprintf('\n------------------------------------------\n\n')

    %     outputFilesPath = uigetdir('G:\Calibration bed load', 'Path where Output matfiles are stored');

    outputFilesPath = fullfile(foldersPath, subFolders(i).name);

    InfoVelFiles    = dir(fullfile(outputFilesPath, 'AllInfoVel_*.mat'));
    BSFiles         = dir(fullfile(outputFilesPath, 'BS_*.mat'));
    ParticlesFiles  = dir(fullfile(outputFilesPath, 'Particles_*.mat'));
    MeanVelFiles    = dir(fullfile(outputFilesPath, 'MeanVel_*.mat'));
    SedFiles        = dir(fullfile(outputFilesPath, 'Sed_*.mat'));
    
    if ~isempty(BSFiles)
        [BS_fileName, BS] = joinOutputs(BSFiles);
    copyfile(BS_fileName, fullfile(foldersPath, 'runSummary'))
    tsBS = [tsBS; BS];
    save(fullfile(foldersPath, 'runSummary', 'tsBS.mat'), 'tsBS' ,'-v7.3');
    disp('Done black surface per frame')
    end 

    if ~isempty(InfoVelFiles)
    [VelDetail_fileName, VelDetail] = joinOutputs(InfoVelFiles);
    copyfile(VelDetail_fileName, fullfile(foldersPath, 'runSummary'))
    disp('Done velocity computing information per frame')
    end

    if ~isempty(MeanVelFiles)
    [MeanVel_fileName, MeanVel] = joinOutputs(MeanVelFiles);
    copyfile(MeanVel_fileName, fullfile(foldersPath, 'runSummary'))
    tsMeanVel = [tsMeanVel; MeanVel];
    save(fullfile(foldersPath, 'runSummary', 'tsMeanVel.mat'), 'tsMeanVel' ,'-v7.3');
    disp('Done mean velocity per frame')
    end 
    if ~isempty(SedFiles)
    [Sediment_fileNamem, Sediment] = joinOutputs(SedFiles);
    copyfile(Sediment_fileNamem, fullfile(foldersPath, 'runSummary'))
    tsSediment = [tsSediment; Sediment];
    save(fullfile(foldersPath, 'runSummary', 'tsSediment.mat'), 'tsSediment' ,'-v7.3');
    disp('Done sediment discharge per frame')
    end 

end

