%[Da,data]=xlsread('1.xlsx','Sheel1','A2:L754');
clear;clc;close all;
load('ArrivalType.mat','ArrivalType');    %���ൽ���������ݴ����ArrivalType.mat�ļ������ݱ�������ΪArrivalType 
load('ArrivalType1.mat','ArrivalType1');  %�ǻ��ڵ����������ݴ����ArrivalType1.mat�ļ������ݱ�������ΪArrivalType1 
load('LeaveType.mat','LeaveType');        %��������������ݴ����LeaveType.mat�ļ������ݱ�������ΪLeaveType 
load('LeaveType1.mat','LeaveType');       %�ǻ��ڳ����������ݴ����LeaveType1.mat�ļ������ݱ�������ΪLeaveType1 
load('PlaneType.mat','PlaneType');        %�ɻ���խ�������ݴ����PlaneType.mat�ļ������ݱ�������ΪPlaneType
load('PlaneType1.mat','PlaneType');       %�ǻ��ڿ�խ�������ݴ����PlaneType1.mat�ļ������ݱ�������ΪPlaneType1
load('ArrivalTime.mat','ArrivalTime');    %���ൽ��ʱ�����ݴ����ArrivalTime.mat�ļ������ݱ�������ΪArrivalTime
load('LeaveTime.mat','LeaveTime');        %�������ʱ�����ݴ����LeaveTime.mat�ļ������ݱ�������ΪLeaveTime
I=303;   %�ɻ��� 
J=69;    %�ǻ�������
w=zeros(I,J);
for i=1:I
    for j=1:J
        if PlaneType(i)==PlaneType1(j)
            if ArrivalType1(j)==2
                if LeaveType1(j)==2
                    w(i,j)=1;
                elseif LeaveType(i)==LeaveType1(j)
                     w(i,j)=1;
                end
            elseif ArrivalType(i)==ArrivalType1(j)
                if LeaveType1(j)==2
                    w(i,j)=1;
                elseif LeaveType(i)==LeaveType1(j)
                     w(i,j)=1;
                end
            end  
        end
    end
end

tho=zeros(I,I);   %��Σ����
for m=1:I
    for n=1:I
        if m==n
            r=0;
        else
            r=LeaveTime(m)-ArrivalTime(n);
        end
        if   r>45                 %���ڵ��ڣ�
            tho(m,n)=0;           %��m�ܷɻ��͵�n�ܷɻ�����ͣ����ͬһ�ǻ���
        else
             tho(m,n)=1;          %��m�ܷɻ��͵�n�ܷɻ�������ͣ����ͬһ�ǻ���
        end
    end
end

save('tho.mat','tho') 
save('w.mat','w')

                    
        
