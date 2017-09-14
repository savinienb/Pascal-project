function A = SSI_dic_bagWords(VOCopts, dictionary, words)

switch VOCopts.dicttype
    case 'hikmeans'
        A = vl_hikmeanspush(dictionary, words);
    case 'ikmeans'
        A = vl_ikmeanspush(words, dictionary);
    otherwise
        error('Incorrect dictionary type, cannot bag words');
end

end

