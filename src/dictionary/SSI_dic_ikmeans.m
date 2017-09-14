function [ dictionary, A ] = SSI_dic_ikmeans( VOCopts, cls, vocabulary )

% Cluster vocabulary into BOWs
try
    % try to load dictionary and words
    load(sprintf(VOCopts.dictpath, cls), 'dictionary', 'A');
catch
    opts = VOCopts.ikmeans;
    [dictionary, A] = vl_ikmeans(vocabulary, opts.K);

    save(sprintf(VOCopts.dictpath, cls), 'dictionary', 'A');
end

disp('Dictionary built.');

end
