
function [foldersPath, subFolders] = S1dirBatch(n)

p = gcp('nocreate'); % pool

if isempty(p) && n~=1 % If it's empty and the number of cores is not set to one.
    
    p = parpool(n); % Creates parallel pool with *n* cores.
    
end

foldersPath = uigetdir('E:\', 'Path where folders with RAW Images matfiles are stored');
d = dir(foldersPath);
subFolders  = d([d(:).isdir]);
subFolders = subFolders(~ismember({subFolders(:).name},{'.', '..', 'runSummary'}));


end
