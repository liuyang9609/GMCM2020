% �Ŵ��㷨�ӳ���:����crossover.m
% 
% ���ø�ʽ��
% newpop=crossover(pop,pc,option)
% newpop=crossover(pop,pc)
% ˵����
% newpop��ʾ����������Ⱥ��pop-��ʼ��Ⱥ��pc������ʣ�
% option��ʾѡ��ʽ��
% �����ڶ����ƵĽ��淽ʽ��singlepoint--���㽻�棬
% ��������������Ľ��淽ʽ��order--˳�򽻲�OX
% 
% ��ע��
% 
%--------------------------------------------------------------------
function newpop=crossover(pop,pc,option)
if  nargin==3
    switch lower(option)
        case 'singlepoint'        %���㽻��---�����ڶ����Ʊ���    
            [newpop]=singlepoint(pop,pc);   
        case 'order'           %˳�򽻲�Order Crosser---��������������
            [newpop]=order(pop,pc);
        case 'mapped'
            [newpop]= mapped(pop,pc);
        otherwise
            error('Unkonwn distribution type')
    end

elseif  nargin==2 %Ĭ�ϵ��㽻��
    	[newpop]=singlepoint(pop,pc);
else
    error('Number of input parameters error');
end

end






%------���㽻��---�����ڶ����Ʊ���-----------------------------------------
function [newpop]=singlepoint(pop,pc)
[px,py]=size(pop);
      %��pop��newpop��ʼ��,ִ�н���ĸ���ᱻ�滻,��û��ִ�н�������ĸ���,�����ֱ�ӱ���
newpop=pop;
for i=1:2:px-1     %��Ⱥ��Ϊ˫��������1�͸���2���н��棬����3�͸���4���н���...
    if(rand<pc)    %��Ⱥ��Ϊ���������һ�����岻ִ�н���.
        cpoint=ceil(rand*py); %ceil����ȡ��.����һ��[1,py]�ڵ����������Ϊ����λ��
      
       
        newpop(i,:)=[pop(i,1:cpoint),pop(i+1,cpoint+1:py)];
        newpop(i+1,:)=[pop(i+1,1:cpoint),pop(i,cpoint+1:py)];
        
    end            %������ɵ������<������ʣ�����н��棬���򲻽��н���
end                %���ڳ�ʼ��newpopʱ��pop��newpop��ʼ�����ʲ���Ҫд
                   %else 
                   %    newpop(i,:)=pop(i,��);newpop(i+1,:)=pop(i+1,��);

end    
%-------------------------------------------------------------------------

%-------˳�򽻲�Order Crosser---��������������------------------------------        
function [newpop]=order(pop,pc)
[px,py]=size(pop);
newpop=pop;
for i=1:2:px-1 
    if(rand<pc)     %������ɵ������<������ʣ�����н��棬���򲻽��н���
       cpoint=sort(randperm(py,2)); %�ҵ��������λ�ã����Ӵ�С����
       rlength=length(cpoint(1):cpoint(2)); %����λ���м䲿��Ϊ��������,�����䳤��,�ڵڶ���ѭ�������,�����ظ���������ļ�����
       if  cpoint(1)~=cpoint(2)
           a=[];
           b=[];
           for j=1:py     %��������forѭ����Ϊ���ڸ���2���򸸴�1�����ҳ���
               count1=0;  %����1���򸸴�2���������ֲ���ͬ�Ļ����ţ�����˳��
               count2=0;  %�����ڱ���a(��b)��.
               for k=cpoint(1):cpoint(2)
                   if newpop(i+1,j)~=newpop(i,k)
                      count1=count1+1;
                   end
                   if newpop(i,j)~=newpop(i+1,k)
                      count2=count2+1;
                   end
               end
               if count1==rlength
                  a=[a,newpop(i+1,j)]; 
               end
               if count2==rlength
                  b=[b,newpop(i,j)];
               end  
           end
           newpop(i,1:cpoint(1)-1)=a(1:cpoint(1)-1);
           newpop(i,cpoint(2)+1:py)=a(cpoint(1):end);
           newpop(i+1,1:cpoint(1)-1)=b(1:cpoint(1)-1);
           newpop(i+1,cpoint(2)+1:py)=b(cpoint(1):end);
       end
    end  
end




end          
           
    
%-------------------------------------------------------------------------

%-------Mapped Crossover (PMX)---��������������------------------------------         
function children = mapped(parents,~)
% CROSSOVER
% children = CROSSOVER(parents) Replicate the mating process by crossing 
% over randomly selected parents. 
%
% Mapped Crossover (PMX) example:     
%           _                          _                          _
%    [1 2 3|4 5 6 7|8 9]  |-> [4 2 3|1 5 6 7|8 9]  |-> [4 2 3|1 8 6 7|5 9]
%    [3 5 4|1 8 7 6|9 2]  |   [3 5 1|4 8 7 6|9 2]  |   [3 8 1|4 5 7 6|9 2]
%           |             |            |           |              |            
%           V             |            V           |              |  
%    [* 2 3|1 5 6 7|8 9] _|   [4 2 3|1 8 6 7|* 9] _|              V
%    [3 5 *|4 8 7 6|9 2]      [3 * 1|4 5 7 6|9 2]           ... ... ...
%

[popSize, numberofcities] = size(parents);    
children = parents; % childrens

for i = 1:2:popSize % pairs counting
    parent1 = parents(i+0,:);  child1 = parent1;
    parent2 = parents(i+1,:);  child2 = parent2;
    % chose two random points of cross-section
    InsertPoints = sort(ceil(numberofcities*rand(1,2)));
    for j = InsertPoints(1):InsertPoints(2)
        if parent1(j)~=parent2(j)
            child1(child1==parent2(j)) = child1(j);
            child1(j) = parent2(j);
            
            child2(child2==parent1(j)) = child2(j);
            child2(j) = parent1(j);
        end
    end
    % two childrens:
    children(i+0,:)=child1;     children(i+1,:)=child2;
end

       
       
       
       
      

end
       
       
       
       
       
       
       
       
       
       
       
       