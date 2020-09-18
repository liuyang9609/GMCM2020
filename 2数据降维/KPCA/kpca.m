clc
clear
filename = '����һ��ֵ��.xlsx';
xlRange = 'C4:ML324';
data = xlsread(filename,xlRange);
data = data';

[Xrow, Xcol] = size(data);    % Xrow���������� Xcol���������Ը���

%%����Ԥ����
Xmean = mean(data); % ��ԭʼ���ݵľ�ֵ
Xstd = std(data); % ��ԭʼ���ݵķ���
X0 = (data-ones(Xrow,1)*Xmean) ./ (ones(Xrow,1)*Xstd); % ��׼��X0,��׼��Ϊ��ֵ0������1;
% c = 20000; %�˲����ɵ�
c = 200; %�˲����ɵ�

%%��˾���
for i = 1 : Xrow
    for j = 1 : Xrow
        %k(i,j)=kernel(data(i,:),data(j,:),2,6);   
        K(i,j) = exp(-(norm(X0(i,:) - X0(j,:)))^2/c);%��˾��󣬲��þ�����˺���������c
    end
end

%%���Ļ�����
unit = (1/Xrow) * ones(Xrow, Xrow);
Kp = K - unit*K - K*unit + unit*K*unit; % ���Ļ�����

%%����ֵ�ֽ�
[eigenvector, eigenvalue] = eig(Kp); % ��Э������������������eigenvector��������ֵ��eigenvalue��

%��λ����������(��׼��)
for m =1 : 348
    for n =1 : 348
        Normvector(n,m) = eigenvector(n,m)/sum(eigenvector(:,m));
    end
end

eigenvalue_vec = real(diag(eigenvalue)); %������ֵ����ת��Ϊ����
[eigenvalue_sort, index] = sort(eigenvalue_vec, 'descend'); % ����ֵ���������У�eigenvalue_sort�����к�����飬index�����
pcIndex = []; % ��¼��Ԫ��������ֵ�����е����

pcn = 25; % ����ֵ����
for k = 1 : pcn 
    pcIndex(k) = index(k); % ������Ԫ���
end
for i = 1 : pcn
    pc_vector(i) = eigenvalue_vec(pcIndex(i)); % ��Ԫ����
    P(:, i) = Normvector(:, pcIndex(i)); % ��Ԫ����Ӧ����������������������
end
project_invectors = k*P;
pc_vector2 = diag(pc_vector); % ������Ԫ�Խ��� 

% [row, col] = size(project_invectors);
% for i = 1 : row
%     project_invectors_mean(i,1)=project_invectors(i,1)/50;
%     for j = 2 : col
%         project_invectors_mean(i,j)=project_invectors(i,j)/25;
%     end
% end

% %������άɢ��ͼ
% x=project_invectors(:,1);
% y=project_invectors(:,2);
% z=project_invectors(:,3);
% scatter3(x,y,z,'filled')
