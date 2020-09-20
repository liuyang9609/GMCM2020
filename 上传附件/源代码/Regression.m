% �ع�

clear ;clc;

%�����ļ�
B=xlsread('���ӷ���0919���.xlsx','�÷־���','D8:AC11');
X1=xlsread('�������ݴ����.xlsx','Sheet1','C4:J328');
X2=xlsread('�������ݴ����.xlsx','Sheet1','M4:MI328');
X=[X1,X2];

[Xstd,X_mean,X_std]=zscore(X);  
F=Xstd*B;
y=xlsread('�������ݴ����.xlsx','Sheet1','L4:L328');
n=length(F); %n��ʾ��������

[b,bint,r,rint,s]=regress(y(1:300,:),[ones(300,1),F(1:300,:)]); 
rcoplot(r,rint)   %�в��ִ��������ͼ

mask=find(rint(:,1).*rint(:,2)<0);
newy=y(mask);
newF=F(mask,:);
[a,aint,r,rint,s]=regress(newy,[ones(length(newF(:,1)),1),newF]);     
rcoplot(r,rint)  %�в��ִ��������ͼ

%����Ԥ��ֵ 
y_=[ones(325,1),F]*b;

figure;
plot(275:325,y(275:325));
hold on
plot(275:325,y_(275:325));
xlabel('����')
ylabel('������ʧֵ')
legend('ʵ����ʧֵ','Ԥ����ʧֵ')

%ģ�ͼ���
epsilon=y_-y;           %�в�
delta=abs(epsilon./y);  %������

figure;
plot(301:325,epsilon(301:325),'o');hold on
plot(295:330,zeros(1,36),'--');
axis([295 330 -1 1])
xlabel('����')
ylabel('�в�')


