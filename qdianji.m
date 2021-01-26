 function [dianji,xuhao_dianji]=qdianji(nn,node,rr,npl,cengshu);
%%coordinetes of the electrodes/dianji(16 electrodes).
a1=2*pi/nn;for i=1:nn;a=a1*(i-1);dianji(i,:)=[rr*cos(a),rr*sin(a)];end;clear a1;clear a;
%%xuhao of the electrodes in coarse mesh(16 electrodes).
firstnode=npl(cengshu,1);lastnode=npl(cengshu,2);clear npl;
p=1;
for i=firstnode:lastnode;
   for j=p:nn;
      if abs(node(i,1)-dianji(j,1))<1e-4|abs(node(i,2)-dianji(j,2))<1e-4;
         xuhao_dianji(j,1)=i;p=p+1;break;
      end;
   end;
end;clear p;%clear dianji;
