

function [fileName, joinedData] = joinOutputs(filesCell)

joinedData = [];
experimentName = split(filesCell(1).folder,'\');
experimentName = experimentName{end};


for i = 1:length(filesCell)
    data = load(fullfile(filesCell(i).folder, filesCell(i).name));
    arrayName = fields(data);
    arrayName = arrayName{1};
    
    if strcmp(arrayName, 'black_surface')
        
        data = data.black_surface;
        
    elseif strcmp(arrayName, 'velocity')
        
        data = data.velocity;
        
    elseif strcmp(arrayName, 'mvel')
        
        data = data.mvel;
        
    elseif strcmp(arrayName, 'particles')
        
        data = data.particles;
        
    elseif strcmp(arrayName, 'sed')
        
        data = data.sed;
        
    end
    
    joinedData = [joinedData; ones(length(data),1)*i, data(:,:)];
    
end
fileName = fullfile(filesCell(1).folder, '..', strcat(experimentName, '_', arrayName,".mat"));
save(fileName, 'joinedData' ,'-v7.3')
end
