% �ع� ����Ԥ���ڲ�����
% һԪ���Իع飺���������������֮������Թ�ϵ
% ��Ԫ���Իع飺������������������֮������Թ�ϵ
% [b,bint,r,rint,s]=regress(y,[ones(length(X),1),X]) ȡ������ˮƽĬ��Ϊ0.05
% ���Իع鲻��׼��
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




[b,bint,r,rint,s]=regress(ystd,[ones(321,1),Fstd]);     %ȡ������ˮƽĬ��Ϊ0.05
                                                     %b ϵ�� bint b����������
                                                     %r �в� rint r����������
rcoplot(r,rint)   %�в��ִ��������ͼ



mask=find(rint(:,1).*rint(:,2)<0)
[b,bint,r,rint,s]=regress(ystd(mask),[ones(length(mask),1),Fstd(mask,:)]);     %ȡ������ˮƽĬ��Ϊ0.05
                                                     %b ϵ�� bint b����������
                                                     %r �в� rint r����������
rcoplot(r,rint)   %�в��ִ��������ͼ




% mask=find(rint(:,1).*rint(:,2)<0)
% newy=newy(mask);
% newF=newF(mask,:);
% [b,bint,r,rint,s]=regress(newy,[ones(length(newF(:,1)),1),newF]);     %ȡ������ˮƽĬ��Ϊ0.05
%                                                      %b ϵ�� bint b����������
%                                                      %r �в� rint r����������
% rcoplot(r,rint)   %�в��ִ��������ͼ
% 
% 
% mask=find(rint(:,1).*rint(:,2)<0)
% newy=newy(mask);
% newF=newF(mask,:);
% [b,bint,r,rint,s]=regress(newy,[ones(length(newF(:,1)),1),newF]);     %ȡ������ˮƽĬ��Ϊ0.05
%                                                      %b ϵ�� bint b����������
%                                                      %r �в� rint r����������
% rcoplot(r,rint)   %�в��ִ��������ͼ
% 
% 
% mask=find(rint(:,1).*rint(:,2)<0)
% newy=newy(mask);
% newF=newF(mask,:);
% [b,bint,r,rint,s]=regress(newy,[ones(length(newF(:,1)),1),newF]);     %ȡ������ˮƽĬ��Ϊ0.05
%                                                      %b ϵ�� bint b����������
%                                                      %r �в� rint r����������
% rcoplot(r,rint)   %�в��ִ��������ͼ

 


%step 2 ����Ԥ��ֵ



y_=[ones(321,1),Fstd]*b
y1=y_.*y_std+y_mean
%step 3 ģ�ͼ���
epsilon=y1-y   %�в�
delta=abs(epsilon./y)      %������   <0.2 �ﵽһ��Ҫ��<0.1 �ﵽ�ϸ�Ҫ��

figure;
plot(1:321,epsilon,'o');hold on
plot(-5:330,zeros(1,336),'--');
axis([-5 330 -1 1.5])
xlabel('����')
ylabel('�в�')