function [ words, frames ] = SSI_w_DSIFT( VOCopts, I, annot )

if size(I,3) > 1
    I = rgb2gray(I);
end
I = single(I);

opts = VOCopts.dsift;

if opts.onlyBB && isstruct(annot)
    % [XMIN, YMIN, XMAX, YMAX]
    bounds = annot.objects.bbox;
else
    bounds = [0, 0, size(I,2), size(I,1)];
end

[frames, words] = vl_dsift(I, 'size', opts.binSize,...
                         'step', opts.step,...
                         'FAST', ...
                         'bounds', bounds);
end

