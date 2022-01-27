% Discharge_computation
% Calculates the sediment discharge based in the black surface of particles and the mean velocity. 
% The sediment discharge is calculated as: Sed_discharge = alpha.BS.v_mean.fps/height

function sed = Discharge_computation(mvel, particles, fps, height, width, BS, folder, filename)

num_frames      = particles(end, 1); % Total number of frames to process
meanWindow      = fps; % To smooth velocity time series. In frames. For Zimmermann was +- 15 seconds. Here we want a nearly-instantaneous velocity
smooth_meanVel  = smoothdata(mvel(:, 2), 'movmean', meanWindow); % Velocity time series averaged over a window.

sed = zeros(num_frames - 1, 1);  % Empty sediment information array

for i = 1:num_frames - 1      % Loop over all frames where the velocity has been computed
    
    bedload = BS(i)*smooth_meanVel(i)/height;
    
    sed(i, 1)  = bedload;
    
end

save(fullfile(folder, strcat('Sed_', filename(10: end))), 'sed'); % Stores sediment discharge

end
