function [ words, frames ] = SSI_w_PHOW( VOCopts, I, annot  )
I = single(I);

opts = VOCopts.phow;
if opts.onlyBB && isstruct(annot)
    % [XMIN, YMIN, XMAX, YMAX]
    bounds = annot.objects.bbox;
    
    bounds = bounds + VOCopts.bboxPadding;
    
    % imcrop(I,rect), rect is [xmin ymin width height] 
    I = imcrop(I, [bounds(1:2), bounds(3:4) - bounds(1:2)]); 
end
    
%1: gray, 2: hsv, 3: rgb, 4: opponent
switch opts.color
    case 1
        colora = 'gray';
    case 2
        colora = 'hsv';
    case 3
        colora = 'rgb';
    case 4
        colora = 'opponent';
    otherwise 
        colora = 'gray';     
end


[frames, words] = vl_phow(I, 'sizes', opts.sizes,...
                         'step', opts.step,...
                        'color', colora);
end

