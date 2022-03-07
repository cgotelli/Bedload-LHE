left_corner = [50 500; 35 1; 1 1; 1 500];
right_corner = [2712 1; 2712 500; 2690 500; 2677 1];


figure(1)
imshow(RAW_images(:,:,52))
poly_lc = drawpolygon('Position',left_corner);
poly_rc = drawpolygon('Position',right_corner);

mask_lc = createMask(poly_lc);
mask_rc = createMask(poly_rc);
added_masks = mask_lc + mask_rc;

figure(1)
imshow(added_masks)

figure(2)
imshow(~data_filtered(:,:,52).*~added_masks);

