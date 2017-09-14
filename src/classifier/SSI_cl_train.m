function [ classifier ] = SSI_cl_train( VOCopts, cls, trainDescriptors)

[~,gt]=textread(sprintf(VOCopts.clsimgsetpath,cls,'train'),'%s %d');


Atrain = prdataset(trainDescriptors, gt);
%Atrain = setprior(Atrain,[0.5 0.5]);

switch VOCopts.cltype
    case 'svm'
        classifier = classc(svc(Atrain));
        
    case 'svm2'    
        classifier = classc(svc(Atrain, proxm('p',2)));
    
    case 'svm3'    
        classifier = classc(svc(Atrain, proxm('p',3)));
        
    case 'nbayesc'
        [U,G] = meancov(Atrain);
        classifier = classc(nbayesc(U, G));
        
    case 'rdf'
        prtime(60);
        classifier = classc(randomforestc(Atrain, 400, 4));
        
        
    otherwise
        classifier = classc(knnc(Atrain, 1));
end


end

