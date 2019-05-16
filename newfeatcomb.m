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

