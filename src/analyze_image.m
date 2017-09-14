SSI_init; clc

% train and test classifier for each class
legend_text = {};

load('final_kit', 'final_kit');
for i=1:VOCopts.nclasses
    cls=VOCopts.classes{i};
    
    c = SSI_cl_test_img(VOCopts, 'hotdog.jpg', final_kit(i).clas, final_kit(i).dict);
    disp(['Probability of ' cls ' is ' num2str(c, '%.3f')]);
end

