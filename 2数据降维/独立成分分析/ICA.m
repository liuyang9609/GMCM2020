
%�����ݵĶ����ɷ�
%���������Z��ģ���ݣ����� n*mά��mΪ����������nΪ����������
%         perica��ȡ��Ϣ������һ���ٷ�����
%���������W�ֽ���󣨾��� n*qά��nΪ����������qΪ�����ɷָ�����
%         SL�����ɷ֣����� m*qά��mΪ����������qΪ�����ɷָ�����
%         XSΪX�Ĺ���ֵ������ m*nά��mΪ����������nΪ����������
%         E�в���Ϣ������ m*nά��mΪ����������nΪ����������

clc
clear
filename = '����һ��ֵ��.xlsx';
xlRange = 'C4:ML324';
Z = xlsread(filename,xlRange);
Z = Z';

perica=0.8;

[VariableNum,SampleNum]=size(Z);
numofIC=VariableNum;% �ڴ�Ӧ���У�����Ԫ�������ڱ�������
W=[];
B=zeros(numofIC,VariableNum);              % ��ʼ��������w�ļĴ����,B=[b1  b2  ...   bd]
for r=1:numofIC                            % ������ȡÿһ������Ԫ
    i=1;maxIterationsNum=1000;j=1;              % ����������������������ÿ�������������Ե������������˴�����
    IterationsNum=0;
    b=rand(numofIC,1)-.5;                  % �������b��ֵ
    b=b/norm(b);                           % ��b��׼��
    while i<=maxIterationsNum+1
        if i == maxIterationsNum           % ѭ����������
            fprintf('\n��%d������%d�ε����ڲ���������', r,maxIterationsNum);
            break;
        end
        bOld=b;                      
        a2=1;
        u=1;
        t=Z'*b;
        g=(exp(2.*t)-1)./(exp(2.*t)+1);
        dg=4*exp(2.*t)./(exp(2.*t)+1).^2;
        b=(Z*g)-mean(dg)*b;
                                            % ���Ĺ�ʽ���μ����۲��ֹ�ʽ2.52
        b=b-B*B'*b;                         % ��b������
        b=b/norm(b); 
        if abs(abs(b'*bOld)-1)<1e-9         % ����������򱣴�b
               B(:,r)=b; 
               W=B(:,1:r);
             break;
        end
        i=i+1;        
    end 
    SL=Z'*W;
    XS=(SL*W');
    E=Z'-XS;
    e=Message(E)/Message(Z');
    if e<(1-perica)
        fprintf('\nǰ%d�����ɷ���Ϣ���ڰٷ�֮��ʮ���ϣ�ֹͣ��ȡ.',r);
        break;
    end
end