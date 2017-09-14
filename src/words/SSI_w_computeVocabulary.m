function [vocabulary, trainMetaData ] = SSI_w_computeVocabulary(VOCopts, cls)

[ids,gt]=textread(sprintf(VOCopts.clsimgsetpath,cls,'train'),'%s %d');

%TODO initialize vocabulary to some arbitrary number to speed up
%And dinamically increase size in chunks if too small (at the end slice)
vocabulary = [];

trainMetaData = struct('filename', '', 'gt', 0, 'numWords', 0, 'cls', cls);
trainMetaData(length(ids)).filename = '';

% extract features for each image
tic;
try
    % try to load words
    load(sprintf(VOCopts.wordstrainpath, cls),'vocabulary', 'trainMetaData');
    disp(['   Loaded: ' sprintf(VOCopts.wordstrainpath, cls)]);
catch
    for j=1:length(ids)
        % display progress
        if toc > 2
            fprintf('%s: train: %d/%d\n',cls,j,length(ids));
            drawnow; tic;
        end
        
        % compute and save words
        I = imread(sprintf(VOCopts.imgpath,ids{j}));
        
        %Read annotations
        annot = PASreadrecord(sprintf(VOCopts.annopath,ids{j}));
        words = SSI_w_extractWords( VOCopts, I, annot);
        
        trainMetaData(j).filename = ids{j};
        trainMetaData(j).gt = gt(j);
        trainMetaData(j).numWords = size(words,2);
        trainMetaData(j).cls = cls;
        vocabulary = [vocabulary, words];
    end
    
    save(sprintf(VOCopts.wordstrainpath, cls),'vocabulary', 'trainMetaData');
    disp('   Full vocabulary built');
end


end

