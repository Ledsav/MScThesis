function visualize_statisticplot3(Feaut,type_of_feaut,vect_feat)

%type_of_feaut --> a 3d vector representing the domain of the featuer
% pass vect_feat --> as a 3 elements long vector representing th dimensions of
% the feauters
% alpha --> 4 element vector of alpha for the total features arousal plane
% alpha2 --> 4 element vector of alpha for the single features arousal plane



fe= {Feaut{2,type_of_feaut(1)}{3,vect_feat(1)},Feaut{2,type_of_feaut(2)}{3,vect_feat(2)},Feaut{2,type_of_feaut(3)}{3,vect_feat(3)}};

% for i=1:3
% fe{i}=normalize(fe{i},'none');
% end
%% Total figure
colors_1 = ['b','g','y','r'];
f1 = figure;
al1=.5;
al2=.5;
al3=.5;
al4=.5;

b1 = uicontrol('Parent',f1,'Style','slider','Position',[80,50,100,23],'value',al1, 'min',0, 'max',1,'BackgroundColor','b');
b2 = uicontrol('Parent',f1,'Style','slider','Position',[80,75,100,23],'value',al2, 'min',0, 'max',1,'BackgroundColor','g');
b3 = uicontrol('Parent',f1,'Style','slider','Position',[80,100,100,23],'value',al3, 'min',0, 'max',1,'BackgroundColor','y');
b4 = uicontrol('Parent',f1,'Style','slider','Position',[80,125,100,23],'value',al4, 'min',0, 'max',1,'BackgroundColor','r');
b5 = uicontrol(f1,'Style','popupmenu','Position',[80,300,100,23],'String',Feaut(1,:),'Value',1);
b6 = uicontrol(f1,'Style','popupmenu','Position',[80,275,100,23],'String',{'select feature'},'Enable','off','Value',1);
b7 = uicontrol(f1,'Style','popupmenu','Position',[80,400,100,23],'String',Feaut(1,:),'Value',1);
b8 = uicontrol(f1,'Style','popupmenu','Position',[80,375,100,23],'String',{'select feature'},'Enable','off','Value',1);
b9 = uicontrol(f1,'Style','popupmenu','Position',[80,500,100,23],'String',Feaut(1,:),'Value',1);
b10 = uicontrol(f1,'Style','popupmenu','Position',[80,475,100,23],'String',{'select feature'},'Enable','off','Value',1);


bgcolor = f1.Color;
bl1 = uicontrol('Parent',f1,'Style','text','Position',[50,45,23,23],'String','0','BackgroundColor',bgcolor);
bl2 = uicontrol('Parent',f1,'Style','text','Position',[180,45,23,23], 'String','1','BackgroundColor',bgcolor);

vr1 = uicontrol('Parent',f1,'Style','text','Position',[50,300,23,23],'String','x','BackgroundColor',bgcolor);
vr2 = uicontrol('Parent',f1,'Style','text','Position',[50,400,23,23],'String','y','BackgroundColor',bgcolor);
vr3 = uicontrol('Parent',f1,'Style','text','Position',[50,500,23,23],'String','z','BackgroundColor',bgcolor);


for i=1:4
    figs(i) = plot3(fe{1}(:,i),fe{2}(:,i),fe{3}(:,i),'o');
    hold on
    ki{i} = boundary(fe{1}(:,i),fe{2}(:,i),fe{3}(:,i));
    tr(i) = trisurf(ki{i},fe{1}(:,i),fe{2}(:,i),fe{3}(:,i),'Facecolor',colors_1(i),'FaceAlpha',.5,'EdgeAlpha',1);
    hold on
end
pos=get(gca,'position');  % retrieve the current values
pos(1)=pos(1)+0.05;        % try reducing width 10%
set(gca,'position',pos);  % write the new values

xlabel(strrep(convertCharsToStrings(Feaut{2,type_of_feaut(1)}{1,vect_feat(1)}),'_',' '))
ylabel(strrep(convertCharsToStrings(Feaut{2,type_of_feaut(2)}{1,vect_feat(2)}),'_',' '))
zlabel(strrep(convertCharsToStrings(Feaut{2,type_of_feaut(3)}{1,vect_feat(3)}),'_',' '))
grid on

b1.Callback = @(es,ed) SliderControl(tr(1),b1); 
b2.Callback = @(es,ed) SliderControl(tr(2),b2); 
b3.Callback = @(es,ed) SliderControl(tr(3),b3); 
b4.Callback = @(es,ed) SliderControl(tr(4),b4); 
b5.Callback = @(es,ed) select_featu(b5,b6,Feaut,figs,tr,ki,'x');
b6.Callback = @(es,ed) select_featu_secondlayer(b6,b5,Feaut,figs,tr,ki,'x');
b7.Callback = @(es,ed) select_featu(b7,b8,Feaut,figs,tr,ki,'y');
b8.Callback = @(es,ed) select_featu_secondlayer(b8,b7,Feaut,figs,tr,ki,'y');
b9.Callback = @(es,ed) select_featu(b9,b10,Feaut,figs,tr,ki,'z');
b10.Callback = @(es,ed) select_featu_secondlayer(b10,b9,Feaut,figs,tr,ki,'z');

end