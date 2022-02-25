

function joinedData = joinOutputs(filesCell)

dataName = split(filesCell(1).name,'_');
dataName = dataName{1};
FileName = strcat('Joined_',dataName);
joinedData = [];
experimentName = split(filesCell(1).folder,'\');
experimentName = experimentName{end-1};

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

save(fullfile(filesCell(1).folder, '..', strcat(experimentName, '_', arrayName,".mat")), 'joinedData' ,'-v7.3')
end
