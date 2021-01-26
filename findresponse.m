function response = findresponse(xx) 
load map_dict(1)
R='[';
for i=1:64
    s=strcat('r',num2str(i));
    syms(s)
    R=strcat(R,s);
    if i~=64
       R=strcat(R,',');
    else
       R=strcat(R,']');
    end
end
R=eval(R);
v=0;
for i=1:5
    vj=1;
    for j=0:i-1
        w=strcat('w',num2str(i))
        b=strcat('b',num2str(i))
        W=eval(strcat(w,num2str(j)))
        B=eval(strcat(b,num2str(j)))
        vj=vj*(sum(W.*R)+B)
    end
    v=v+vj
end
v=vpa(v,4);
syms f
f=symfun(v,R)
%input=rand(5,64);
cmd='f(';
for i=1:64
    cmd=strcat(cmd,strcat('xx(:,',num2str(i)));
    cmd=strcat(cmd,')');
    if i~=64
        cmd=strcat(cmd,',');
    else
        cmd=strcat(cmd,')');
    end
end
response=double(eval(cmd));
end



