% ���������
clear;clc;close all;
% �������߱���
x = sdpvar(1,2);
% ���Լ������
C = [
    x(1) + x(2)  >= 2
    x(2)-x(1) <=1
    x(1)<=1
    ];
% ����
ops =sdpsettings('verbose',0,'solver','cplex');
% Ŀ�꺯��
z = -(x(1)+2*x(2)); % ע������������ֵ
% ���
reuslt = optimize(C,z);
if reuslt.problem == 0 % problem =0 �������ɹ�
    value(x)
    -value(z)   % ��ת
else
    disp('������');
end
