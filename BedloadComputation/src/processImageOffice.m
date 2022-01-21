%% Processing multiple images in parallel
function processImageOffice(obj, ~, fid, matfilesPath, saveFrames, framesPath)

% processImage is a Callback Function triggered by a videoinput
% FramesAvailable event. It uses PARFEVAL (Parallel Computing Toolbox) to 
% process images with a specific Function. It receives and object "obj"
% when its called, in our case is the videoinput object that triggered the
% use of this function. Also, it needs different parameters to be used by
% the function.

% Gets the data and metadata from the video object.
[data, ~, metadata] = getdata(obj, obj.FramesAcquiredFcnCount);

if saveFrames == 'y'
    
    writeTIFF(data, numel(metadata), framesPath, metadata(1).FrameNumber);

end 


if metadata(1).RelativeFrame == 1

    fprintf(fid, '%010.0f %02.0f %02.0f %05.2f', metadata(1).FrameNumber, metadata(1).AbsTime(4:6));

end

% Evaluates the Handle Function "@filtering" in parallel. Check this link
% for mor information:
% https://ch.mathworks.com/help/parallel-computing/parallel.pool.parfeval.html?searchHighlight=parfeval&s_tid=srchtitle
% The number 1 means that it returns one output, all the rest parameters
% are for being used by the function.

f = parfeval(@saveFrameOffice, 0, data, matfilesPath, metadata);

obj.UserData = data;

fprintf(fid, '\n%010.0f %02.0f %02.0f %05.2f', metadata(numel(metadata)).FrameNumber, ...
    metadata(numel(metadata)).AbsTime(4:6));

end