% 2.2.2 �������Ʊ���ת��Ϊʮ������(2)
% decodechrom.m�����Ĺ����ǽ�Ⱦɫ��(������Ʊ���)ת��Ϊʮ����.
% spoint=cumsom([0 L])��ʾ������Ķ����ƴ�����ʼλ��,L(i)��ʾ��i�������ĳ���
% �������������������ȷֱ�ΪL=[10 5 6]��cumsom([0 L])=[0 10 15 21];��˵�i��
% ��������ʼλ�þ���starpoint=spoint(i)+1;��ֹλ��endpoint=spoint(j+1).
% varnum��������
% real(i,j) ��i�������j��������ʵ��ʮ����ֵ
%�Ŵ��㷨�ӳ���
%Name: decodechrom.m
%�������Ʊ���ת����ʮ����
function real=decodechrom(spoint,varnum,pop,Xmax,Xmin)
[px,py]=size(pop);
real=zeros(px,varnum);%��ʵ��ʮ����ֵ
    for i=1:px
        for j=1:varnum
            starpoint=spoint(j)+1;
            endpoint=spoint(j+1);
            real(i,j)=decodebinary(pop(i,starpoint:endpoint),Xmax(j),Xmin(j));
        end
    end
