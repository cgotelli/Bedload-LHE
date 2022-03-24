function [complete_BS, complete_sed, complete_mvel] = plot_Summary(summaryPath)
    
    % List of files with information of different types
    BS_fileNames = dir(fullfile(summaryPath, '*_black_surface.mat'));
    sed_fileNames = dir(fullfile(summaryPath, '*_sed.mat'));
    mvel_fileNames = dir(fullfile(summaryPath, '*_mvel.mat'));

    % Join them into one single file of each type

    % Export complete files containing the information of the entire run


end
