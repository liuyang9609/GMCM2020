%Spearman˹Ƥ��������Է���
clc;
clear;
close;

%�����ļ�
filename = '5��ֵ���.xlsx';
xRange = 'C4:MI328';
xdata = xlsread(filename,xRange);

%XΪn��P�о��󣬱�ʾ��P��������ÿ��������n��������
%coeffΪP��P�о���coeff(i,j)��ʾ��i�������͵�j�����������ϵ��
coeff = corr(xdata,'type','Spearman');


