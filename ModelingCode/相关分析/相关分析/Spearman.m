%相关性分析
% Spearman斯皮尔曼等级相关系数
% 适应范围：不需要假定服从正态分布
%-----------------------------------------------------------
% 调用格式coeff=corr(X,'type','Spearman')
%        X为n行P列矩阵，表示有P个特征，每个特征有n个样本点
%        coeff为P行P列矩阵，coeff(i,j)表示第i个特征和第j个特征的相关系数
%-------------------------------------------------------------------
% 结果分析
% >0.95 显著相关
% >0.8 高度相关
% 0.5-0.8 中等程度相关
% 0.3-0.5 弱相关
% <0.3 认为不相关
X1=[135.1,139.9,163.6,146.5,156.2,156.4,167.8,149.7,145.0,148.5 165.5 135 153.3 152 160.5]';
X2=[32 30.4 46.2 33.5 37.1 35.5 41.5 31.0 33.0 37.2 49.5 27.6 41 32 47.2]';
X3=[1750 2000 2150 2500 2750 2000 2150 1500 2500 2250 3000 1250 2750 1750 2250]';
X=[X1,X2,X3];

coeff = corr(X,'type','Spearman')