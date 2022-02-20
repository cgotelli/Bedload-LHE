function timeseries_analysis(velocity,img,frame)

v=velocity(velocity(:,1)==frame,:);
img1=img(:,:,frame);
img2=img(:,:,frame+1);
figure();
subplot(211);
imshow(img1);
hold on
plot(v(:,2),v(:,3),'b*');
for ii = 1:length(v(:,2))
    text(v(ii,2)+3,v(ii,3)+1,num2str(ii),'Color','r')
end
hold off
subplot(212);
imshow(img2);
hold on
plot(v(:,4),v(:,5),'b*');
for ii = 1:length(v(:,4))
    text(v(ii,4)+3,v(ii,5)+1,num2str(ii),'Color','r')
end

hold off

end
