function [ features ] = SSI_fd_computeFeatures(VOCopts, dictionary, A )

switch VOCopts.dicttype
    case 'hikmeans'
        hobw = vl_hikmeanshist(dictionary, A)';
        features = hobw./max(hobw);
    case 'ikmeans'
        hobw = vl_ikmeanshist(VOCopts.ikmeans.K, A)';
        features = hobw./max(hobw);
    case 'gmm'
        A = single(A);
        features = vl_fisher(A, dictionary.means, ...
                                dictionary.covs, ...
                                dictionary.priors, 'improved')';
        features = double(features);
    otherwise
        error('Incorrect configuration, cannot compute features');
end


end

