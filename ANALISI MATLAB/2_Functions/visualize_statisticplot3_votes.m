function visualize_statisticplot3_votes(Feaut,type_of_feaut,vect_feat)

%type_of_feaut --> a 3d vector representing the domain of the featuer
% pass vect_feat --> as a 3 elements long vector representing th dimensions of
% the feauters
% alpha --> 4 element vector of alpha for the total features arousal plane
% alpha2 --> 4 element vector of alpha for the single features arousal plane



fe= {Feaut{2,type_of_feaut(1)}{3,vect_feat(1)},Feaut{2,type_of_feaut(2)}{3,vect_feat(2)},Feaut{2,type_of_feaut(3)}{3,vect_feat(3)}};
colors_1 = ['b','g','y','r'];
% for i=1:3
% fe{i}=normalize(fe{i},'none');
% end

%% single emotions with qualitative estimate
[~ ,~ ,Pass] = xlsread('Votes_choerence.xlsx');
Row_del = length(Pass)-3:length(Pass);
Pass(Row_del,:) = [];
Pass_mat = cell2mat(Pass(2:end,2:end));

titles=["sadness" "relax"  "happyness" "fear"];

figure()
colors_2 = [[205 0 0];[255 193 37];[141 238 238];[105 105 105]]/255;
for i =1:4
    [r{1,i},c{1,i}] = find(Pass_mat(:,i)<=10 & Pass_mat(:,i)>7);
    [r{2,i},c{2,i}] = find(Pass_mat(:,i)<=7 & Pass_mat(:,i)>3);
    [r{3,i},c{3,i}] = find(Pass_mat(:,i)<=3);
    [r{4,i},c{4,i}] = find(isnan(Pass_mat(:,i)));
    
    
    
    subplot(2,2,i)
    for k=1:4
        h(k,1)=plot3(fe{1}(r{k,i},i),fe{2}(r{k,i},i),fe{3}(r{k,i},i),'LineStyle','none' ,'Marker','o','MarkerEdgeColor',colors_2(k,:),'MarkerFaceColor',colors_2(k,:));
        hold on
        p = boundary(fe{1}(r{k,i},i),fe{2}(r{k,i},i),fe{3}(r{k,i},i));
        h(k,2)=trisurf(p,fe{1}(r{k,i},i),fe{2}(r{k,i},i),fe{3}(r{k,i},i),'Facecolor',colors_2(k,:),'FaceAlpha',.5);
    end
    grid on
    legend(h(:,1),{'s','m','n','none'})
    xlabel(strrep(convertCharsToStrings(Feaut{2,type_of_feaut(1)}{1,vect_feat(1)}),'_',' '))
    ylabel(strrep(convertCharsToStrings(Feaut{2,type_of_feaut(2)}{1,vect_feat(2)}),'_',' '))
    zlabel(strrep(convertCharsToStrings(Feaut{2,type_of_feaut(3)}{1,vect_feat(3)}),'_',' '))
    title(titles(i))
    
end



%% total with smn


f2 = figure;
al1=.5;
al2=.5;
al3=.5;
al4=.5;


b1 = uicontrol('Parent',f2,'Style','slider','Position',[80,50,100,23],'value',al1, 'min',0, 'max',1,'BackgroundColor','b');
b2 = uicontrol('Parent',f2,'Style','slider','Position',[80,75,100,23],'value',al2, 'min',0, 'max',1,'BackgroundColor','g');
b3 = uicontrol('Parent',f2,'Style','slider','Position',[80,100,100,23],'value',al3, 'min',0, 'max',1,'BackgroundColor','y');
b4 = uicontrol('Parent',f2,'Style','slider','Position',[80,125,100,23],'value',al4, 'min',0, 'max',1,'BackgroundColor','r');

bgcolor = f2.Color;
bl1 = uicontrol('Parent',f2,'Style','text','Position',[70,20,23,23],'String','0','BackgroundColor',bgcolor);
bl2 = uicontrol('Parent',f2,'Style','text','Position',[165,20,23,23], 'String','1','BackgroundColor',bgcolor);
bl3 = uicontrol('Parent',f2,'Style','text','Position',[50,50,23,23], 'String','s','BackgroundColor',bgcolor);
bl4 = uicontrol('Parent',f2,'Style','text','Position',[50,75,23,23], 'String','r','BackgroundColor',bgcolor);
bl5 = uicontrol('Parent',f2,'Style','text','Position',[50,100,23,23], 'String','h','BackgroundColor',bgcolor);
bl6 = uicontrol('Parent',f2,'Style','text','Position',[50,125,23,23], 'String','f','BackgroundColor',bgcolor);

for i=1:4
    for k=1:4
        m(k,i)=plot3(fe{1}(r{k,i},i),fe{2}(r{k,i},i),fe{3}(r{k,i},i),'LineStyle','none' ,'Marker','o','MarkerEdgeColor',colors_2(k,:),'MarkerFaceColor',colors_2(k,:));
        hold on
    end
    k = boundary(fe{1}(:,i),fe{2}(:,i),fe{3}(:,i));
    tr_2(i)=trisurf(k,fe{1}(:,i),fe{2}(:,i),fe{3}(:,i),'Facecolor',colors_1(i),'FaceAlpha',.5,'EdgeAlpha',1);
    hold on
end
pos=get(gca,'position');  % retrieve the current values
pos(1)=pos(1)+0.05;        % try reducing width 10%
set(gca,'position',pos);  % write the new values

legend(m(:,1),{'s','m','n','none'})
xlabel(strrep(convertCharsToStrings(Feaut{2,type_of_feaut(1)}{1,vect_feat(1)}),'_',' '))
ylabel(strrep(convertCharsToStrings(Feaut{2,type_of_feaut(2)}{1,vect_feat(2)}),'_',' '))
zlabel(strrep(convertCharsToStrings(Feaut{2,type_of_feaut(3)}{1,vect_feat(3)}),'_',' '))
grid on


b1.Callback = @(es,ed) SliderControl_mks(tr_2(1),b1,m(:,1),colors_2); 
b2.Callback = @(es,ed) SliderControl_mks(tr_2(2),b2,m(:,2),colors_2); 
b3.Callback = @(es,ed) SliderControl_mks(tr_2(3),b3,m(:,3),colors_2); 
b4.Callback = @(es,ed) SliderControl_mks(tr_2(4),b4,m(:,4),colors_2); 
end