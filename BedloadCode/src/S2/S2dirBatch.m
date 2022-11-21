

function [foldersPath, subFolders] = S2dirBatch(n)

p = gcp('nocreate'); % pool

if isempty(p) && n~=1 % If it's empty and the number of cores is not set to one.
    
    p = parpool(n); % Creates parallel pool with *n* cores.
    
end

foldersPath = uigetdir('E:\00.EXPERIMENTS\00_bedload', 'Path where folders with for different measurements are stored');
d = dir(foldersPath);
subFolders  = d([d(:).isdir]);
subFolders = subFolders(~ismember({subFolders(:).name},{'.', '..', 'runSummary'}));


end
