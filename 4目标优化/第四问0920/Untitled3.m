% ���������
clear;clc;close all;
load a;
load b;
c=a(2:end)'*b;

Xmin=xlsread('ɸѡ��331������������Ϣ.xlsx', 'Sheet1','F2:F332');
Xmax=xlsread('ɸѡ��331������������Ϣ.xlsx', 'Sheet1','G2:G332');
delta=xlsread('ɸѡ��331������������Ϣ.xlsx', 'Sheet1','J2:J332');
Xp=xlsread('�������ݴ����.xlsx','Sheet1','Q4:MI4')';


% �������߱���
x=sdpvar(13,1);
n=intvar(1,1);

% Ŀ�꺯��
% Rl=c(1:end)*x;
Rl=c(1:13)*x;

% Լ������1 ��Ʒ����x8<=5
c1=x(8)==5;

% Լ������2 ����������ı�������
c2=[];
for i=[1:7,9:12]
   c2=[c2;x(i)==Xp(i)];
end

% Լ��3
c3=[];
for i=13:13
    c3=[c3;x(i)<=Xmax(i-12)];
end

c4=[];
for i=13:13
    c4=[c4;Xmin(i-12)<=x(i)];
end

% Լ��4
% c4=[];
% for i=1:331
%     if i~=124&&i~=128
%     c4=[c4;x(i)==Xp(i)+n(i)*delta(i)]; 
%     end
% end

% ���Լ������
% C = [c1;c2;c3;c4];
C = [c3;c4];
% ����
ops = sdpsettings('solver','cplex');

% ���
reuslt = optimize(C,Rl);

if reuslt.problem == 0 % problem =0 �������ɹ�
    value(x)
    -value(z)   % ��ת
else
    disp('������');
    display('������');
	reuslt.info
	yalmiperror(reuslt.problem)
end
