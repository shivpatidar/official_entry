function [scores, labels] = shiventry(input_file,model,mutr,stddtr)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
trainlabels=[];traindata=[];
%  
 for i=1:1
    
[traindata1] = GetSepsisData(input_file);


traindata2=(traindata1-mutr)./stddtr;
for clm=1:40
% %     
traindata2(isnan(traindata2(:,clm)),clm)=0;
end
%for extened data--proposed features
traindata3=traindata1;
for clm=1:40
% %     
traindata3(isnan(traindata3(:,clm)),clm)=mutr(clm);
end

 traindata4=snpfeatures(traindata3(:,1:36));
 
% %process this with its mean1 and std1

traindata5=normalize(traindata4);
for clm=1:17
% %     
traindata5(isnan(traindata5(:,clm)),clm)=0;
end
 traindata6=[traindata2 traindata5];

traindata7=newfeatcomb(traindata3(:,1:36));
idxvar=[1,2,3,4,5,6,7,8,13,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57];
 
traindata=[traindata;traindata6(:,idxvar) traindata7];

 end
  
 [labels,scores1]=predict(model,traindata);
scores=scores1(:,2)./(sum(scores1(:,2)));
 
end

