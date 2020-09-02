% ���������
% clear;clc;close all;
% �������߱���

load w;
load tho;

load('Da_Dl_Ia_Il.mat')
load('PassengerNumber.mat')

I=303;   %�ɻ���
J=69;    %�ǻ�������
Jt=28;

%Trans + �������� + �������� + ����ǻ��� + �����ǻ���
% D:����
% I:����
% T:�ǻ�¥
% S:������
TransDDTT=15;
TransDDTS=20;
TransDDST=20;
TransDDSS=15;

TransDITT=35;
TransDITS=40;
TransDIST=40;
TransDISS=35;

TransIDTT=35;
TransIDTS=40;
TransIDST=40;
TransIDSS=45;

TransIITT=20;
TransIITS=30;
TransIIST=30;
TransIISS=20;


x = binvar(I,J);
y = binvar(1,J);

%Ŀ�꺯��
% u = 0.005;   %Ȩ�أ�Ȩ��������Ҫ������
u = 0.01;
lamda = 100000;

z = (Da*Dl*Ta*Tl*TransDDTT+Da*Dl*Ta*Sl*TransDDTS+Da*Dl*Sa*Tl*TransDDST+Da*Dl*Sa*Sl*TransDDSS...
+Da*Il*Ta*Tl*TransDITT+Da*Il*Ta*Sl*TransDITS+Da*Il*Sa*Tl*TransDIST+Da*Il*Sa*Sl*TransDISS...
+Ia*Dl*Ta*Tl*TransIDTT+Ia*Dl*Ta*Sl*TransIDTS+Ia*Dl*Sa*Tl*TransIDST+Ia*Dl*Sa*Sl*TransIDSS...
+Ia*Il*Ta*Tl*TransIITT+Ia*Il*Ta*Sl*TransIITS+Ia*Il*Sa*Tl*TransIIST+Ia*Il*Sa*Sl*TransIISS)*PassengerNumber...
-lamda*sum(x(:))+u*sum(y);  %Ŀ�꺯��


tic
%Լ������1---ÿ�ܷɻ����ͣ����һ���ǻ��ڣ����Բ�ͣ���ڵǻ��ڣ�ͣ������ʱͣ������
c1=[];
for i=1:I
    temp=0;
    for j=1:J
        temp=temp+x(i,j);
    end
    c1=[c1;temp<=1];
end
toc

tic
%Լ������2---ÿ�ܷɻ�ֻ��ͣ�������Լ�������ͬ�ĵǻ���
c2=[];
for i=1:I
    for j=1:J
        c2=[c2;x(i,j)<=w(i,j)];
    end
end
toc

tic
%Լ������3---���ڵ�j���ǻ���ֻҪ��һ�ܷɻ�ռ�ã�yj=1��
c3=[];
for i=1:I
    for j=1:J
        c3=[c3;x(i,j)<=y(j)];
    end
end
toc

%Լ������4---ʱ��������45����
tic
c4=[];
for m=1:I-1
    for n=m+1:I
        t=x(m,:)+x(n,:)<=2-tho(m,n);
        c4=[c4;t'];
    end
end
toc

%Լ������5---�Ƿ��ں�վ¥�ǻ���
tic
c5=[];
for i=1:I
    temp=0;
    for j=1:Jt
        temp=temp+x(i,j);
    end
    c5=[c5;temp==Ti];
end
toc

%Լ������6---�Ƿ����������ǻ���
tic
c6=[];
for i=1:I
    temp=0;
    for j=Jt+1:J
        temp=temp+x(i,j);
    end
    c6=[c6;temp==Si];
end
toc


C=[c1;c2;c3;c4;c5;c6];

% ����
ops = sdpsettings('solver','cplex');
tic
% ���
reuslt = optimize(C,z,ops);
toc

if reuslt.problem == 0  % problem=0:���ɹ�
    value(x)
    -value(z)   % ��ת
else
    disp('������');
end

x1=value(x);
y1=value(y);
save('x.mat','x1') 
save('y.mat','y1')

%�鿴����ã�����Ҫ
% length(find(y1))   
% fenpei=sum(x1,2)
% find(fenpei==0)    
