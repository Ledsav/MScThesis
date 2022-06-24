% Feaut = {'GSR_total', 'PulsePulse_total', 'PP_total', 'PAT_total', 'POINT_total', 'F_OO_CLASS', 'RESP_total';
%     GSR_total, PulsePulse_total, PP_total, PAT_total, POINT_total, F_OO_CLASS, RESP_total};

% save('Feaut.mat')
clc,clear,close all

global type
global fea

type =[1 1 1];
fea = [4 5 6];




load('Feaut.mat')


%% DISPLAY CLUSTERS

%FIRST 3D VECTOR
% 'GSR_total' 1
% 'PulsePulse_total' 2
% 'PP_total' 3
% 'PAT_total' 4
% 'POINT_total' 5
% 'F_OO_CLASS' 6
% 'RESP_total' 7


visualize_statisticplot3(Feaut,[1 1 1],[4 5 6]);
visualize_statisticplot3_votes(Feaut,type,fea)


