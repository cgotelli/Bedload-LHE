% Discharge_computation 
% Calculates the sediment discharge based in the black surface of particles and the mean
% velocity. The sediment discharge is calculated as: Sed_discharge = alpha.BS.v_mean.fps/height

function sed = Discharge_computation(SavePath, fps, height, width)
%mvel, particles, fps, height, width, BS, SavePath, filesPath, filenames)

% name    = fullfile(filesPath, filenames{j}); images  = load(name); images  = images.data_filtered; tam     =
% size(images);                                             % Array's size height  = tam(1);
% % Image's height width   = tam(2);                                                   % Image's width


% ,filenames(j).name


% particles, fps, mvel, BS

Particles_filenames = dir(fullfile(SavePath, 'Particles_*.mat')); % Gets all the files with *.avi extension
Mvel_filenames = dir(fullfile(SavePath, 'MeanVel_*.mat')); % Gets all the files with *.avi extension
BS_filenames = dir(fullfile(SavePath, 'BS_*.mat')); % Gets all the files with *.avi extension

for j = 1:length(Particles_filenames)
    
    name    = fullfile(SavePath, Particles_filenames(j).name);
    particles_file  = load(name);
    particles  = particles_file.particles;
    
    
    name = fullfile(SavePath, Mvel_filenames(j).name);
    Mvel_file = load(name);
    mvel = Mvel_file.mvel;
    
    name = fullfile(SavePath, BS_filenames(j).name);
    BS_file = load(name);
    BS = BS_file.black_surface;
    
    
    num_frames      = particles(end, 1); % Total number of frames to process
    meanWindow      = fps; % To smooth velocity time series. In frames. For Zimmermann was +- 15 seconds. Here we want a nearly-instantaneous velocity
    smooth_meanVel  = smoothdata(mvel(:, 1), 'movmean', meanWindow); % Velocity time series averaged over a window.
    
    sed = zeros(num_frames - 1, 1);  % Empty sediment information array
    
    for i = 1:num_frames - 1      % Loop over all frames where the velocity has been computed
        
        bedload = BS(i)*smooth_meanVel(i)/height;
        
        sed(i, 1)  = bedload;
        
    end
    
    SedFileName = strcat('Sed_', Particles_filenames(j).name(11: end));
    save(fullfile(SavePath, SedFileName ), 'sed'); % Stores sediment discharge
    
    disp(strcat('We passed the sediment discharge computation' , " -------> " , SedFileName))
end

end
