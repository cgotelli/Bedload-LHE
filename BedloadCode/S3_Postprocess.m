%% S3 - Post-processing
%
%
%
%
% -----------------------------------------------------------------------------------------------------------

clear all;
close all;

%% Outputs joining  

camera = "Halle";

fps = 25; % Image acquisition fps in the lab

[outputFilesPath, InfoVelFiles, BSFiles, ParticlesFiles, MeanVelFiles, SedFiles, ...
    startFrame, endFrame] = S3dir;

% [Particles_fileName, Particles] = joinOutputs(ParticlesFiles);
% disp('Done velocity computing information per frame')

% [VelDetail_fileName, VelDetail] = joinOutputs(InfoVelFiles);
% disp('Done velocity computing information per frame')
% 
[BS_fileName, BS] = joinOutputs(BSFiles);
disp('Done black surface per frame')
% 
% [MeanVel_fileName, MeanVel] = joinOutputs(MeanVelFiles);
% disp('Done mean velocity per frame')

% [Sediment_fileName, Sediment] = joinOutputs(SedFiles);
% disp('Done sediment discharge per frame')

%%

window = 25;
normplot = 'yes';
plotTimeSeries(BS,'BS', normplot, window, fps)
% plotTimeSeries(Sediment,'Sediment', normplot, window, fps)
% plotTimeSeries(MeanVel,'MeanVel',normplot, window, fps)


meanBS = mean(BS(:,2))
% meanSed = mean(Sediment(:,2), 'omitnan')

sumBS = sum(BS(:,2))
% sumSed = sum(Sediment(:,2), 'omitnan')

