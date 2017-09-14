% trivial classifier: compute ratio of L2 distance betweeen
% nearest positive (class) feature vector and nearest negative (non-class)
% feature vector
function c = classify(VOCopts, classifier, testDescriptors)

testDescriptors = prdataset(testDescriptors);

% Classify
c = testDescriptors*classifier;

% Get class probabilities
c = getdata(c);

% Select positive classification probability
c = c(:, 2);
