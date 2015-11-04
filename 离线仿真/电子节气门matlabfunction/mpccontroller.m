function [u] = mpccontroller( DX1,DX2,Y,U_K_1,RefOut)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% global uu0;
% global u_1;
% global X2_1;
% global Sx;
% global g;
% global H;
% global Su;

%du=0;
DX=[DX1;DX2];
%Sx = [0.9994,0.0034;1.9978,0.0079;2.9949,0.0126;3.9908,0.0175;4.9853,0.0223;5.9786,0.0271;6.9705,0.032;7.9612,0.0368;8.9505,0.0416;9.9386,0.0464;10.9254,0.0512;11.9109,0.056;12.8951,0.0608;13.8781,0.0656;14.8597,0.0704;15.8401,0.0752;16.8192,0.0799;17.797,0.0847;18.7735,0.0895;19.7488,0.0942;];
T = [1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;];
%;1;1;1;1;1;1;1;1;1;1;

% Sx_0=evalin('base','Sx_0');
% g_0=evalin('base','g_0');
% H_0=evalin('base','H_0');
% Su_0=evalin('base','Su_0');
% Sx_1=evalin('base','Sx_1');
% g_1=evalin('base','g_1');
% H_1=evalin('base','H_1');
% Su_1=evalin('base','Su_1');
% Sx_2=evalin('base','Sx_2');
% g_2=evalin('base','g_2');
% H_2=evalin('base','H_2');
% Su_2=evalin('base','Su_2');
Sx_3=evalin('base','Sx_3');
g_3=evalin('base','g_3');
H_3=evalin('base','H_3');
Su_3=evalin('base','Su_3');

Sx=Sx_3;
g=g_3;
H=H_3;
Su=Su_3;

%X2=X2_1+DX2;
%u=u_1+du;
%u=U_K_1;

% if (12*u-22.08*0.0183*X2)<1.4207
%     Sx=Sx_0;
%     g=g_0;
%     H=H_0;
%     Su=Su_0; 
% if (12*u-22.08*0.0183*X2)<6.7309 &(12*u-22.08*0.0183*X2)>1.4207
%     Sx=Sx_1;
%     g=g_1;
%     H=H_1;
%     Su=Su_1; 
% elseif (12*u-22.08*0.016*X2)>=6.7309 &(12*u-22.08*0.016*X2)<=7.3712
%     Sx=Sx_2;
%     g=g_2;
%     H=H_2;
%     Su=Su_2;
% 
% elseif (12*u-22.08*0.016*X2)>7.3712
%     Sx=Sx_3;
%     g=g_3;
%     H=H_3;
%     Su=Su_3;
% end 

DUmax = 1;
DUmin = 1;          %  -DUmin<du<DUmax
Umax = 0.8;
Umin = -0.8;
Ymax =1;
Ymin =0;

b1 = [-DUmax
      -DUmax      
      -DUmin
      -DUmin];
  
b2 = [U_K_1 - Umax
      U_K_1 - Umax
      Umin - U_K_1
      Umin - U_K_1
      ];

% b3 = [Sx * DX + T * Y - Ymax;
%       -(Sx * DX + T * Y) + Ymin];

c1 = [-eye(2)
      eye(2)]; 
  
c2 = [-eye(2)
      eye(2)];  
% c1 = [-eye(5)
%       eye(5)]; 
%   
% c2 = [-eye(5)
%       eye(5)];  
  
% c3 = [-Su;
%       Su];
  
% RefOut=50*[1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;];
Ep=RefOut-Sx*DX-T*Y;
G = g * Ep;

b = [b1;
    b2;
    %b3
    ];
c = [c1;
    c2;
    %c3
    ];
% b = [b1;
%     b2];
% c = [c1;
%     c2];
%Embedded MATLAB does not generate code for extrinsic functions. You declare %functions to be extrinsic by using the Embedded MATLAB function %eml.extrinsic
%eml.extrinsic('quadprog');  %Declare the function extrinsic in Embedded %MATLAB main functions or subfunctions 
% %X mxArray value returned by the extrinsic MATLAB function
X = [0 0]';
% %y ou must declare y to be the same type and size as X-a 2-by-1 matrix of %type double before assigning y to the return value of %X=QUADPROG(H,f,A,b,Aeq,beq)
%eml.extrinsic('optimset');
% %options = optimset('LargeScale','off');
% X=quadprog(H,-G,-c,-b) ;
% %%%%%%%%%%%%active set%%%%%%%%%%
% Ae=[];be=[];
%  b=[];c=[];
% [X, lambda, exitflag,output]=qpact(H,-G,Ae,be,c,b,X0);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  X = QPhild(H,-G,-c,-b );
% uu0=[0 1]*X ;
%tic
X=PSO(H,G,c2,b2);
%toc
%[xv,fv] = TrackRoute_improve(H,c,A,b,x0,y0,w0,p,delta,tolX)
du =  [1 0]*X; 
u= du+U_K_1;
% X2_1=DX2;
% u_1=du;

end

