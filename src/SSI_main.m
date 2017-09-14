SSI_init;

% train and test classifier for each class
legend_text = {};
for i=1:VOCopts.nclasses
    cls=VOCopts.classes{i};
    disp(' '); disp('------------------------------');
    disp(['Testing ' cls]); disp('------------------------------');
    
    disp('1. Computing vocabulary...');
    [ vocabulary, imgMetaData ] = SSI_w_computeVocabulary(VOCopts, cls);
    
    disp('2. Making dictionary...');
    [ dictionary, A ] = SSI_dic_makeDictionary( VOCopts, cls, vocabulary );
    
    disp('3. Computing training descriptors...');
    [ descriptors ] = SSI_fd_computeDescriptors( VOCopts, dictionary, A, imgMetaData);
    
    disp('4. Training classifier');
    classifier = SSI_cl_train(VOCopts, cls, descriptors);
    
    disp('5. Testing classifier');
    SSI_cl_test(VOCopts, cls, classifier, dictionary);
    
    %Read results and output
    figure(1); hold on; grid on;
    [fp,tp,auc]=VOCroc(VOCopts,'comp1',cls, true);  %compute and display ROC
    
    legend_text{i} = [VOCopts.classes{i} ' auc = ' num2str(auc, '%.3f')];
    legend(legend_text, 'Location', 'southeast');
    
    if i<VOCopts.nclasses
        fprintf('Press any key to continue with next class...\n'); pause;
    end
end

