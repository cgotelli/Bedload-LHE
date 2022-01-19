function surf = black_surface(img,xdim,ydim,folder,filename)
% Calculates the black area corresponding to the particles surface

n = size(img, 3);

surf = []; % Empty sediment information array
for i = 1:n % Loop over all frames
    surf(i)=xdim*ydim-sum(sum(img(:,:,i)));
end
save(fullfile(folder, strcat('BS_', filename)), 'surf'); % save black surface 
end