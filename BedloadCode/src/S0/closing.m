% Function for closing the LogFile. It has to be a function since it is triggered as a handle function. That's
% also the reason why we have two ~ inputs at the beginning. 
function closing(~, ~, fid)

% Displays a message of closing file.
disp('Closing LogFile')

% Makes the closure of the LogFile.
fclose(fid);

end