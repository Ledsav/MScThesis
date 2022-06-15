
%% Passport analysis
close,clear,clc

[~ ,~ ,Pass] = xlsread('Notes_Passport_subjects.xlsx');

%drop not chosen subjects
Row_del = length(Pass)-3:length(Pass);
Pass(Row_del,:) = [];

%take only numerical values
Pass_mat = cell2mat(Pass(2:end,2:end-3));
Pass_label = strrep(convertCharsToStrings(Pass(1,2:end-3)),'_',' ');
Pass_subj = strrep(convertCharsToStrings(Pass(2:end,1)),'_',' ');

%% Test over skin conductance
Y = Pass_mat(:,25);
[B,I] = sort(Pass_mat(:,18));
Mat_skin = [B Y(I)];
mdl = fitlm(table(B,Y(I)));
figure()
plot(mdl)
title('Mean SC VS N°Peaks')
xlabel('Avg SC')
ylabel('N°Peaks')
%%  Points system

val = [-1 -1 -1 -0.5 -0.5 -0.5 0 0 ];
ar = [1 0.5 0 1 0.5 0 1 0.5];
labels = {'5','4','2','4','3','1','2','1'};

figure()
axis([-1 1    -1 1])
a=plot(-1:1,[0 0 0 ],'k');
hold on
b=plot([0 0 0],-1:1,'k');
hold on
plot(val,ar,'ro','MarkerFaceColor','r','MarkerSize',10)
title('Fear Consistency point system')
xlabel('Valence')
ylabel('Arousal')
axis('square')
a.Annotation.LegendInformation.IconDisplayStyle = 'off';
b.Annotation.LegendInformation.IconDisplayStyle = 'off';
text(val,ar,labels,'FontSize',10,'VerticalAlignment','middle','HorizontalAlignment','center','Color','white','FontWeight','bold')




vals = [0 1 2 3 4 5];
vals_sum = [vals;vals+1;vals+2;vals+3;vals+4;vals+5];
vals_vect(1,:) = [vals,vals+1,vals+2,vals+3,vals+4,vals+5];
vals_vect(2,:) = [zeros(1,6),zeros(1,6)+1,zeros(1,6)+2,zeros(1,6)+3,zeros(1,6)+4,zeros(1,6)+5];
vals_vect(3,:) = [0:5,0:5,0:5,0:5,0:5,0:5];
s = vals_vect(:,vals_vect(1,:)>=8)';
[B,I] = sort(s(:,1));
smn{1} = s(I,:);
m = vals_vect(:,vals_vect(1,:)>3 & vals_vect(1,:)<8)';
[B,I] = sort(m(:,1));
smn{2} = m(I,:);
n = vals_vect(:,vals_vect(1,:)>=0 & vals_vect(1,:)<4)';
[B,I] = sort(n(:,1));
smn{3} = n(I,:);
% k{1} = [6 6 6,1 1 1, 3 3 3];
% k{2} = [6 6 6,1 1 1, 3 3 3];
% k{3} = [6 6 6,1 1 1, 3 3 3];
colrs = ['r','y','b'];

figure()
for i=1:3
plot3(smn{i}(:,2),smn{i}(:,3),smn{i}(:,1),'ko')
hold on 
k = boundary(smn{i}(:,2),smn{i}(:,3));
h(i) = fill3(smn{i}(k,2),smn{i}(k,3),smn{i}(k,1),colrs(i),'FaceAlpha',0.1)
end
xlabel('Video')
ylabel('Audio')
zlabel('Sum')
title('Emotion Consistency Map')
legend(h(:),{'s','m','n'})
grid on
%%                       CLUSTERING slopes

%SLOPES________________________________________________
%3D plot slopes
Slopes = [Pass_mat(:,8),Pass_mat(:,17),Pass_mat(:,24)];
Slopes_true = [Pass_mat(:,7),Pass_mat(:,16),Pass_mat(:,23)];

[Au,ia,ic] = unique(Slopes, 'rows', 'stable');
Counts = accumarray(ic, 1);
Out = [Counts Au];

%organize----
Out_ordered=[];
%barchart organized by descending order
Out_ordered(1,:) =  Out(4,:);
Out_ordered(2,:) =  Out(2,:);
Out_ordered(3,:) =  Out(3,:);
Out_ordered(4,:) =  Out(1,:);
Out_ordered(5,:) =  Out(5,:);
Out_ordered(6,:) =  Out(6,:);
Out_ordered(7,:) =  [0 1 1 -1];
Out_ordered(8,:) =  [0 -1 1 -1];



