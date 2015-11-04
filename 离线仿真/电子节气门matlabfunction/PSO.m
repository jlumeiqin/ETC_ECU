%------基本粒子群优化算法（Particle Swarm Optimization）-----------
%------名称：基本粒子群优化算法（PSO）
%------作用：求解优化问题
%------时间：2006年8月17日 <CopyRight@dReAmsUn>
function UU=PSO(H,G,c,b)
% clear all;
% clc;
%format long;
%------给定初始化条件----------------------------------------------
c1=1.4962;             %学习因子1
c2=1.4962;             %学习因子2
% c1=2;             %学习因子1
% c2=2;             %学习因子2
w=0.7298;              %惯性权重
MaxDT=20;            %最大迭代次数
D=2;                  %搜索空间维数（未知数个数）
N=20;                  %初始化群体个体数目
eps=10^(-6);           %设置精度(在已知最小值时候用)
%------初始化种群的个体(可以在这里限定位置和速度的范围)------------
r=0.1;
% fid=fopen('randac_vc.txt','r');
for i=1:N
    for j=1:D
        %x(i,j)=0.0001*num(a);  %随机初始化位置
        x(i,j)=0.001*my_random;  %随机初始化位置
        v(i,j)=0*my_random;  %随机初始化速度
    end
end


%------先计算各个粒子的适应度，并初始化Pi和Pg----------------------
for i=1:N
    p(i)=fitness(x(i,:),D,H,G,c,b,r);
    y(i,:)=x(i,:);
end

pg=x(1,:);             %Pg为全局最优
for i=2:N
    if fitness(x(i,:),D,H,G,c,b,r)<fitness(pg,D,H,G,c,b,r)
        pg=x(i,:);
    end
end

%------进入主要循环，按照公式依次迭代，直到满足精度要求------------

for t=1:MaxDT
    
    w=0.8-0.6*t/MaxDT;
    for i=1:N
        randac1=my_random;
        randac2=my_random;
        v(i,:)=w*v(i,:)+1*c1*randac1*(y(i,:)-x(i,:))+1*c2*randac2*(pg-x(i,:));
%         if v(i,:)>1
%             v(i,:)=1;
%         end
%         if v(i,:)<-1
%             v(i,:)=-1;
%         end
        x(i,:)=x(i,:)+v(i,:);
        for k=1:D
            if  x(i,k)>1
              x(i,k)=1;
            end
            if x(i,k)<-1
                x(i,k)=-1;
            end
        end
        if fitness(x(i,:),D,H,G,c,b,r)<p(i)
            p(i)=fitness(x(i,:),D,H,G,c,b,r);
            y(i,:)=x(i,:);
        end
        if p(i)<fitness(pg,D,H,G,c,b,r)
            pg=y(i,:);
        end
%         for k=1:D
%         if pg(k)>1
%            pg(k)=1;
%         end
%         if pg(k)<-1
%             pg(k)=-1;
%         end
%         end
    end
   % Pbest(t)=fitness(pg,D,H,G,c,b,r);
%     if t>1&&(Pbest(t)-Pbest(t-1))<0.0001
%         break;
%     end

end
%------最后给出计算结果
% disp('*************************************************************')
% disp('函数的全局最优位置为：')
% Solution=pg'
% disp('最后得到的优化极值为：')
% Result=fitness(pg,D)
% disp('*************************************************************')
UU=pg';
%------算法结束---DreamSun GL & HF----------------------------------- 

  