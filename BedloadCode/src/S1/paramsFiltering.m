% Function to define parameters for filtering process based on the photos'camera of origin
% More options can be added below. Remember to change the value in main function S1_ImageFiltering

function [GaussFilterSigma, FilterDiskSize, DilatationDiskSize, xdim, ydim, crop, x_0, x_end,...
    y_0, y_end, minSize] = paramsFiltering(camera)

if strcmp(camera, 'LESO')
    
    GaussFilterSigma    = 0.5;      % Sigma value for Gauss's Filter
    FilterDiskSize      = 8;        % Disk size bothat filter
    DilatationDiskSize  = 0;        % Disk size for dilation function
    xdim    = 640;                  % Image's width
    ydim    = 480;                  % Image's height
    crop    = 'no';                 % Decide whter will trim the picture or not. 'yes' or 'no'.
    x_0     = 1;                    % bottom-left x-coordinate for cropping the image
    x_end   = 640;                  % top-right x-coordinate for cropping the image
    y_0     = 1;                    % bottom-left y-coordinate for cropping the image
    y_end   = 480;                  % top-right y-coordinate for cropping the image
    minSize = 10;                   % Minimum size to consider a cluster as a particle (in px)
    
elseif strcmp(camera, 'Halle')
    
    GaussFilterSigma    = 3;        % Sigma value for Gauss's Filter
    FilterDiskSize      = 20;       % Disk size bothat filter
    DilatationDiskSize  = 0;        % Disk size for dilation function
    xdim    = 2712;                 % Image's width
    ydim    = 500;                  % Image's height
    crop    = 'no';                 % Decide whter will trim the picture or not. 'yes' or 'no'.
    x_0     = 1;                    % bottom-left x-coordinate for cropping the image
    x_end   = 640;                  % top-right x-coordinate for cropping the image
    y_0     = 1;                    % bottom-left y-coordinate for cropping the image
    y_end   = 480;                  % top-right y-coordinate for cropping the image
    minSize = 50;                   % Minimum size to consider a cluster as a particle (in px)
    
elseif strcmp(camera, 'office')
    GaussFilterSigma    = 0.5;      % Sigma value for Gauss's Filter
    FilterDiskSize      = 8;        % Disk size bothat filter
    DilatationDiskSize  = 0;        % Disk size for dilation function
    xdim    = 640;                  % Image's width
    ydim    = 480;                  % Image's height
    crop    = 'no';                 % Decide whter will trim the picture or not. 'yes' or 'no'.
    x_0     = 1;                    % bottom-left x-coordinate for cropping the image
    x_end   = 640;                  % top-right x-coordinate for cropping the image
    y_0     = 1;                    % bottom-left y-coordinate for cropping the image
    y_end   = 480;                  % top-right y-coordinate for cropping the image
    minSize = 50;                   % Minimum size to consider a cluster as a particle (in px)
    
elseif strcmp(camera, 'laptop')
    GaussFilterSigma    = 0.5;      % Sigma value for Gauss's Filter
    FilterDiskSize      = 8;        % Disk size bothat filter
    DilatationDiskSize  = 0;        % Disk size for dilation function
    xdim    = 1280;                  % Image's width
    ydim    = 720;                  % Image's height
    crop    = 'no';                 % Decide whter will trim the picture or not. 'yes' or 'no'.
    x_0     = 1;                    % bottom-left x-coordinate for cropping the image
    x_end   = 640;                  % top-right x-coordinate for cropping the image
    y_0     = 1;                    % bottom-left y-coordinate for cropping the image
    y_end   = 480;                  % top-right y-coordinate for cropping the image
    minSize = 50;                   % Minimum size to consider a cluster as a particle (in px)
    
else
    errordlg('Please, enter a valid camera.','Camera error');
    error('Please, enter a valid camera.')
end

end
