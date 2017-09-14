function [words, frames] = SSI_w_extractWords( VOCopts, I, annot )

switch VOCopts.wtype
    case {'DSIFT', 'dsift'}
        %Compute for DSIFT
        [words, frames] = SSI_w_DSIFT(VOCopts, I, annot);
    case {'PHOW', 'phow'}
        [words, frames] = SSI_w_PHOW(VOCopts, I, annot);
    otherwise
        error('Incorrect word type, cannot extract words');
end

end

