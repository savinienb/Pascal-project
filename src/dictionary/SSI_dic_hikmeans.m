function [ dictionary, A ] = SSI_dic_hikmeans( VOCopts, cls, vocabulary )

% Cluster vocabulary into BOWs
try
    % try to load dictionary and words
    load(sprintf(VOCopts.dictpath, cls), 'dictionary', 'A');
catch
    opts = VOCopts.hikmeans;
    [dictionary, A] = vl_hikmeans(vocabulary, opts.K, opts.nleaves);
    
    save(sprintf(VOCopts.dictpath, cls), 'dictionary', 'A');
end

disp('Dictionary built.');

end

