% Function that replaces what was done by regionprops function.

function [objarea,objcentroid] = Particles_info(A)
    Acc = bwconncomp(A);
    nobj = Acc.NumObjects;
    imsz = Acc.ImageSize;
    objarea = zeros(nobj,1);
    objcentroid = zeros(nobj,2);
    for k = 1:nobj
        thispl = Acc.PixelIdxList{k};
        objarea(k) = numel(thispl);
        [r, c] = ind2sub(imsz,thispl);
        objcentroid(k,:) = [mean(c) mean(r)];
    end
end