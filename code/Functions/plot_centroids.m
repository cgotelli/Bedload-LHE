function plot_centroids(images, stats, number, single,fps)
% Plots images with each particle's centroid. It can plot a single image or a serie of images starting from a
% selected frame and with a speed defined by the specified fps.
% Inputs: 
% - images: array with images to plot
% - stats: array with centroid positions in columns 3 (x-axis) and 4 (y-axis)
% - number: frame number for the first frame in case of sequence (or unique frame in case of single frame option)
% - single: to select if its a single frame to plot, or a sequence. 1 for single, 0 for sequence.
% - fps: frames per second for plotting.


% Position for plotting and plot's size
x0 = 10;
y0 = 10;
width = 1280;
height = 360;

n = number;

% For single image plot
if single == 1
    
    filtered = stats(stats(:, 1) == n, :); % Selects all values corresponding to the requiered frame
    figure(n) % Opens the figure in a new specific window
    imshow(images(:, :, n)) % Plots the image
    hold on
    plot(filtered(:, 3), filtered(:, 4), 'r.', 'LineWidth', 2, 'MarkerSize', 20) % Plots the centroids

% For image sequence
elseif single == 0
    
    for i = n:size(images, 3) % For over all images from start point
        filtered = stats(stats(:,1) == i, :); % Selects all values corresponding to the requiered frame
        set(gcf, 'position', [x0, y0, width, height]) %
        title(['Frame #: ', num2str(i)]) % Shows frame number in title
        imshow(images(:, :, i)) % Plots the image
        hold on
        plot(filtered(:, 3), filtered(:, 4), 'r.', 'LineWidth', 2, 'MarkerSize', 20) % Plots the centroids
        pause(1/fps) % Pause according to selected fps
    end
    
else
    % In case there is a problem specifying if it's a single image or a sequence
    disp('4th input must be 1: single image or 0: sequence of images')
end