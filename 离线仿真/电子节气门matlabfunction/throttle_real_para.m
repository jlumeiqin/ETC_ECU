clc
clear
%节气门参数
% Kt = 0.0486;
% Kv = Kt;
% Ks = 0.005 * 1.57 /90 * 100;   %转换成弧度
% J = 5e-6;
% n = 6.25;
% B = 2.4e-4;
% R = 3;

% Vbat = 12;
% n = 22.08;
% thta0 = 0.116;
% c=63.662;
% Ksa=3.89*10^(-4);
% Ksb=0.0033;
% Kpre=0.1393;
% Kf=0.0048;
% Kt=0.016;
% Kv=0.016;
% J=4*10^(-6);
% B=0;
% Ra1=0.0347;
% Ra2=0.3903;
% Ra3=0.7579;

global seed
seed=9;
Vbat = 12;
n = 22.08;
thta0 = 0.108;
%c=63.662;
c=1;
Kt=0.0183;
Kv=0.0183;
Ksa=0.0011*Kt*n*c;
Ksb=0.0093*Kt*n*c;
Kpre=0.3942*Kt*n;
Kf=0.2999*Kt;
J=4*10^(-6);
B=2.4e-5;
Ra0=0;
Ra1=0.0347;
Ra2=0.3903;
%Ra3=0.7579;
Ra3=1.2025;

% a1 = Ks / n^2 /J;
% a2 = Kt*Kv/R/J + B/J;
% b2 = Kt/n/R/J;
% b1 = 0;
a1 = Ksa/n^2/J;
a2_0=(B/J+Kt*Kv/J*Ra0);
b1=0;
b2_0=Kt*Vbat/n/J*Ra0;

a1 = Ksa/n^2/J;
a2_1=(B/J+Kt*Kv/J*Ra1);
b1=0;
b2_1=Kt*Vbat/n/J*Ra1;

a1 = Ksa/n^2/J;
a2_2=(B/J+Kt*Kv/J*Ra2);
b1=0;
b2_2=Kt*Vbat/n/J*Ra2;

a1 = Ksa/n^2/J;
a2_3=(B/J+Kt*Kv/J*Ra3);
b1=0;
b2_3=Kt*Vbat/n/J*Ra3;

%离散化
AA_0 = [0 1;-a1 -a2_0];
C_0 = [c 0];
D_0 = [0];
BB_0 = [b1 ;b2_0];
[ad_0,bd_0,cd_0,dd_0]=c2dm(AA_0,BB_0,C_0,D_0 ,0.001 ,'zoh');

AA_1 = [0 1;-a1 -a2_1];
C_1 = [c 0];
D_1 = [0];
BB_1 = [b1 ;b2_1];
[ad_1,bd_1,cd_1,dd_1]=c2dm(AA_1,BB_1,C_1,D_1 ,0.001,'zoh');

AA_2 = [0 1;-a1 -a2_2];
C_2 = [c 0];
D_2 = [0];
BB_2 = [b1 ;b2_2];
[ad_2,bd_2,cd_2,dd_2]=c2dm(AA_2,BB_2,C_2,D_2 ,0.001 ,'zoh');

% AA_3 = [0 1;-a1 -a2_3];
% C_3 = [c 0];
% D_3 = [0];
% BB_3 = [b1 ;b2_3];
% [ad_3,bd_3,cd_3,dd_3]=c2dm(AA_2,BB_3,C_3,D_3 ,0.0005 ,'zoh');
AA_3 = [0 1;-a1 -a2_3];
C_3 = [c 0];
D_3 = [0];
BB_3 = [b1 ;b2_3];
[ad_3,bd_3,cd_3,dd_3]=c2dm(AA_2,BB_3,C_3,D_3 ,0.001 ,'zoh');

A_0=ad_0;
B_0=bd_0;
Cm_0=C_0;
Cc_0=Cm_0;

A_1=ad_1;
B_1=bd_1;
Cm_1=C_1;
Cc_1=Cm_1;

A_2=ad_2;
B_2=bd_2;
Cm_2=C_2;
Cc_2=Cm_2;

A_3=ad_3;
B_3=bd_3;
Cm_3=C_3;
Cc_3=Cm_3;

%输入输出个数
NU=1;
NY=1;
%预测时域，控制时域
P=20;
M=2;

%定义干扰项偏差量的系数,为简单起见令其为零


