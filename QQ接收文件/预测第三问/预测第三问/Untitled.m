clear ;clc;
B=xlsread('���ӷ�������.xlsx','Sheet2','B4:AB351');
X1=xlsread('����һ��ֵ��.xlsx','Sheet1','C4:J324');
X2=xlsread('����һ��ֵ��.xlsx','Sheet1','M4:MN324');
X=[X1,X2];
[Xstd,X_mean,X_std]=zscore(X);  %��׼��
F=X*B;
[Fstd,F_mean,F_std]=zscore(F);
y=xlsread('����һ��ֵ��.xlsx','Sheet1','L4:L324');
[ystd,y_mean,y_std]=zscore(y);

figure;
plot(Fstd(:,3),ystd,'x')
