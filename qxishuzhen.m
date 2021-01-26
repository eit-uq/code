function S=qxishuzhen(node,element,rou)
ss=size(node,1);
S=sparse(ss,ss,0);
mm=size(element,1);%mm is the number of the elements.
for i=1:mm
   con=1/rou(i);
   S1=sparse(ss,ss,0);
   %%p1,p2,p3 are the node index of the i'th element,
   %%they are K,M,N,respectively.
   p1=element(i,1);p2=element(i,2);p3=element(i,3);
   %%rk,rm,rn are coordinates of K,M,N,respectively.
   rk=node(p1,1:2);rm=node(p2,1:2);rn=node(p3,1:2);
   
   %%%shape function
   x1=rk(1,1);y1=rk(1,2);
   x2=rm(1,1);y2=rm(1,2);
   x3=rn(1,1);y3=rn(1,2);
   a1=x2*y3-x3*y2;a2=x3*y1-x1*y3;a3=x1*y2-x2*y1;
   b1=y2-y3;b2=y3-y1;b3=y1-y2;
   c1=x3-x2;c2=x1-x3;c3=x2-x1;
   mianji=((y2-y3)*(x1-x3)-(y3-y1)*(x3-x2))/2;
   mianji1=4*mianji;
   %%%
   S1(p1,p1)=(b1^2+c1^2)/mianji1;
   S1(p2,p2)=(b2^2+c2^2)/mianji1;
   S1(p3,p3)=(b3^2+c3^2)/mianji1;
   S1(p1,p2)=(b1*b2+c1*c2)/mianji1;
   S1(p1,p3)=(b1*b3+c1*c3)/mianji1;
   S1(p2,p3)=(b2*b3+c2*c3)/mianji1;
   S1(p2,p1)=S1(p1,p2);S1(p3,p1)=S1(p1,p3);S1(p3,p2)=S1(p2,p3);
   %%%multiply the corresponding conductivity of each element
   S1=con*S1;
   %%%
   S=S+S1;
end
