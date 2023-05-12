#It is the main program of Monte Carlo method and a classical algorithm in the field of uncertainty quantification, 
#and its results are used as experimental benchmarks.
#A sample set of alternative models was generated, where conductivity was used as input and voltage as output
clc;
clear all;
close all;
tic;
n=100000;
% % %% -------------basic information of the circle model---------------------------------
% % %%%input data of the coarse mesh.%%coordinetes and index/xuhao of the electrodes/dianji(16 electrodes).

total_element=1024;%64/256/576/1024
 % r=unifrnd(0.8,1.2,n,total_element);%uniform distribution
   r=normrnd(1,sqrt(3)/15,n,total_element);%normal distribution
for i=1:n

rou=r(i,:);
vv(:,i)=dianyajisuan(rou);
end
%vv26=vv(26,:)';
% for i=1:10
% r=normrnd(0,1,10,total_element);%±ê×¼ÕýÌ¬·Ö²¼Ëæ»úÊý
% rou=r(i,:);
% vv(:,i)=dianyajisuan(rou);
% end

%  save E:\PythonNihehuigui\16ceng\junyunfenbu\r16ceng_cs r
%  save E:\PythonNihehuigui\16ceng\junyunfenbu\vv16ceng_cs vv
 save E:\PythonNihehuigui\16ceng\zhengtaifenbu\r16ceng_cs r
 save E:\PythonNihehuigui\16ceng\zhengtaifenbu\vv16ceng_cs vv
toc
