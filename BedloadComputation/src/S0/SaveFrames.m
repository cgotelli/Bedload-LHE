%% Processing multiple images in parallel
function SaveFrames(obj, ~, fid, matfilesPath, saveFrames, framesPath, extension)

% processImage is a Callback Function triggered by a videoinput
% FramesAvailable event. It uses PARFEVAL (Parallel Computing Toolbox) to 
% process images with a specific Function. It receives an object "obj"
% when its called, in our case is the videoinput object that triggered the
% use of this function. Also, it needs different parameters to be used by
% the function.

% Gets the data and metadata from the video object.
[data, ~, metadata] = getdata(obj, obj.FramesAcquiredFcnCount);

% If the saveframes option is yes, it writes the images in the specified format.
if saveFrames == 'y'
    
    % INCLUDE OTHER FORMATS OPTIONS
    writeImage(data, numel(metadata), framesPath, metadata(1).FrameNumber, extension);

end

% For the first frame it register the time in the LogFile.
if metadata(1).RelativeFrame == 1

    fprintf(fid, '%010.0f %02.0f %02.0f %05.2f', metadata(1).FrameNumber, metadata(1).AbsTime(4:6));

end

% Evaluates the Handle Function "@filtering" in parallel. Check this link for mor information:
% https://ch.mathworks.com/help/parallel-computing/parallel.pool.parfeval.html?searchHighlight=parfeval&s_tid=srchtitle
% The number 0 means that it returns no output, all the rest parameters are arguments for the function.

f = parfeval(@FrameToMatfile, 0, data, matfilesPath, metadata);

% We take the data outside the function, to have it available in the workspace in case we want to check if
% there is any data delivered by the video object.
obj.UserData = data;

% After it stores the data into matfiles, it registers the exact time when it did it.
fprintf(fid, '\n%010.0f %02.0f %02.0f %05.2f', metadata(numel(metadata)).FrameNumber, ...
    metadata(numel(metadata)).AbsTime(4:6));

end