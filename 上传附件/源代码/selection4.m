% �Ŵ��㷨�ӳ���:ѡ��selection.m
% 
% ���ø�ʽ��
% [newpop]=selection(pop,fitvalue,option,q)
% [newpop]=selection(pop,fitvalue,option)
% ˵����
% newpop��ʾѡ�������Ⱥ��pop-��ʼ��Ⱥ��fitvalue-��pop�����������Ӧ��ֵ��
% option��ʾѡ��ʽ��roulette-���̶�ѡ��sortslection-����ѡ��
% competition-������ѡ��. ��ʡ�ԣ�Ĭ��Ϊ���̶�ѡ��
% q-����ѡ��ʱ,��ʾ��õĸ���ѡ��ĸ���;
% q-����ѡ��ʱ����ʾ���뾺���ĸ�����(��������Ϊ2)
% ��ע��
% 
%--------------------------------------------------------------------
function newpop=selection(pop,fitvalue,option,q)
if  nargin>=3
    switch lower(option)
        case 'roulette'        %roulette���̶�ѡ��    
            newpop=Rselection(pop,fitvalue);   
        case 'sortslection'    %sort����ѡ��
            newpop=Sortselection(pop,fitvalue,q);%qΪ��õĸ���ѡ��ĸ���
        case 'competition'     %������ѡ��
            newpop=Cselection(pop,fitvalue,q); %qΪ���뾺���ĸ�����
        otherwise
            error('Unkonwn distribution type')
    end

elseif  nargin==2 %Ĭ�����̶�ѡ��
    [newpop]=Rselection(pop,fitvalue);
else
    error('Number of input parameters error');
end

end
        

%--------���̶�ѡ��-----------------------------------------------------
function [newpop]=Rselection(pop,fitvalue)
    totalfit=sum(fitvalue);     %����Ӧֵ֮��
    fitvalue=fitvalue/totalfit; %�������屻ѡ��ĸ���
    fitvalue=cumsum(fitvalue);  %�����ۼƸ���. cumsum�����ۼӺͣ�
    [px,py]=size(pop);          %��x=[1 2 3 4]���� cumsum(x)=[1 3 6 10] 
    ms=sort(rand(px,1)); %��С��������  ����px��0-1���ȷֲ��������
    fitin=1;
    newin=1;
    newpop=ones(px,py);
    while newin<=px 
          if(ms(newin))<fitvalue(fitin)
              newpop(newin,:)=pop(fitin,:);
              newin=newin+1;
          else
              fitin=fitin+1;
          end
    end
end
%-------------------------------------------------------------------------

%-------����ѡ��----------------------------------------------------------
function [newpop]=Sortselection(pop,fitvalue,q) 
    [px,py]=size(pop);
    [~,Sindex]=sort(fitvalue,'descend');%����Ӧ��ֵ���򣬷���������Ⱥ�е����� 
    pop=pop(Sindex,:);%�����������Ӧ�ȴӴ�С����      
    P=q*(1-q).^((1:px)-1)/(1-(1-q)^px);%���ݹ�ʽ�����i������ѡ��ĸ���
    PP=cumsum(P); %�����ۼƸ���
    newpop=ones(px,py);
    for i=1:px
        r=rand;         %�����̶�һ��������px���������
        for j=1:px      %ÿ����������κ��ۼƸ��ʱȽϣ�ѡ�е�һ������r��ֵ             
            if r<=PP(j) %ǰ�����whileѭ�� ����ʹ������forѭ��
               newpop(i,:)=pop(j,:);
               break;
            end
        end 
    end
end
%-------------------------------------------------------------------------

%-------������ѡ��----------------------------------------------------------
function [newpop]=Cselection(pop,fitvalue,sn)
    [px,py]=size(pop);
    newpop=ones(px,py);
    for i=1:px
        r=randi([1 px],sn,1);          %����[1,px]��Sn��һ�е��������������
        [~,bestindex]=max(fitvalue(r));%������ѡ��Sn��������뾺�� 
        newpop(i,:)=pop(r(bestindex),:);%��Sn��������ѡ��������Ӧֵ���屣��
    end
end








%���̶�ѡ�񷽷����Ƚϴ���ʱ����Ӧ�Ƚϸߵĸ���Ҳѡ����