close
clc
clear

filename = '����һ��ֵ��.xlsx';
xRange1 = 'C4:ML324';
% xRange1 = 'C4:C324';
xdata1 = xlsread(filename,xRange1);

% checkRes = chi2gof(xdata1);
[m,n]=chi2stat(xdata1);