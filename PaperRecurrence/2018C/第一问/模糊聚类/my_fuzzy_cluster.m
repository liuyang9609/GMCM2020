close all;
clc;clear;

global data scale;

%��ȡExcel����
if numel(data)==0
    file='input.xlsx';
    range='B2:N18474';
    [data,TXT,RAW]=xlsread(file,1,range);
end 

n=size(data,2);
%��������
feature=data;

%������Ȩ
w=[1.00,1.00,1.00,1.00,1.00,1.00,1.00,1.00,1.00,1.00,1.00,0.0001,0.0001];
global ceshi_index;
ceshi_index=1;
w=0.001*ones(1,13);
w(ceshi_index)=1;

%��һ��
scale=(max(feature)-min(feature));
scale=max(1e-3,scale./w);
feature_scale=feature./(ones(1,1)*scale);

%�������
dis=pdist(feature_scale,'euclidean');
link=linkage(dis);
figure;dendrogram(link);xlabel('���');ylabel('�ۺϾ������߶�')
c=cluster(link,'maxclust',5);
li=feature;%li=feature_scale;
figure;scatter3(li(:,1),li(:,2),li(:,3),200,c,'filled');%hold on;for i=1:numel(c);annotation('textbox',[li(i,:)],);end
name={'max(V)','mean(V)','std(V)'};title('������');xlabel(name{1});ylabel(name{2});zlabel(name{3});

if 1
    %��cluster�������еó�����
    mode={};
    uc=unique(c);
    for i=1:numel(uc);
        mode{i}=find(c==uc(i));
    end
end