for i=1:length(Out)
    Out_ordered(i,5) = length(find(Pass_mat(Pass_mat(:,8)==Out_ordered(i,2) & Pass_mat(:,17)==Out_ordered(i,3) & Pass_mat(:,24)==Out_ordered(i,4)& Pass_mat(:,26)<=3)));
    Out_ordered(i,6) = length(find(Pass_mat(Pass_mat(:,8)==Out_ordered(i,2) & Pass_mat(:,17)==Out_ordered(i,3) & Pass_mat(:,24)==Out_ordered(i,4)& Pass_mat(:,26)<=7 & Pass_mat(:,26)>3)));
    Out_ordered(i,7) = length(find(Pass_mat(Pass_mat(:,8)==Out_ordered(i,2) & Pass_mat(:,17)==Out_ordered(i,3) & Pass_mat(:,24)==Out_ordered(i,4)& Pass_mat(:,26)<=10 & Pass_mat(:,26)>7)));
end


for i=1:(size(Out_ordered,1))
    type(i,:) = sprintf("(n=%d m=%d s=%d)",Out_ordered(i,5:end));
end
type=cellstr(type);

% BAR CHART
figure()
%creo vettore con dentro dati divisi in 3 fasce 0-4 4-8 8-12 con
%pertinenza crescente all'emozione e data dalla somma di riposta visivia e
%uditiva
%analisi della correlazione cardiovascolare e skin
b = bar(Out_ordered(:,1));
xticklabels({'[t= -1,pp= -1,s= 1]','[t>= 0,pp= -1,s= 1]','[t= -1,pp>=0,s= 1]','[t= -1,pp= -1,s= -1]','[t>= 0 ,pp= -1,s= -1 ]','[t>= 0 ,pp>= 0,s= -1]','[t>= 0 ,pp>= 0,s= 1]','[t= -1,pp>= 0,s= -1]'})
hT=[];              % placeholder for text object handles
for i=1:length(b)  % iterate over number of bar objects
    hT=[hT text(b(i).XData+b(i).XOffset,b(i).YData,type(:,i),'VerticalAlignment','bottom','horizontalalign','center')];
end
b.FaceColor = 'flat';
b.CData(1,:) = [.5 0 .5];
b.CData(2,:) = [0.9290 0.6940 0.1250];
b.CData(3,:) = [0.8500 0.3250 0.0980];
b.CData(4,:) = [0.6350 0.0780 0.1840];

%The most frequent class is [-1,-1,1]

%% 3D plots SLOPES
%3Dplot slopes and cvs response
for i=1:length(Out)
    [r{i},c{i}] = find([Pass_mat(:,8)==Out_ordered(i,2) & Pass_mat(:,17)==Out_ordered(i,3) & Pass_mat(:,24)==Out_ordered(i,4)]==1);
end

figure()
colors = [[0.4940 0.1840 0.5560]; [0.9290 0.6940 0.1250]; [0.8500 0.3250 0.0980];[0.6350 0.0780 0.1840];[0 0.4470 0.7410];[0 0.4470 0.7410];[0 0.4470 0.7410]];
for i=1:length(r)
    h(i,1)=plot3(Slopes_true(r{i},1),Slopes_true(r{i},2),Slopes_true(r{i},3),'LineStyle','none' ,'Marker','o','MarkerEdgeColor',colors(i,:),'MarkerFaceColor',colors(i,:));
    hold on
    k = boundary(Slopes_true(r{i},1),Slopes_true(r{i},2),Slopes_true(r{i},3));
    h(i,2)=trisurf(k,Slopes_true(r{i},1),Slopes_true(r{i},2),Slopes_true(r{i},3),'Facecolor',colors(i,:),'FaceAlpha',0.1);
end
grid on
legend(h(:,1),{'[t= -1,pp= -1,s= 1]','[t>= 0,pp= -1,s= 1]','[t= -1,pp>=0,s= 1]','[t= -1,pp= -1,s= -1]','[t>= 0 ,pp= -1,s= -1 ]','[t>= 0 ,pp>= 0,s= -1]','[t>= 0 ,pp>= 0,s= 1]','[t= -1,pp>= 0,s= -1]'})
xlabel('Slope RR','FontWeight' ,'bold')
ylabel('Slope PP','FontWeight' ,'bold')
zlabel('Slope SC','FontWeight' ,'bold')
title('Slopes and Cardio-vascular-skin responses')

%%
%3Dplot slopes and smn response
clear r c h

