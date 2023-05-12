# Sampling function of dimensionality reduction method
function [output,input,gg] = UDR_sampling(u,s) 
u_loc = [-3.0,-1.5,0,1.5,3.0]; %% Sample locations
nv = length(u);                %% Dimension of the problem 
m = length(u_loc);             %% Number of samples along each dimension
input = zeros(nv,m); 
for k = 1:nv 
    input(k,:) = u(k) + u_loc*s(k);  
    xx = u; 
    for kk = 1:m 
        xx(k) = input(k,kk); 
        if isequal(k,1) && isequal(xx,u) 
            output(k,kk) = findresponse(xx); 
            gg = output(k,kk); 
        elseif ~isequal(k,1) && isequal(xx,u); 
            output(k,kk) = gg; 
        else
            output(k,kk) = findresponse(xx);
        end 
    end 
end 
