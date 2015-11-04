fid=fopen('u_c_1.txt','r');
for i=1:1001;
    num_fixed(i)=fscanf(fid,'%f',1);
end
%fid=fopen('u_c_1.txt','r');
% for i=1:701;
%     num1(i)=fscanf(fid,'%f',1);
% end
%num_1=num';
%num1_1=num1'
fid=fopen('u_c_2.txt','r');
for i=1:1001;
    num_VC(i)=fscanf(fid,'%f',1);
end
% 
% fid=fopen('u_c_1_verilog.txt','r');
% for i=1:701;
%     num_fixed_verilog(i)=fscanf(fid,'%f',1);
% end
% 
% fid=fopen('u_c_1_one.txt','r');
% for i=1:701;
%     num_fixed_one(i)=fscanf(fid,'%f',1);
% end
% 
% fid=fopen('verilog_modelsim.txt','r');
% for i=1:701;
%     ne(i)=fscanf(fid,'%f',1);
% end


% du_1=EXP2(:,2);
%num_sfun=du_sfun(:,2);
num_1=du(:,2);
x=1:1001;
figure(1)
plot(x,num_fixed,'.r',x,num_VC,'b','LineWidth',1.5);
figure(2)
plot(x,num_fixed-num_VC);
legend('VC_fixed','VC_float');