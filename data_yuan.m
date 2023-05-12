# Construct the header model of the multidimensional parameters of the EIT
%this function is using to calculate the solution space data.
%input:radiu of the space(r),number of layers of the space(cengshu).
%output:coordinates of the nodes(r), nodes' number of per layer(np),
%(kp).
function [r,np,npl,e_r,ep,epl]=data_yuan(rr,cengshu);
% clear all;tic;
%  rr=1;cengshu=4;
%%calculating the coordinates of the nodes.
r(1,1:2)=[0,0];ii=2;d1=rr/cengshu;
for i=1:cengshu
   r1=d1*i;%c1=2*pi*r1;
   %np(i)=round(c1/d1)
   np(i)=4*i;
   theta1=2*pi/np(i);
   for j=1:np(i)
      theta=theta1*(j-1);
      y=r1*sin(theta);x=r1*cos(theta);
      r(ii,:)=[x,y];ii=ii+1;
   end
end
j1=1;
for i=1:cengshu
   npl(i,1:2)=[j1+1,j1+np(i)];j1=j1+np(i);
end
clear d1;clear r1;clear theta1;clear theta;%clear c1;
ss=size(r,1);
%%finding the relationships of nodes.
%the relationship of nodes between the next layer.
for ii=1:cengshu-1
   n1=npl(ii,1);n2=npl(ii,2);n3=npl(ii+1,1);n4=npl(ii+1,2);
   for i=n1:n2
      for j=n3:n4
         dd(j-n3+1)=sqrt((r(i,1)-r(j,1))^2+(r(i,2)-r(j,2))^2);
      end
      [dd1,t1]=min(dd);d2(i,1)=dd1;k2(i,1)=t1+n3-1;
      dd(t1)=rr+0.1;%put a much larger value to t1(minimum value)
      [dd2,t2]=min(dd);d2(i,2)=dd2;k2(i,2)=t2+n3-1;
      dd(t2)=rr+0.1;%put a much larger value to t1(minimum value)
      [dd3,t3]=min(dd);
      if abs(dd3-dd2)<0.001;
         d2(i,3)=dd3;k2(i,3)=t3+n3-1;
      end
      clear dd;
   end
end
clear n1;clear n2;clear n3;clear n4;
clear dd1;clear dd2;clear t1;clear t2;clear t3;clear dd3;
%%set the order of k2.
nk2=size(k2,2);
for i=1:np(1);e_r(i,:)=[1,i+1,i+2];end;e_r(np(1),3)=2;
for ii=1:cengshu-1
   n1=npl(ii,1);n2=npl(ii,2);n3=npl(ii+1,1);n4=npl(ii+1,2);
   p=1;
   for j=n1:n2
      for j1=2:nk2
         if k2(j,j1)==0;break
         else;
             b(p,:)=[j,k2(j,1),k2(j,j1)];p=p+1;
         end
      end
   end
   nnb=size(b,1);
   for i=1:nnb;d(i)=max(b(i,:))-min(b(i,:));end
   for i=1:nnb
      p=i;
      for j=i+1:nnb
         if d(j)<d(p);p=j;end
      end
      ll=d(i);d(i)=d(p);d(p)=ll;
      l=b(i,:);b(i,:)=b(p,:);b(p,:)=l;
   end
   for i=1:nnb-1
      for j=i+1:nnb
          
         if (b(i,1:2)==b(j,1:2))&(b(i,3)>b(j,3))
             m=b(i,3);b(i,3)=b(j,2);b(j,2)=m;
         end
      end
   end
   for i=1:nnb
      if b(i,2)>b(i,3)
         m=b(i,2);b(i,2)=b(i,3);b(i,3)=m;
      end
   end
   la=b(nnb,2);b(nnb,2)=b(nnb,3);b(nnb,3)=la;
   nn=nnb+np(ii);
   %Insert c to b.
   b(nnb+1:nn,1:3)=0;
   for i=1:nn-2
      if b(i,1)~=b(i+1,1)&b(i,3)~=b(i+1,1)
         p=i+1;
         for k1=nnb:-1:p
            b(k1+1,:)=b(k1,:);
         end
         b(p,:)=[b(i,1),b(i,3),b(i+1,1)];
         nnb=nnb+1;
      end
   end
   e_r=[e_r;b];
   clear b;
end
%%
ep(1)=4;epl(1,1)=1;epl(1,2)=4;
for i=2:cengshu;ep(i)=np(i-1)+np(i);end;
for i=2:cengshu;epl(i,1)=epl(i-1,2)+1;epl(i,2)=epl(i-1,2)+ep(i);end;
e_n=e_r;node=r;mm=size(e_n,1);

%»­Ô²
% for i=1:mm;p1=e_n(i,1);p2=e_n(i,2);p3=e_n(i,3);x1=node(p1,:);y1=node(p2,:);z1=node(p3,:);
%   dd=[x1;y1;z1;x1];x=dd(1:4,1);y=dd(1:4,2);
%  plot(x,y,'-');axis equal;hold on;
% end;clear x;clear y;clear dd;
