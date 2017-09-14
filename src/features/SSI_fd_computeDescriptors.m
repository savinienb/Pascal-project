function [ descriptors ] = SSI_fd_computeDescriptors( VOCopts, dictionary, A, trainMetaData )
%SSI_FD_COMPUTEDESCRIPTORS will compute and return the descriptors in a
%matrix ready to train any PRTools classifier type.
%
% The function is overloaded for 3 and 4 args in:
%   3 args -> Builds descriptor for 1 image (Without pre-clustering assignment in A and trainMetaData)
%   4 args -> Usage of already clustered words from the dictionary creation step

descriptors = [];
% Building descriptor for 1 image (Without pre-clustering assignment in A and trainMetaData)
if nargin == 3
    I = A;

    % Compute words from image
    [words, frames] = SSI_w_extractWords(VOCopts, I, 0);
    frames = frames(1:2,:);
    
    % Bag words according to dictionary
    if strcmp(VOCopts.dicttype, 'gmm')
        A = words;
    else
        A = SSI_dic_bagWords(VOCopts, dictionary, words);
    end
    
    %If windowing, result is one descriptor per each window
    if length(VOCopts.subWindows) == 2
        descriptors = [];
        
        for r_win_num = 1:VOCopts.subWindows(1)
            for c_win_num = 1:VOCopts.subWindows(2)

                r_win = size(I, 1) * (0:(1/r_win_num):1);
                c_win = size(I, 2) * (0:(1/c_win_num):1);

                for r = 1:length(r_win)-1
                    for c = 1:length(c_win)-1
                        x1 = r_win(r);   y1 = c_win(c);
                        x2 = r_win(r+1); y2 = c_win(c+1);

                        win_frames = frames(1,:) > x1 & frames(1,:) < x2 & ...
                                     frames(2,:) > y1 & frames(2,:) < y2;

                        Ai = A(:, win_frames);

                        descriptors = [descriptors; ...
                                       SSI_fd_computeFeatures(VOCopts, dictionary, Ai)];
                    end
                end
            end
        end
    else
        %Get features
        descriptors = SSI_fd_computeFeatures(VOCopts, dictionary, A);
    end
elseif nargin == 4
    % Building HOBW for train dataset (Words already computed and bagged!)

    % Get bagged words for all images and classes
    cumWordCount = 1;
    for i = 1:length(trainMetaData)
        Ai = A(:, cumWordCount:(cumWordCount+trainMetaData(i).numWords - 1));
        cumWordCount = cumWordCount + trainMetaData(i).numWords;

        % Get HOW for all images and classes
        descriptors_i = SSI_fd_computeFeatures(VOCopts, dictionary, Ai);
        descriptors = [descriptors; descriptors_i];
    end
end

end

