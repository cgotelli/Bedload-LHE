
function im2animation(images, ptime)

for i = 1:size(images,3)

    figure(1)
    imshow(images(:,:,i))
    title(['Frame number: ',int2str(i)],'interpreter','latex')
    pause(ptime);

end

end