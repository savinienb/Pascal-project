function [ dictionary] = SSI_dic_gmm( VOCopts,  cls, vocabulary)
%SSI_DIC_GMM 
opts = VOCopts.gmm;

% Create dictionary
try
    % try to load dictionary
    load(sprintf(VOCopts.dictpath, cls), 'dictionary');
    disp(['   Loaded:' sprintf(VOCopts.dictpath, cls)]);
catch
    vocabulary = single(vocabulary);
    [means, covariances, priors] = vl_gmm(vocabulary, opts.numClusters);
    
    dictionary = struct('means', means, 'covs', covariances, 'priors', priors);
    
    
    save(sprintf(VOCopts.dictpath, cls), 'dictionary');
    disp('   Dictionary built.');
end
end