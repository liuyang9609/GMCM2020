% �Ŵ��㷨�ӳ���:����mutation.m
% �����ͻ���ձ����������Ľ���������.�ڶ����Ʊ�����,������ָ�����е�ÿ��
% �����ÿһλ���Ը��� pm ��ת�����ɡ�1����Ϊ��0�������ɡ�0����Ϊ��1��
% �ŵ㣺�Ŵ��㷨�ı������Կ���ʹ���������������������ܴ��ڵ������ռ䣬
% ��˿�����һ���̶������ȫ�����Ž⡣
% ���ø�ʽ��
% newpop=mutation(pop,pm,option)
% newpop=mutation(pop,pm)
% ˵����
% newpop��ʾ����������Ⱥ��pop-��ʼ��Ⱥ��pm������ʣ�
% option��ʾѡ��ʽ��
% �����ڶ����Ƶı��췽ʽ��binary--�����Ʊ��죬
% ��������������Ľ��淽ʽ��convert--���ñ��죨���������⣩
% ��ע��
% ������һ���ȡ0.001~0.1
%--------------------------------------------------------------------
function newpop=mutation(pop,pm,option)
if  nargin==3
    switch lower(option)
        case 'binary'        %�����Ʊ���---�����ڶ����Ʊ���    
            [newpop]=binary(pop,pm);   
        case 'convert'           %���ñ���---�������������루���������⣩
            [newpop]=convert(pop,pm);
        otherwise
            error('Unkonwn distribution type')
    end

elseif  nargin==2 %Ĭ�϶����Ʊ��취
    	[newpop]=binary(pop,pm);
else
    error('Number of input parameters error');
end

end



%------�����Ʊ���---�����ڶ����Ʊ���-----------------------------------------
function [newpop]=binary(pop,pm)
[px,py]=size(pop);
newpop=pop;      
for i=1:px
    if(rand<pm)
        mpoint=ceil(rand*py);
        if any(newpop(i,mpoint))==0
           newpop(i,mpoint)=1;
        else
           newpop(i,mpoint)=0;
        end
    end
end

end
%-------------------------------------------------------------------------

%-------���ñ���---�������������루���������⣩------------------------------
function [newpop]=convert(pop,pm)
[px,py]=size(pop);
newpop=pop;
for i=1:px
    if(rand<pm)
        mpoint=sort(randperm(py,2));
        newpop(i,mpoint(1):mpoint(2))=fliplr(pop(i,mpoint(1):mpoint(2)));
    end
end

end

