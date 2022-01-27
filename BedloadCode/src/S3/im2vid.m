
function im2vid(images, fps, SavePath, name)
v = VideoWriter(fullfile(SavePath,[name,'.avi']));
v.FrameRate = fps;
open(v);
figure(1)
imshow(images(:,:,1))
for i = 2:size(images,3)
    imshow(images(:,:,i))
    frame = getframe;
    writeVideo(v,frame);
end
close(v);
end