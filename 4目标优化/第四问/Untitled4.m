% �ع� ����Ԥ���ڲ�����
% һԪ���Իع飺���������������֮������Թ�ϵ
% ��Ԫ���Իع飺������������������֮������Թ�ϵ
% [b,bint,r,rint,s]=regress(y,[ones(length(X),1),X]) ȡ������ˮƽĬ��Ϊ0.05
% ���Իع鲻��׼��
clear ;clc;
B=xlsread('���ӷ�������.xlsx','Sheet2','B4:AB351')';

X1=xlsread('����һ��ֵ��.xlsx','Sheet1','C4:J324');
X2=xlsread('����һ��ֵ��.xlsx','Sheet1','M4:MN324');
X=[X1,X2];
[Xstd,X_mean,X_std]=zscore(X);  %��׼��
F=X*B;


y=xlsread('����һ��ֵ��.xlsx','Sheet1','L4:L324');





[b,bint,r,rint,s]=regress(y,[ones(321,1),F]);     %ȡ������ˮƽĬ��Ϊ0.05
                                                     %b ϵ�� bint b����������
                                                     %r �в� rint r����������
rcoplot(r,rint)   %�в��ִ��������ͼ



mask=find(rint(:,1).*rint(:,2)<0)
[b,bint,r,rint,s]=regress(y(mask),[ones(length(mask),1),F(mask,:)]);     %ȡ������ˮƽĬ��Ϊ0.05
                                                     %b ϵ�� bint b����������
                                                     %r �в� rint r����������
rcoplot(r,rint)   %�в��ִ��������ͼ





%step 2 ����Ԥ��ֵ



y_=[ones(321,1),F]*b

%step 3 ģ�ͼ���
epsilon=y_-y   %�в�
delta=abs(epsilon./y)      %������   <0.2 �ﵽһ��Ҫ��<0.1 �ﵽ�ϸ�Ҫ��

figure;
plot(1:321,epsilon,'o');hold on
plot(-5:330,zeros(1,336),'--');
axis([-5 330 -1 1.5])
xlabel('����')
ylabel('�в�')