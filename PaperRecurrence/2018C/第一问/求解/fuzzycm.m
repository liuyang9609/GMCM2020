function [U,center,Dist,Cluster_Res,Obj_Fcn,iter]=fuzzycm(Data,C,plotflag,M,epsm)
% ģ�� C ��ֵ���� FCM: �������ʼ�����־���ʼ����
% [U,P,Dist,Cluster_Res,Obj_Fcn,iter] = fuzzycm(Data,C,plotflag,M,epsm)
% ����:
%     Data: N��S �;���,�����ԭʼ����,��һ�����޵Ĺ۲�������,
%           Data ��ÿһ��Ϊһ���۲�����������ʸ��,S Ϊ����ʸ��
%           ��ά��,N Ϊ������ĸ���
%     C:    ������,1<C<N
%     plotflag: ������ 2D/3D ��ͼ���,0 ��ʾ����ͼ,Ϊȱʡֵ        
%     M:    ��Ȩָ��,ȱʡֵΪ 2
%     epsm: FCM �㷨�ĵ���ֹͣ��ֵ,ȱʡֵΪ 1.0e-6
% ���:
%     U:     C��N �;���,FCM �Ļ��־���
%     center:C��S �;���,FCM �ľ�������,ÿһ�ж�Ӧһ������ԭ��
%     Dist:  C��N �;���,FCM ���������ĵ���������ľ���,������
%            �� i �������� j �ľ���Ϊ Dist(i,j)
%     Cluster_Res: ������,�� C ��,ÿһ�ж�Ӧһ��
%     Obj_Fcn: Ŀ�꺯��ֵ
%     iter: FCM �㷨��������
% See also: fuzzydist maxrowf fcmplot
if nargin<5             %Ĭ����ֵ1.0e-6
    epsm=1.0e-6; 
end
if nargin<4             %Ĭ��M=2
    M=2;
end
if nargin<3            %��ͼ���
    plotflag=0;
end

[N,S]=size(Data);      %����N��������S������
m=2/(M-1);
iter=0;
Dist(C,N)=0; 
U(C,N)=0; 
center(C,S)=0;

% ����һ
% �����ʼ�����־���
U0 = rand(C,N); 
U0=U0./(ones(C,1)*sum(U0));

% FCM �ĵ����㷨
while true 
    % ����������
    iter=iter+1; 
    % �ڶ���
    % �������¾������� center
    Um=U0.^M;
    center=Um*Data./(ones(S,1)*sum(Um'))';   
    
    % ���»��־��� U
    for i=1:C
        for j=1:N
            Dist(i,j)=fuzzydist(center(i,:),Data(j,:));
        end
    end  
    
    U=1./(Dist.^m.*(ones(C,1)*sum(Dist.^(-m))));  
    
    % Ŀ�꺯��ֵ: ���ڼ�Ȩƽ������
    if nargout>4 | plotflag
        Obj_Fcn(iter)=sum(sum(Um.*Dist.^2));
    end
    
    % FCM �㷨����ֹͣ����
    if norm(U-U0,Inf)<epsm
        break
    end
    U0=U;   
end



% ������
if nargout > 3
    res = maxrowf(U);
    for c = 1:C
        v = find(res==c);
        Cluster_Res(c,1:length(v))=v;
    end
end
% ��ͼ
if plotflag
    fcmplot(Data,U,center,Obj_Fcn);
end



function D=fuzzydist(A,B)
% ģ���������: ������ľ���
% D = fuzzydist(A,B)
D=norm(A-B);







% 
function fcmplot(Data,U,P,Obj_Fcn)
% FCM �����ͼ����
% See also: fuzzycm maxrowf ellipse
[C,S] = size(P); res = maxrowf(U);
str = 'po*x+d^v><.h'; 
% Ŀ�꺯����ͼ
figure(1),plot(Obj_Fcn)
title('Ŀ�꺯��ֵ�仯����','fontsize',8)
% 2D ��ͼ
if S==2 
    figure(2),plot(P(:,1),P(:,2),'rs'),hold on
    for i=1:C
        v=Data(find(res==i),:); 
        plot(v(:,1),v(:,2),str(rem(i,12)+1))      
        ellipse(max(v(:,1))-min(v(:,1)), ...
                max(v(:,2))-min(v(:,2)), ...
                [max(v(:,1))+min(v(:,1)), ...
                max(v(:,2))+min(v(:,2))]/2,'r:')    
    end
    grid on,title('2D ������ͼ','fontsize',8),hold off
end
% 3D ��ͼ
if S>2 
    figure(2),plot3(P(:,1),P(:,2),P(:,3),'rs'),hold on
    for i=1:C
        v=Data(find(res==i),:);
        plot3(v(:,1),v(:,2),v(:,3),str(rem(i,12)+1))      
        ellipse(max(v(:,1))-min(v(:,1)), ...
                max(v(:,2))-min(v(:,2)), ...
                [max(v(:,1))+min(v(:,1)), ...
                max(v(:,2))+min(v(:,2))]/2, ...
                'r:',(max(v(:,3))+min(v(:,3)))/2)   
    end
    grid on,title('3D ������ͼ','fontsize',8),hold off
end
% 




% 
function mr=maxrowf(U,c)
% ����� U ÿ�е� c ��Ԫ��������,c ��ȱʡֵΪ 1
% ���ø�ʽ: mr = maxrowf(U,c)
% See also: addr
if nargin<2
    c=1;
end
N=size(U,2);mr(1,N)=0;
for j=1:N
    aj=addr(U(:,j),'descend');
    mr(j)=aj(c);
end
% 

function ellipse(a,b,center,style,c_3d)
% ����һ����Բ
% ����: ellipse(a,b,center,style,c_3d)
% ����:
%     a: ��Բ���᳤(ƽ���� x ��)
%     b: ��Բ���᳤(ƽ���� y ��)
%     center: ��Բ������ [x0,y0],ȱʡֵΪ [0,0]
%     style: ���Ƶ����ͺ���ɫ,ȱʡֵΪʵ����ɫ
%     c_3d:   ��Բ�������� 3D �ռ��е� z ������,��ȱʡ
if nargin<4
    style='b';
end
if nargin<3 | isempty(center)
    center=[0,0];
end
t=1:360;
x=a/2*cosd(t)+center(1);
y=b/2*sind(t)+center(2);
if nargin>4
    plot3(x,y,ones(1,360)*c_3d,style)
else
    plot(x,y,style)
end

function f = addr(a,strsort)
% ������������������к��������ԭʼ�����е�����
% ��������:f = addr(a,strsort)
% strsort: 'ascend' or 'descend'
%          default is 'ascend'
% -------- example --------
% addr([ 4 5 1 2 ]) returns ans:
%       [ 3   4   1   2 ]
if nargin==1
    strsort='ascend';
end
sa=sort(a); ca=a;
la=length(a);f(la)=0;
for i=1:la
    f(i)=find(ca==sa(i),1);
    ca(f(i))=NaN;
end
if strcmp(strsort,'descend')
    f=fliplr(f);
end