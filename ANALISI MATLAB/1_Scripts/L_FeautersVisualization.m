% Feaut = {'GSR_total', 'PulsePulse_total', 'PP_total', 'PAT_total', 'POINT_total', 'F_OO_CLASS', 'RESP_total';
%     GSR_total, PulsePulse_total, PP_total, PAT_total, POINT_total, F_OO_CLASS, RESP_total};

% save('Feaut.mat')


%% gsr

visualize_statisticplot3(Feaut,[1 1 4],[4 5 2],[1 1 1 0.1])

colors = ['b','g','y','r'];
fe= {Feaut{2,1}{3,4},Feaut{2,1}{3,5},Feaut{2,1}{3,6}};

% for i=1:3
% fe{i}=normalize(fe{i},'none');
% end


for i=1:4
plot3(fe{1}(:,i),fe{2}(:,i),fe{3}(:,i),'o')
hold on
k = boundary(fe{1}(:,i),fe{2}(:,i),fe{3}(:,i));
trisurf(k,fe{1}(:,i),fe{2}(:,i),fe{3}(:,i),'Facecolor',colors(i),'FaceAlpha',0.1);
hold on
end
xlabel(strrep(convertCharsToStrings(Feaut{2,1}{1,4}),'_',' '))
ylabel(strrep(convertCharsToStrings(Feaut{2,1}{1,5}),'_',' '))
zlabel(strrep(convertCharsToStrings(Feaut{2,1}{1,6}),'_',' '))
title('GSR')
grid on

%% pp

colors = ['b','g','y','r'];
fe= {Feaut{2,3}{3,2},Feaut{2,3}{3,3},Feaut{2,3}{3,4}};

% for i=1:3
% fe{i}=normalize(fe{i},'none');
% end


for i=1:4
plot3(fe{1}(:,i),fe{2}(:,i),fe{3}(:,i),'o')
hold on
k = boundary(fe{1}(:,i),fe{2}(:,i),fe{3}(:,i));
trisurf(k,fe{1}(:,i),fe{2}(:,i),fe{3}(:,i),'Facecolor',colors(i),'FaceAlpha',0.1);
hold on
end
xlabel(strrep(convertCharsToStrings(Feaut{2,3}{1,2}),'_',' '))
ylabel(strrep(convertCharsToStrings(Feaut{2,3}{1,3}),'_',' '))
zlabel(strrep(convertCharsToStrings(Feaut{2,3}{1,4}),'_',' '))
title('PP')
grid on