%求Sx
Sx_0=[];
Sx_1=[];
Sx_2=[];
Sx_3=[];

Sxs_0=Cc_0*A_0;
Sxs_1=Cc_1*A_1;
Sxs_2=Cc_2*A_2;
Sxs_3=Cc_3*A_3;

Sx_0=Sxs_0;
Sx_1=Sxs_1;
Sx_2=Sxs_2;
Sx_3=Sxs_3;

for i=2:P
	Sxs_0=Sxs_0+Cc_0*A_0^i;
	Sx_0=[Sx_0
	    Sxs_0];
end
for i=2:P
	Sxs_1=Sxs_1+Cc_1*A_1^i;
	Sx_1=[Sx_1
	    Sxs_1];
end
for i=2:P
	Sxs_2=Sxs_2+Cc_2*A_2^i;
	Sx_2=[Sx_2
	    Sxs_2];
end
for i=2:P
	Sxs_3=Sxs_3+Cc_3*A_3^i;
	Sx_3=[Sx_3
	    Sxs_3];
end


%求Su
Su_0(1,1) = Cc_0*B_0;
for i = 1:M
    Su_0(i,i) = Cc_0*B_0;
    for j = i+1:P        
        Su_0(j,i) = Cc_0*A_0^(j-1)*B_0 + Su_0(j-1,i);
    end
end
Su_1(1,1) = Cc_1*B_1;
for i = 1:M
    Su_1(i,i) = Cc_1*B_1;
    for j = i+1:P        
        Su_1(j,i) = Cc_1*A_1^(j-1)*B_1 + Su_1(j-1,i);
    end
end
Su_2(1,1) = Cc_2*B_2;
for i = 1:M
    Su_2(i,i) = Cc_2*B_2;
    for j = i+1:P        
        Su_2(j,i) = Cc_2*A_2^(j-1)*B_2 + Su_2(j-1,i);
    end
end
Su_3(1,1) = Cc_3*B_3;
for i = 1:M
    Su_3(i,i) = Cc_3*B_3;
    for j = i+1:P        
        Su_3(j,i) = Cc_3*A_3^(j-1)*B_3 + Su_3(j-1,i);
    end
end
%  Sx
%  Su
  
%控制量加权
Tu=3*eye(NU*M);

%输出加权
Ty=10*eye(NY*P);

%求tao
T=[];
T=eye(1);

for i=2:P
	T=[T
	   eye(1)];
end

%不是方阵的矩阵求逆用pinv

%选择控制序列的第一个作用于系统
I=[eye(NU),zeros(NU,(NU*M-NU))];

% Kmpc=I*inv(Su'*Ty'*Ty*Su+Tu'*Tu)*Su'*Ty'*Ty;

%求观测器参数
% l1_1 = 20  + ad_1(1,1) + ad_1(2,2);
% l2_1 =(100- ad_1(2,2) * (l1_1 - ad_1(1,1)))/ad_1(1,2) + ad_1(2,1);  %3.288*1.712
% L_1 = [l1_1;l2_1];

H_0 = (Su_0'*Ty'*Ty*Su_0 + Tu'*Tu) * 2;
g_0 = 2 * Su_0'*Ty'*Ty;
H_1 = (Su_1'*Ty'*Ty*Su_1 + Tu'*Tu) * 2;
g_1 = 2 * Su_1'*Ty'*Ty;
R = -0.1;
H_2 = (Su_2'*Ty'*Ty*Su_2 + Tu'*Tu) * 2;
g_2 = 2 * Su_2'*Ty'*Ty;
H_3 = (Su_3'*Ty'*Ty*Su_3 + Tu'*Tu) * 2;
g_3 = 2 * Su_3'*Ty'*Ty;
% h_1 = (ad(2,2) - R) / ad(1,2);
% aw = ad(2,2) - h * ad(1,2);
% bw = b2 - h * b1;
% yw = (ad(2,2) - h * ad(1,2))*h + ad(2,1) - h*ad(1,1);

% p1 = [-3.288,-1.712];
% aa1 = ad';
% bb1 = cd';
% cc1 = bd';
% k = acker(aa1,bb1,p1);
% hh = k';
% ahc = ad - hh * cd;
% save Sx.txt -ascii Sx_3
% save g.txt  -ascii g_3
% save H.txt  -ascii H_3
% dlmwrite(Sx_1.txt,Sx_3,',');
