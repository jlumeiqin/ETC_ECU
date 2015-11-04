%     适应度函数源程序（fitness.m）
%function result=fitness(x,D)
% sum=0;
% for i=1:D
% 
%     sum =sum-x(i)*1-0.1*(-3);
%     
% end
% result=sum;

% 

%     适应度函数源程序（fitness.m）
% function result=fitness(x,D)
% sum=0;
% for i=1:D
%     sum=sum+x(i)^2;
% end
% result=sum;

% 适应度函数源程序（fitness.m）f=0.5*x'*H*x+(-G)'*x
function result=fitness(x,D,H,G,c,b,r)
% sum=0;
% for i=1:D
%     sum=sum+x(i)^2;
% end
%result=0.5*x*H*x'+(-G)'*x'+10*sum(c*x-b);

aa=c*x'-b;
sum=0;
n=length(aa);
for k=1:n
    sum=sum+(min(0,aa(k)))^2;
    %sum=sum+1/aa(k);
end

result=0.5*x*H*x'+(-G)'*x'+5000*sum;
