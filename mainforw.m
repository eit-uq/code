clc;
clear all;
cleose all;
tic;
rr=1;cengshu=16;
% %% -------------basic information of the circle model---------------------------------
% %%%input data of the coarse mesh.%%coordinetes and index/xuhao of the electrodes/dianji(16 electrodes).
[node,np,npl,element,ep,epl]=data_yuan(rr,cengshu);

total_node=size(node,1);total_element=size(element,1);
nn=16;
[dianji,xuhao_dianji]=qdianji(nn,node,rr,npl,cengshu);
% save data_yuan node np npl element ep epl dianji xuhao_dianji;
x_in=1;y_in=0;
x_out=-1;y_out=0;
C(total_node,1)=0;
for i=1:total_node
    if abs(node(i,1)-x_in)<eps & abs(node(i,2)-y_in)<eps
        index_inject=i;
    end
    if abs(node(i,1)-x_out)<eps & abs(node(i,2)-y_out)<eps
        index_out=i;
    end
end    
% C(index_inject,1)=0.5;C(index_inject+1,1)=0.5;
% C(index_out,1)=-0.5;C(index_out+1,1)=-0.5;
C(index_inject,1)=1;
C(index_out,1)=-1;

refe=22;

C1=C;C1(refe,1)=0;

rou(1:total_element)=1;
%----calculate potential distribution using fem----
%%%calculating the voltage distribution of the whole field.
ss=total_node;
Y=sparse(total_node,total_node,0);
Y=qxishuzhen(node,element,rou);
Y1=Y;Y1(refe,1:ss)=0;Y1(1:ss,refe)=0;Y1(refe,refe)=1;
Vs=inv(Y1)*C1;
v=full(Vs);
clear Vs;
save v_16c v;

figure;  plot(v)
% %%show the voltage distribution of all nodes
%% firstly, define a chromatogram matrix: red_blue
for i=1:32;red_blue(i,3)=1;red_blue(i,1:2)=(i-1)/32;end;
for i=33:65;red_blue(i,1)=1;red_blue(i,2:3)=1-(i-33)/32;end;
%% then,
mm=size(element,1);
figure;
for i=1:mm
    p1=element(i,1);p2=element(i,2);p3=element(i,3);
    x1=node(p1,1);x2=node(p2,1);x3=node(p3,1);
    y1=node(p1,2);y2=node(p2,2);y3=node(p3,2);
    xx=[x1,x2,x3];yy=[y1,y2,y3];
    zz=(v(p1,1)+v(p2,1)+v(p3,1))/3;
    fill(xx,yy,zz);
    hold on;
end
axis equal;
colormap(red_blue);
% colormap(gray);
colorbar;
