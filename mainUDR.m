% The main program of the dimensional reduction method
clc;
clear all;
close all;
tic;
 u = ones(1,64);                    %% Mean vector of random variables
 s = ones(1,64)*sqrt(3)/6;                 %% Standard deviation vector
% d=10;
%  u=ones(1,64);
%  s=ones(1,64)*0.5;
ns = 10;                      %% Number of MCS samples MCS样本数 
nv = length(u);                   %% Number of input random variables输入随机变量的数量 
xs = zeros(nv,ns);                %% Initialization of MCS sample vector MCS样本向量的初始化
for k = 1:nv 
    xs(k,:) = normrnd(u(k),s(k),1,ns);
end 
[output,input,gg] = UDR_sampling(u,s); 
uniComp = zeros(nv,ns); 
for k = 1:nv 
    uniComp(k,:) = interp1(input(k,:),output(k,:),xs(k,:),'spline'); 
end 
zz = squeeze(uniComp(:,:)); 
response_URS = sum(zz,1)-(nv-1)*gg;
save UDR_3 response_URS
 toc;

