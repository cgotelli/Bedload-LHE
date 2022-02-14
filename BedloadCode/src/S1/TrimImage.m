%% Trimming images
function TrimImage(data, x_0, x_end, y_0, y_end, n, name, savepath)
% 
data_filtered = zeros(y_end-y_0+1, x_end-x_0+1, n);
%x = false(xdim,ydim,n);

for i = 1:n 
    data_filtered(:,:,i) = data(y_0:y_end, x_0:x_end, i);
end

save(fullfile(savepath, strcat('Filtered_', name(1:end-3), 'mat')), 'data_filtered', '-v7.3');

end