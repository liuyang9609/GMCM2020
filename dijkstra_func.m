function [mydistance,path]=dijkstra_func(a,sb,db)
%���룺a--�ڽӾ���a(ij)��ָi��j֮��ľ��룬�����������
%sb--���ķ���  db--�յ�ķ���
%�����distance--���·�ľ���  path--���·��·��

    n=size(a,1);
    visited(1:n)=0;
    distance(1:n)=inf;  %������㵽������֮��ľ���
    distance(sb)=0;
    parent(1:n)=0;

    for i=1:n-1
        temp=distance;
        id1=find(visited==1);  %�����Ѿ���ŵĵ�

        temp(id1)=inf;  %�ѱ�ŵĵ���뻻������
        [t,u]=min(temp);  %�ұ��ֵ��С�ĵ�
        visited(u)=1;  %����Ѿ���ŵĶ���
        id2=find(visited==0);  %����δ��ŵĶ���

        for v=id2
            if a(u,v)+distance(u)<distance(v)
                distance(v)=a(u,v)+distance(u);  %�޸ı��ֵ
                parent(v)=u;
            end
        end
    end

    path=[];

    if parent(db) ~= 0  %�������·
        t=db;
        path=[db];
        while t ~= sb
            p = parent(t);
            path=[p path];
            t=p;
        end
    end

    mydistance=distance(db);
    return 