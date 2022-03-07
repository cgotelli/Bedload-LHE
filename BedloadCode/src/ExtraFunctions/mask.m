xlc = [50 35 1 1];
ylc = [500 0 0 500];

xrc = [2712 2712 2685 2677 ];
yrc = [0 500 500 0];

masklc = poly2mask(xlc,ylc,500,2712);
maskrc = poly2mask(xrc,yrc,500,2712);
complete_mask = masklc + maskrc;
%%
figure(1)
imshow(RAW_images(:,:,52))
poly_lc = drawpolygon('Position',left_corner);
poly_rc = drawpolygon('Position',right_corner);

mask_lc = createMask(poly_lc);
mask_rc = createMask(poly_rc);
added_masks = mask_lc + mask_rc;

figure(12)
imshow(added_masks)

figure(2)
imshow(data_filtered(:,:,449).*~added_masks);

figure(3)
imshow(data_filtered(:,:,450).*~added_masks);