[r{1},c{1}] = find(Pass_mat(:,26)<=10 & Pass_mat(:,26)>7);
[r{2},c{2}] = find(Pass_mat(:,26)<=7 & Pass_mat(:,26)>3);
[r{3},c{3}] = find(Pass_mat(:,26)<=3);
[r{4},c{4}] = find(isnan(Pass_mat(:,26)));

figure()
colors = [[205 0 0];[255 193 37];[141 238 238];[105 105 105]]/255;
for i=1:length(r)
    h(i,1)=plot3(Slopes_true(r{i},1),Slopes_true(r{i},2),Slopes_true(r{i},3),'LineStyle','none' ,'Marker','o','MarkerEdgeColor',colors(i,:),'MarkerFaceColor',colors(i,:));
    hold on
    % k = boundary(Slopes_true(r{i},1),Slopes_true(r{i},2),Slopes_true(r{i},3));
    % h(i,2)=trisurf(k,Slopes_true(r{i},1),Slopes_true(r{i},2),Slopes_true(r{i},3),'Facecolor',colors(i,:),'FaceAlpha',0.1);
end
grid on
legend(h(:,1),{'s','m','n','none'})
xlabel('Slope RR','FontWeight' ,'bold')
ylabel('Slope PP','FontWeight' ,'bold')
zlabel('Slope SC','FontWeight' ,'bold')
title('Slopes and Severe-midium-none responses')


% sovraposition
clear r c h
for i=1:length(Out)
    [r{i},c{i}] = find([Pass_mat(:,8)==Out_ordered(i,2) & Pass_mat(:,17)==Out_ordered(i,3) & Pass_mat(:,24)==Out_ordered(i,4)]==1);
end

figure()
colors = [[0.4940 0.1840 0.5560]; [0.9290 0.6940 0.1250]; [0.8500 0.3250 0.0980];[0.6350 0.0780 0.1840];[0 0.4470 0.7410];[0 0.4470 0.7410];[0 0.4470 0.7410]];
for i=1:length(r)
    k = boundary(Slopes_true(r{i},1),Slopes_true(r{i},2),Slopes_true(r{i},3));
    h(i,1)=trisurf(k,Slopes_true(r{i},1),Slopes_true(r{i},2),Slopes_true(r{i},3),'Facecolor',colors(i,:),'FaceAlpha',0.1);
    hold on
end

clear r c

[r{1},c{1}] = find(Pass_mat(:,26)<=10 & Pass_mat(:,26)>7);
[r{2},c{2}] = find(Pass_mat(:,26)<=7 & Pass_mat(:,26)>3);
[r{3},c{3}] = find(Pass_mat(:,26)<=3);
[r{4},c{4}] = find(isnan(Pass_mat(:,26)));


colors = [[205 0 0];[255 193 37];[141 238 238];[105 105 105]]/255;
for i=1:length(r)
    plot3(Slopes_true(r{i},1),Slopes_true(r{i},2),Slopes_true(r{i},3),'LineStyle','none' ,'Marker','o','MarkerEdgeColor',colors(i,:),'MarkerFaceColor',colors(i,:))
    hold on
    % k = boundary(Slopes_true(r{i},1),Slopes_true(r{i},2),Slopes_true(r{i},3));
    % h(i,2)=trisurf(k,Slopes_true(r{i},1),Slopes_true(r{i},2),Slopes_true(r{i},3),'Facecolor',colors(i,:),'FaceAlpha',0.1);
end

grid on

legend({'[t= -1,pp= -1,s= 1]','[t>= 0,pp= -1,s= 1]','[t= -1,pp>=0,s= 1]','[t= -1,pp= -1,s= -1]','[t>= 0 ,pp= -1,s= -1 ]','[t>= 0 ,pp>= 0,s= -1]','s','m','n','nan'})
xlabel('Slope RR','FontWeight' ,'bold')
ylabel('Slope PP','FontWeight' ,'bold')
zlabel('Slope SC','FontWeight' ,'bold')
title('Slopes plus Cardio-vascular-skin and smn responses')

%% CLUSTERING mean values

%possibilità di fare reference normalizato

% x= rrmean_norm y=ppmean_norm z=skintonic_norm

[K,clusters] = Cluster_Passports(Pass_subj,Pass_label,Pass_mat,5,14,22,'',4,0,0);
%normalization


% x= rrmean_norm y=ppvar z=skintonic_norm
[K,clusters] = Cluster_Passports(Pass_subj,Pass_label,Pass_mat,7,16,23,'',4,0,1);


