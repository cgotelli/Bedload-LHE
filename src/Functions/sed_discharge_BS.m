function sed = Sed_discharge_BS(mvel, particles, fps, height,width,BS, folder, filename)
% Calculates the sediment discharge based in the black surface of particles
% and on the mean velocity. The sediment discharge is calculated as:
% Sed_load=alpha.BS.v_mean.fps/y_dim

num_frames = particles(end,1); % Total number of frames to process
meanWindow = 10; % To smooth velocity time series. In frames. For Zimmermann was +- 15 seconds. Here we want a nearly-instantaneous velocity
smooth_meanVel = smoothdata(mvel(:,2),'movmean',meanWindow); % Velocity time series averaged over a window.

sed = []; % Empty sediment information array
for i = 1:num_frames-1 % Loop over all frames where the velocity has been computed
    
    bedload=BS(i)*smooth_meanVel(i)/height;
    sed = [sed; bedload];
end

save(fullfile(folder, strcat('Sed_', filename)), 'sed'); % save mean velocity
end