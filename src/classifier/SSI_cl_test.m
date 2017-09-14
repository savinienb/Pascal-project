function [  ] = SSI_cl_test( VOCopts, cls, classifier, dictionary)
%SSI_CL_TEST Summary of this function goes here
%   Detailed explanation goes here

% classify each image
tic;
% load test set ('val' for development kit)
[ids,gt]=textread(sprintf(VOCopts.clsimgsetpath,cls,VOCopts.testset),'%s %d');

c = zeros(size(ids));
try
    % try to load features
    load(sprintf(VOCopts.wordstestpath, cls),'c');
    disp(['   Loaded: ', sprintf(VOCopts.wordstestpath, cls)]);
catch
    for i = 1:length(ids)
        % display progress
        if toc>2
            fprintf('%s: test: %d/%d\n',cls,i,length(ids));
            drawnow; tic;
        end
        
        % compute and save features
        I = imread(sprintf(VOCopts.imgpath,ids{i}));
        
        %Get subwindows test descriptors
        testDescriptors = SSI_fd_computeDescriptors(VOCopts, dictionary, I);

        % compute confidence of positive classification
        c_i = classify(VOCopts, classifier, testDescriptors);   
        
        %Take maximum confidence
        c(i) = max(c_i);
    end
    
    save(sprintf(VOCopts.wordstestpath, cls),'c');
end

% create results file
fid=fopen(sprintf(VOCopts.clsrespath,'comp1',cls),'w');

% write to results file
for i = 1 : length(c)
    fprintf(fid,'%s %f\n', ids{i}, c(i));
end

% close results file
fclose(fid);

end

