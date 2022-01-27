%% S3 - Post-processing
%
%
%
%
% -----------------------------------------------------------------------------------------------------------

clear all;
close all;

%% Parameters definition

mode = 'all'; % "single" or "all" folders)
fps = 60; % Image acquisition fps in the lab


if strcmp(mode, 'single')
    matfilespath = 'C:\Users\EPFL-LHE\Documents\MATLAB\videos_23_11\sed_dis_matfiles\attempt8\'; %'D:\LESO\doble_01\RAW_matfiles\Filtered\'; % Folder where the matfile is
    matfile = 'Sed_Filtered_attempt8_0001.mat'; %'Filtered_MatfileFrames_doble_01.mat'; % Matfile's name
    filenames = dir(fullfile(matfilespath, matfile)); % Full matfile's directory

elseif strcmp(mode, 'all')
    matfilespath = 'C:\Users\EPFL-LHE\Documents\MATLAB\videos_23_11\attempt13\matfiles\Particles\'; % Folder where the matfiles are
    filenames = dir(fullfile(matfilespath, 'Sed_Filtered*.mat')); % Search for all matfiles within specified directory with name starting by specified root
end

list_missing=[];
n=length(filenames)+length(list_missing);
trig_length=900;
pause_time=15;


x=linspace(0,(trig_length/fps)*n+pause_time*(n-1),trig_length*n+pause_time*fps*(n-1));
y=zeros(trig_length*n+pause_time*fps*(n-1),1);
bedload=0;
j_add=0;
for j = 1:n
   i_start=(trig_length+pause_time*fps)*(j-1)+1;
   if all(list_missing(:)~=j)
       data = load(fullfile(filenames(j-j_add).folder, filenames(j-j_add).name)); % Load one file at a time
       sed = data.sed; % Read sediment transport rate from data
       i_end=i_start+length(sed)-1;
       y(i_start:i_end)=sed;
       bedload=bedload+2*(900/899)*sum(sed)/fps;
   else
       j_add=j_add+1
   end
end
figure
plot(x,y)
xlabel('Time [s]', 'Fontsize',20,'interpreter','latex')
ylabel('Sediment bedload [$pix^2$]', 'Fontsize',20,'interpreter','latex')
fprintf('bedload = %0.1f\n',bedload);

