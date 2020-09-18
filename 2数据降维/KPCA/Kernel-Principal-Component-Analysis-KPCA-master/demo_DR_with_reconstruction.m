
%  Examples for dimensionality reduction based on KPCA
% --------------------------------------------------------------------

clc
clear all
close all
addpath(genpath(pwd))

% load data
% load('.\data\circle.mat')   

filename = '����һ��ֵ��.xlsx';
xlRange = 'C4:ML324';
data = xlsread(filename,xlRange);

X = data(:, 1:2);
label = data(:, 3);
% set kernel function
kernel = Kernel('type', 'gauss', 'width', 0.5);
% parameter setting
parameter = struct('application', 'dr', 'kernel', kernel);
% build a KPCA object
kpca = KernelPCA(parameter);
% train KPCA model using given data
X_map = kpca.train(data);
% reconstruct the mapping data
X_re = kpca.reconstruct;
% Visualize the reconstruction
% Visualization.reconstruct(X, X_map, X_re, label);
