clear all
close all
clc


% import csv to visualize the topology


[~ ,~ ,PRE] = xlsread('PRE.xlsx');
PRE(1,:)=[];
PRE = cell2table(PRE);
PRE = PRE(:,1:43);

[~ ,~ ,POST] = xlsread('POST.xlsx');
POST(1,:)=[];
POST = cell2table(POST);
POST = POST(:,1:43);

siz_pre = size(PRE);
siz_post = size(POST);
%% Analisi SAM

important_columns = [5,6,8,9,11,12,14,15,17,18,20,21,23,24,26,27,29,30,32,33,35,36,38,39,41,42];

%array columns
%dalla colonna 17 iniziano gli audio
MAT_PRE = table2array(PRE(1:siz_pre(1),important_columns));
MAT_POST = table2array(POST(1:siz_post(1),important_columns));
NAMES_POST = table2array(POST(1:siz_post(1),2));
%PRE
%MAPPING MATRIX
MAT_PRE_PARI = MAT_PRE(:,2:2:end);
MAT_PRE_DISP = MAT_PRE(:,1:2:end);

%pair (arousal)
MAT_PRE_PARI(MAT_PRE_PARI == 1) = 2/2;
MAT_PRE_PARI(MAT_PRE_PARI == 2) = 1/2;
MAT_PRE_PARI(MAT_PRE_PARI == 3) = 0;
MAT_PRE_PARI(MAT_PRE_PARI == 4) = -1/2;
MAT_PRE_PARI(MAT_PRE_PARI == 5) = -2/2;

%odd (valence)

MAT_PRE_DISP(MAT_PRE_DISP == 1) = -2/2;
MAT_PRE_DISP(MAT_PRE_DISP == 2) = -1/2;
MAT_PRE_DISP(MAT_PRE_DISP == 3) = 0;
MAT_PRE_DISP(MAT_PRE_DISP == 4) = 1/2;
MAT_PRE_DISP(MAT_PRE_DISP == 5) = 2/2;

MAT_PRE(:,2:2:end) = MAT_PRE_PARI;
MAT_PRE(:,1:2:end) = MAT_PRE_DISP;

%POST
%MAPPING MATRIX
MAT_POST_PARI = MAT_POST(:,2:2:end);
MAT_POST_DISP = MAT_POST(:,1:2:end);

%pair (arousal)
MAT_POST_PARI(MAT_POST_PARI == 1) = 2/2;
MAT_POST_PARI(MAT_POST_PARI == 2) = 1/2;
MAT_POST_PARI(MAT_POST_PARI == 3) = 0;
MAT_POST_PARI(MAT_POST_PARI == 4) = -1/2;
MAT_POST_PARI(MAT_POST_PARI == 5) = -2/2;

%odd (valence)

MAT_POST_DISP(MAT_POST_DISP == 1) = -2/2;
MAT_POST_DISP(MAT_POST_DISP == 2) = -1/2;
MAT_POST_DISP(MAT_POST_DISP == 3) = 0;
MAT_POST_DISP(MAT_POST_DISP == 4) = 1/2;
MAT_POST_DISP(MAT_POST_DISP == 5) = 2/2;

MAT_POST(:,2:2:end) = MAT_POST_PARI;
MAT_POST(:,1:2:end) = MAT_POST_DISP;

save('Matrixes_pre_post','MAT_POST','MAT_PRE','NAMES_POST')
%%
%Image
% -b1.1 (1,2)
% -sad (3,4)
% -b2.2 (5,6)
% -rel (7,8)
% -b1.2 (9,10)
% -happy(11,12)
% -b2.1 (13,14)
% -fear (15,16)

%Audio
% -b (17,18)
% -sad (19,20)
% -rel (21,22)
% -happy (23,24)
% -fear (25,26)

plotResultsDistribution(MAT_PRE,MAT_POST,'s')

