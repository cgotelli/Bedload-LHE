%% S3 - Post-processing
%
%
%
%
% -----------------------------------------------------------------------------------------------------------

clear all;
close all;

%% Outputs joining  

camera = "LESO";

fps = 30; % Image acquisition fps in the lab

[outputFilesPath, InfoVelFilenames, BSFilenames, ParticlesFilenames, MeanVelFilenames, SedFilenames, ...
    startFrame, endFrame] = S3dir;

VelDetail = joinOutputs(InfoVelFilenames);
disp('Done velocity computing information per frame')
BS = joinOutputs(BSFilenames);
disp('Done black surface per frame')
Particles = joinOutputs(ParticlesFilenames);
disp('Done with (all) particles information per frame')
MeanVel = joinOutputs(MeanVelFilenames);
disp('Done mean velocity per frame')
Sediment = joinOutputs(SedFilenames);
disp('Done sediment discharge per frame')

%%

window = 45;
normplot = 'yes';
plotTimeSeries(BS,'BS', normplot, window, fps)
plotTimeSeries(Sediment,'Sediment', normplot, window, fps)
plotTimeSeries(MeanVel,'MeanVel',normplot, window, fps)
