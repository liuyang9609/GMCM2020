% [Da,data]=xlsread('1.xlsx','Sheel1','A2:L754');
clear;clc;close all;

% ���ൽ���������ݴ����PlaneArrivalType.mat�ļ������ݱ�������ΪPlaneArrivalType 
% 0�����ڳ���
% 1�����ʳ���
load('PlaneArrivalType.mat','PlaneArrivalType');

% �ǻ��ڵ����������ݴ����PortArrivalType.mat�ļ������ݱ�������ΪPortArrivalType
% 0�����ڵ���
% 1�����ʵ���
% 2�����ڹ��ʵ���
load('PortArrivalType.mat','PortArrivalType');  

% ��������������ݴ����PlaneLeaveType.mat�ļ������ݱ�������ΪPlaneLeaveType
% 0�����ڳ���
% 1�����ʳ���
load('PlaneLeaveType.mat','PlaneLeaveType');   
    
% �ǻ��ڳ����������ݴ����PortLeaveType.mat�ļ������ݱ�������ΪPortLeaveType
% 0�����ڳ���
% 1�����ʳ���
% 2�����ڹ��ʳ���
load('PortLeaveType.mat','PortLeaveType');       

% �ɻ���խ�������ݴ����PlaneType.mat�ļ������ݱ�������ΪPlaneType
% 0����ɻ�
% 1��խ�ɻ�
load('PlaneType.mat','PlaneType'); 

% �ǻ��ڿ�խ�������ݴ����PortType.mat�ļ������ݱ�������ΪPortType
% 0����ɻ�
% 1��խ�ɻ�
load('PortType.mat','PortType');   % Լ��������ɻ���խ��Լ����һ�£�20200831������������

% ���ൽ��ʱ�����ݴ����PlaneArrivalTime.mat�ļ������ݱ�������ΪPlaneArrivalTime
load('PlaneArrivalTime.mat','PlaneArrivalTime'); 

% �������ʱ�����ݴ����PlaneLeaveTime.mat�ļ������ݱ�������ΪPlaneLeaveTime
load('PlaneLeaveTime.mat','PlaneLeaveTime');       

I=303;   %�ɻ��� 
J=69;    %�ǻ�������
w=zeros(I,J);
for i=1:I
    for j=1:J
        if PlaneType(i)==PortType(j)
            if PortArrivalType(j)==2
                if PortLeaveType(j)==2
                    w(i,j)=1;
                elseif PlaneLeaveType(i)==PortLeaveType(j)
                    w(i,j)=1;
                end

            elseif PlaneArrivalType(i)==PortArrivalType(j)
                if PortLeaveType(j)==2
                    w(i,j)=1;
                elseif PlaneLeaveType(i)==PortLeaveType(j)
                    w(i,j)=1;
                end
            end  
        end
        
    end
end


% rֵӦ���ǵ���ʱ�䣨�󣩼�ȥ�뿪ʱ�䣨С��
% rֵ���ж�Ӧ���Ǵ��ڵ���
% ��ֵ�߼�������



tho=zeros(I,I);
% ��ʼ����ȫ�����
% 1������ͣ����ͬһ�ǻ���
% 0������ͣ����ͬһ�ǻ���

for m=1:I-1 
    for n=m+1:I
      
        IntervalTime1 = PlaneArrivalTime(m) - PlaneLeaveTime(n); %�������ܺ���ļ��ʱ��,m�ȵ���
        IntervalTime2 = PlaneArrivalTime(n) - PlaneLeaveTime(m); %�������ܺ���ļ��ʱ��,n�ȵ���
        if IntervalTime1 >= 45 ||IntervalTime2 >= 45
           tho(m,n) = 0;
        else
           tho(m,n) = 1;
        end
        
    end
end

save('tho.mat','tho') 
save('w.mat','w')

