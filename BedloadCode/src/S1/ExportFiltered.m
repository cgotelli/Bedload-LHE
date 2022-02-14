
function ExportFiltered(name, savepath, data_filtered)

save(fullfile(savepath, strcat('Filtered_', name(1:end-3), 'mat')), 'data_filtered', '-v7.3');

end