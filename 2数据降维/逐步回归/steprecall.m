clc
clear
filename = '����һ��ֵ���𲽻ع�.xlsx';
xlRange = 'C4:ML324';
data = xlsread(filename,xlRange);

A=data(:,10);
B=data(:,1:8);
C=[B,data(:,11:end)];

stepwise(C, A)