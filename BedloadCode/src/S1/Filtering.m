% This function filters and exports the filtered frames into a new folder named "Filtered" located one level
% higher than the working folder where the matfiles/videos are stored.
% The output images are stored as matfiles.
% The workflow depends on the type of file being process, as well as the way we process them (all or just a
% few selected files).

function Filtering(filesPath, filenames, FileType, ProcessingMode, FilteredPath, ...
    xdim, ydim, x_0, x_end, y_0, y_end, ...
    GaussFilterSigma, FilterDiskSize, DilatationDiskSize, cropping)

if strcmp(FileType, 'matfile') % For matfiles
    
    if strcmp(ProcessingMode, 'select') % For selected matfiles
        
        parfor j = 1:length(filenames)
            
            name    = fullfile(filesPath, filenames{j});
            disp(filenames{j})
            images  = load(name);
            images  = images.RAW_images;
            dim     = size(images,3);
            
            fprintf("Filtering\n")  % Prints in console "Filtering" to let you know when the process started
            
            % Applying filters to all images
            data_filtered   = FiltersFunction(images, xdim, ydim, dim, GaussFilterSigma, ...
                FilterDiskSize, DilatationDiskSize);
            
            % Cropping images
            if strcmp(cropping, 'yes')
                TrimImage(data_filtered, x_0, x_end, y_0, y_end, dim, ...
                filenames{j}, FilteredPath); %trim each picture to remove the borders
            else
                ExportFiltered(filenames{j}, FilteredPath, data_filtered);
            end
            
        end
        
    elseif strcmp(ProcessingMode, 'all') % For all matfiles in the folder
        
        parfor j = 1:length(filenames)
            
            name    = fullfile(filesPath, filenames(j).name);
            disp(filenames(j).name)
            images  = load(name);
            images  = images.RAW_images;
            dim     = size(images,3);
            
            fprintf("Filtering\n")  % Prints in console "Filtering" to let you know when the process started
            
            % Applying filters to all images
            data_filtered   = FiltersFunction(images, xdim, ydim, dim, GaussFilterSigma, ...
                FilterDiskSize, DilatationDiskSize);
            
            % Cropping images
            if strcmp(cropping, 'yes')
                TrimImage(data_filtered, x_0, x_end, y_0, y_end, dim, ...
                filenames(j).name, FilteredPath); %trim each picture to remove the borders
            else
                
                ExportFiltered(filenames(j).name, FilteredPath, data_filtered);
            
            end                
            
        end
        
    end
    
elseif strcmp(FileType, 'video') % Only for one file
    
    if strcmp(ProcessingMode, 'select') % For selected videos
        
        parfor j = 1:length(filenames)
            
            name    = fullfile(filesPath, filenames{j});
            disp(filenames{j})
            vid     = VideoReader(name);                  %open the video
            dim     = vid.NumFrames;
            data    = zeros(ydim,xdim,dim,'uint8');
            
            for i = 1:dim
                
                data(:,:,i) = readFrame(vid);               %read frame by frame
                
            end
            
            fprintf("Filtering\n") % Prints in console <<Filtering>> to let you know when the process started
            
            % Applying filters to all images
            data_filtered=FiltersFunction(data, xdim,ydim, dim, GaussFilterSigma, ...
                FilterDiskSize, DilatationDiskSize);
            
            % Cropping images
            if strcmp(cropping, 'yes')
                TrimImage(data_filtered, x_0, x_end, y_0, y_end, dim, ...
                filenames{j}, FilteredPath); %trim each picture to remove the borders
            else
                ExportFiltered(filenames{j}, FilteredPath, data_filtered);
            end

        end
        
        
    elseif strcmp(ProcessingMode, 'all') % For all videos in the folder
        
        parfor j = 1:length(filenames)
            
            name    = fullfile(filesPath, filenames(j).name);
            disp(filenames(j).name)
            vid     = VideoReader(name);                  %open the video
            dim     = vid.NumFrames;
            data    = zeros(ydim,xdim,dim,'uint8');
           
            for i=1:dim
                
                data(:,:,i) = readFrame(vid);               %read frame by frame
                
            end
                       
            fprintf("Filtering\n") % Prints in console <<Filtering>> to let you know when the process started
            
            % Applying filters to all images
            data_filtered   = FiltersFunction(data, xdim,ydim, dim, GaussFilterSigma, ...
                FilterDiskSize, DilatationDiskSize);
            
            % Cropping images
            if strcmp(cropping, 'yes')
                TrimImage(data_filtered, x_0, x_end, y_0, y_end, dim, ...
                filenames(j).name, FilteredPath); %trim each picture to remove the borders
            else
                
                ExportFiltered(filenames(j).name, FilteredPath, data_filtered);
                
            end
        end
        
    end
    
end

end
