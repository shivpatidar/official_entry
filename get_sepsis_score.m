function [scores, labels] = get_sepsis_score(traindata1,model)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

 mutr=[84.2061445399554,97.1042922183183,36.9129570072805,126.811629098678,86.6534116689875,66.4697154647796,18.7393593625768,32.8939855007608,-3.39182389937107,22.5073122529644,0.507699573430845,7.36929862174577,40.3848378212974,96.5268346111719,192.381690660760,22.9643115069812,98.0299963194700,7.00924655526239,106.563318777293,1.64130063709581,1.21254794520548,140.138223595405,2.99093158660844,2.05984158138231,3.45182126696832,4.09622917938432,1.87343004039662,8.24477941176466,31.0792886645250,10.1991020408163,44.7429051782112,10.7799949174078,274.113663133098,193.224399098648,60.5672793434089,0.540313155727908,0.489870397230150,0.510129602769850,-67.3244416850259,25.7519456028049];
stddtr=[17.6789062490770,2.96272557664854,0.763160660066376,24.4745017437595,16.8000297088328,14.2592815533567,4.74293432401596,7.61265597243678,4.74361059298186,3.66837296463524,0.226649214507526,0.0928419980089872,10.3948069434161,4.11533404577114,716.671964243265,19.3989083187257,103.653549317874,3.02247341630676,4.79643851376234,2.03481613823240,3.24689967524853,52.4442500262057,2.80884036685201,0.382242020925569,1.35608706548277,0.654318781103494,3.88085577851467,25.1074901186160,6.62068988463042,2.24349107764270,38.1868758208808,9.85939220953114,135.701209053458,99.0084945095756,16.3034521512521,0.498373854416560,0.499899719553310,0.499899719553310,256.753614948731,27.5196306042446];
 trainlabels=[];traindata=[];
for i=1:1
    
%[traindata1] = GetSepsisData(input_file);


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


function [feat] = GetSepsisData(input_file)


[values, column_names] = ReadChallengeData(input_file);


function [values, column_names] = ReadChallengeData(filename)
  f = fopen(filename, 'rt');
  try
    l = fgetl(f);
    column_names = strsplit(l, '|');
    values = dlmread(filename, '|', 1, 0);
  catch ex
    fclose(f);
    rethrow(ex);
  end
  fclose(f);
end
feat=values(:,1:40);
%labels=values(:,41);

  %% ignore SepsisLabel column if present
  %if strcmp(column_names(end), 'SepsisLabel')
  %  column_names = column_names(1:end-1);
  %  values = values(:,1:end-1);
  %end
end

function [feat] = newfeatcomb(data)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here

% C = combnk(data(i,:),3)';
%   
% % feat11=C(1,:)./(C(2,:).*C(3,:));
% % feat22=C(1,:)./(C(2,:).*C(3,:).^2);
%  feat1=C(1,:)./(C(2,:).*C(3,:).^3);
% % feat1=C(1,:)./(C(2,:).^2.*C(3,:).^2);
%  %feat1=C(1,:)./(C(2,:).^2.*C(3,:).^3);
% %feat1=C(1,:)./(C(2,:).^3.*C(3,:).^3);
% feat=[feat; feat1];
% Type1:
feat11=normalize(data(:,1)./(data(:,4).^3.*data(:,22).^3));%correct
feat12=normalize(data(:,6)./(data(:,17).^3.*data(:,36).^3));
feat13=normalize(data(:,9)./(data(:,17).^3.*data(:,33).^3));
feat14=normalize(data(:,11)./(data(:,15).^3.*data(:,25).^3));
feat15=normalize(data(:,13)./(data(:,19).^3.*data(:,27).^3));
% Type2:
feat21=normalize(data(:,2)./(data(:,13).^2.*data(:,24).^3));%correct
feat22=normalize(data(:,14)./(data(:,16).^2.*data(:,27).^3));%correct
feat23=normalize(data(:,15)./(data(:,16).^2.*data(:,32).^3));
% Type3:
feat31=normalize(data(:,1)./(data(:,27).^2.*data(:,33).^2));%correct
feat32=normalize(data(:,8)./(data(:,13).^2.*data(:,20).^2));

feat=[feat11 feat12 feat13 feat14 feat15 feat21 feat22 feat23 feat31 feat32];
%feat=[feat11 feat12];
end

function [data] = snpfeatures(dataraw)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%dataraw=dataraw1(:,1:36);% containing first 36 features from original data
%set number1:length/area features
x1=dataraw(:,3)./dataraw(:,11).^2;
x2=dataraw(:,6)./dataraw(:,7).^2;
x3=dataraw(:,8)./dataraw(:,11).^2;
x4=dataraw(:,8)./dataraw(:,21).^2;
x5=dataraw(:,13)./dataraw(:,7).^2;
x6=dataraw(:,19)./dataraw(:,11).^2;
x7=dataraw(:,29)./dataraw(:,23).^2;
x8=dataraw(:,35)./dataraw(:,11).^2;
x9=dataraw(:,35)./dataraw(:,21).^2;
x10=dataraw(:,35)./dataraw(:,24).^2;
y1=[x1 x2 x3 x4 x5 x6 x7 x8 x9 x10];

%set number2:area/volume features
x11=(dataraw(:,8).^2)./dataraw(:,27).^3;
% x12=(dataraw(:,35).^2)./dataraw(:,9).^3;
 y2=[x11 ];

%set number3:length/vol features
x31=(dataraw(:,8))./dataraw(:,11).^3;
x32=(dataraw(:,35))./dataraw(:,11).^3;
x33=dataraw(:,36)./dataraw(:,11).^3;
x34=dataraw(:,31)./dataraw(:,23).^3;
  y3=[x31 x32 x33 x34];
%set number4:length/vol features
%x41=(dataraw(:,9))./norm(dataraw(:,26).^2-dataraw(:,9).^2) ;
x42=(dataraw(:,12))./norm(dataraw(:,27).^2-dataraw(:,12).^2) ;
mm=dataraw(:,35)./dataraw(:,24).^2;%the 10th feature of data type1
x43=(mm)./norm(dataraw(:,27).^2-mm.^2) ;
y4=1./[x42 x43];
%set number5:mode of all 36 basic features


data=[y1 y2 y3 y4 ];
%clear x41 x42 x43 x31 x32 x33 x34 x11 x12 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 y1 y2 y3 y4  mm
end






