function [center,U,w,Obj_Fcn,iter]=wfcm(Data,C,plotflag,M,epsm)
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
w=rand(1,S);
w=w./sum(w);
% FCM �ĵ����㷨
while iter<1000 
    % ����������
    iter=iter+1; 
    % �ڶ���
    % �������¾������� center
    Um=U0.^M;
    center=Um*Data./(ones(S,1)*sum(Um'))';   
    
    %������
    % ���»��־��� U
    for i=1:C
        for j=1:N
            Dist(i,j)=fuzzydist(center(i,:),Data(j,:),w);
        end
    end  
    
    
    U=1./(Dist.^m.*(ones(C,1)*sum(Dist.^(-m))));  
    
   dxc=zeros(C,N,S); 
   for i=1:C
        for j=1:N
            dxc(i,j,:)=Um(i,j).*(Data(j,:)-center(i,:)).^2;
        end
   end
   for s=1:S
        tempvar1(s)=sum(sum(dxc(:,:,s))).^(-1); 
   end
  
   tempvar2=sum(tempvar1);
   w= tempvar1./ tempvar2;
   
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

end



function D=fuzzydist(A,B,w)
% ģ���������: ������ľ���
% D = fuzzydist(A,B)
D=norm((A-B)*diag(w));
end