clc;clear;
A1=xlsread('����һ��ֵ��.xlsx','Sheet1','C4:J324');
A2=xlsread('����һ��ֵ��.xlsx','Sheet1','M4:MN324');
A=[A1,A2];
[Astd,A_mean,A_std]=zscore(A);  %��׼��


r=cov(Astd);              %��������֮���Э�������
[vec,val,con]=pcacov(r);  %vecΪ����������valΪ����ֵ��conΪ�����ɷֹ�����
cum=cumsum(con);

%��ʯͼ  ��������--����ֵ
x=1:348';
figure
plot(x,val,'r-','LineWidth',2);hold on

axis([-5,353,-5,120])
ylabel('����ֵ')
xlabel('���ɷ�')
figure;
plot(x(7:45),val(7:45),'r-','LineWidth',2);hold on
plot(x(7:45),val(7:45),'rx-','LineWidth',1);hold on
plot(x(7:45),ones(39),'--','LineWidth',1);hold on
ylabel('����ֵ')
xlabel('���ɷ�')


f1=repmat(sign(sum(vec)),size(vec,1),1);
vec=vec.*f1;%
f2=repmat(sqrt(val)',size(vec,1),1);
a=vec.*f2;        %����ȫ�����ӵ��غɾ���
num=26;         %numΪ���ӵĸ���
a1=a(:,1:num); %���26���ӵ��غɾ���
tcha=diag(r-a1*a1'); %���ӵ����ⷽ��?
ccha=r-a1*a1'-diag(tcha);%��в����?
[b,t]=rotatefactors(a(:,1:num),'method','varimax')%���غɾ��������ת
%����bΪ��ת�غɾ���tΪ�任����������?
coef=inv(r)*b;%����÷ֺ�����ϵ��?
score=B*coef;





