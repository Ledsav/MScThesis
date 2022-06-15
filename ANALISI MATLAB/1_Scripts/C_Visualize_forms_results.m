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
plotResultsDistribution(MAT_PRE,MAT_POST,'s')

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


%% Create voting system

[names,inx] = sort(string(POST.POST2));
ind = [3 4 19 20 7 8 21 22 11 12 23 24 15 16 25 26];
for i =1:length(ind)
    votes(:,i) =MAT_POST(:,ind(i));
end

%sad
votes_sad = zeros(29,2);
votes_sad((votes(:,[1 3])== -1 & votes(:,[2 4])== -1))= 5;
votes_sad((votes(:,[1 3])== -0.5 & votes(:,[2 4])== -0.5))= 3;
votes_sad((votes(:,[1 3])== -1 & votes(:,[2 4])== -0.5)|(votes(:,[1 3])== -0.5 & votes(:,[2 4])== -1))= 4;
votes_sad((votes(:,[1 3])== -1 & votes(:,[2 4])== 0)|(votes(:,[1 3])== 0 & votes(:,[2 4])== -1))= 2;
votes_sad((votes(:,[1 3])== -0.5 & votes(:,[2 4])== 0)|(votes(:,[1 3])== 0 & votes(:,[2 4])== -0.5))= 1;
%relax
votes_relax = zeros(29,2);
votes_relax(votes(:,[5 7])== 1 & votes(:,[6 8])== -1)= 5;
votes_relax(votes(:,[5 7])== 0.5 & votes(:,[6 8])== -0.5)= 3;
votes_relax((votes(:,[5 7])== 1 & votes(:,[6 8])== -0.5)|(votes(:,[5 7])== 0.5 & votes(:,[6 8])== -1))= 4;
votes_relax((votes(:,[5 7])== 1 & votes(:,[6 8])== 0)|(votes(:,[5 7])== 0 & votes(:,[6 8])== -1))= 2;
votes_relax((votes(:,[5 7])== 0.5 & votes(:,[6 8])== 0)|(votes(:,[5 7])== 0 & votes(:,[6 8])== -0.5))= 1;
%happy
votes_happy = zeros(29,2);
votes_happy((votes(:,[9 11])== 1 & votes(:,[10 12])== 1))= 5;
votes_happy((votes(:,[9 11])== 0.5 & votes(:,[10 12])== 0.5))= 3;
votes_happy((votes(:,[9 11])== 1 & votes(:,[10 12])== 0.5)|(votes(:,[9 11])== 0.5 & votes(:,[10 12])== 1))= 4;
votes_happy((votes(:,[9 11])== 1 & votes(:,[10 12])== 0)|(votes(:,[9 11])== 0 & votes(:,[10 12])== 1))= 2;
votes_happy((votes(:,[9 11])== 0.5 & votes(:,[10 12])== 0)|(votes(:,[9 11])== 0 & votes(:,[10 12])== 0.5))= 1;
%fear
votes_fear = zeros(29,2);
votes_fear(votes(:,[13 15])== -1 & votes(:,[14 16])== 1)= 5;
votes_fear(votes(:,[13 15])== -0.5 & votes(:,[14 16])== 0.5)= 3;
votes_fear((votes(:,[13 15])== -1 & votes(:,[14 16])== 0.5)|(votes(:,[13 15])== -0.5 & votes(:,[14 16])== 1))= 4;
votes_fear((votes(:,[13 15])== -1 & votes(:,[14 16])== 0)|(votes(:,[13 15])== 0 & votes(:,[14 16])== 1))= 2;
votes_fear((votes(:,[13 15])== -0.5 & votes(:,[14 16])== 0)|(votes(:,[13 15])== 0 & votes(:,[14 16])== 0.5))= 1;

votes_sad = sum(votes_sad,2);
votes_relax = sum(votes_relax,2);
votes_happy = sum(votes_happy,2);
votes_fear = sum(votes_fear,2);

votes_sad = votes_sad(inx);
votes_relax = votes_relax(inx);
votes_happy = votes_happy(inx);
votes_fear = votes_fear(inx);

vote_tab = table(names,votes_sad,votes_relax,votes_happy,votes_fear);

%save('votes_choer','votes_sad','votes_relax','votes_happy','votes_fear','vote_tab')