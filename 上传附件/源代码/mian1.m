clc;clear;
load Xmean;
load Xstd;
load c;
c8=c(8);
c13_343=c(13:end)';
c1_7_8_12=c([1:7,8:12])';
load delta 
% delta=(delta-X_mean(13:end)')./X_std(13:end)';

load Xmin                                         %���ޣ����������޸�
load Xmax    %���ޣ����������޸�
% Xmin=(Xmin-X_mean(13:end)')./X_std(13:end)';
% Xmax=(Xmax-X_mean(13:end)')./X_std(13:end)';

xij=xlsread('����.xlsx','Sheet2','B2:LT2')';      %������ͬ������
% xij=(xij-X_mean(13:end)')./X_std(13:end)';
xp=xlsread('����.xlsx','Sheet3','B3:M3')';       %������ͬ������

m=zeros(343,1);
m([5 6 23 33 80 86 118 125 141 145 168 182 235 247 336])=[-0.0744286 0.0178557 -0.0082684 -4.63709 0.0462119 -0.0192759 -0.059552 1.22517 -0.0079627 -0.0120777 -0.0515196 0.0045955 -0.0611329 0.0303882 -9.05489e-5];
m0=39.0248;


L1=(Xmin-xij)./delta;
L2=(Xmax-xij)./delta;
Nmax=L2;
Nmin=L1;
Nmax=ceil(Nmax);
Nmin=floor(Nmin);
postion=find(L1>L2);
Nmax(postion)=L1(postion);
Nmin(postion)=L2(postion);



global Cmin;
varnum=331;%��������
eps=1e-1;
popsize=20; %Ⱥ���С���޸�
Gene=50;     %��������
pc=0.95; %�������
pm=0.05; %�������



%����ÿ��������������Ҫ�ĵĳ���
for i=1:varnum
    L(i)=ceil(log2((Nmax(58)-Nmin(58))/eps));
end
L=real(L);
chromlength=sum(L);%ÿ������������λ��


count=0;
spoint=cumsum([0 L]);
pop=round(rand(popsize,chromlength));
while 1
      tempn=round(rand(1,chromlength)); %���������ʼȺ�� %rand�������0-1�ڵľ��ȷֲ������������popsize�У�chromlength��
      n=decodechrom(spoint,varnum,tempn,Nmax,Nmin);%��ʵ��ʮ����ֵ
      n=round(n);
      ndelat=(n'.*delta);
      S=m0+m(5)*xp(5)+m(6)*xp(6)+sum(m(13:end).*(xij+ndelat));
      if S<=5&&S>=3
         count=count+1;
         pop(count,:)=tempn;
      end
       if count>=popsize
          break;
      end
      
end





for i=1:Gene %GeneΪ��������
    
    %��������ת��Ϊʮ����
    real10=decodechrom(spoint,varnum,pop,Xmax,Xmin);%��ʵ��ʮ����ֵ
    real10=round(real10);
    [objvalue]=calobjvalue(real10,c13_343,m,c8,delta); %����Ŀ�꺯��
    fitvalue=calfitvalue(objvalue); %����Ⱥ����ÿ���������Ӧ��
    [newpop]=selection(pop,fitvalue,'roulette'); %ѡ��
    [newpop]=crossover(newpop,pc,'singlepoint'); %����
    
    count=0;
    for j=1:2*popsize
        tempn=newpop(j,:);
        n=decodechrom(spoint,varnum,tempn,Xmax,Xmin);%��ʵ��ʮ����ֵ
        n=round(n);
        ndelat=(n'.*delta);
        S=m0+m(5)*xp(5)+m(6)*xp(6)+sum(m(13:end).*(xij+ndelat));
        if S<=5&&S>=2
            count=count+1;
            newpop(count,:)=tempn;
        end
        if count>popsize
            newpop=newpop(1:20,:);
        else
            newpop=[newpop(1:count,:),count(1:popsize-count,:)];
        end
        [newpop]=mutation(newpop,pm,'binary'); %����
    end
    
    
    [bestindividual,bestfit]=best(pop,fitvalue); %���Ⱥ������Ӧֵ���ĸ��弰����Ӧֵ
    bestindividual10(i,:)=decodechrom(spoint,varnum,bestindividual,Xmax,Xmin); %��Ѹ������
    y(i)=bestfit+Cmin; %��Ѹ�����Ӧ��
    y_mean(i)=mean(fitvalue+Cmin); %��i��ƽ����Ӧ��
    plot(i,y(i),'r.');
    hold on
    plot(i,y_mean(i),'b.');
    pop=newpop;  



end

bestn=bestindividual10(50,:);
bestx=xij+bestn'.*delta





















% function fitvalue=calfitvalue1(objvalue)
% global Cmin;
% Cmin=0;
% [px,py]=size(objvalue);
% for i=1:px
%     if objvalue(i)+Cmin>0
%         temp=Cmin+objvalue(i);
%     else
%         temp=0.0;
%     end
%     fitvalue(i)=temp;
% end
% fitvalue=fitvalue';




