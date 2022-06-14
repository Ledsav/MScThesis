function visualize_statisticplot3(Feaut,type_of_feaut,vect_feat,alpha)

%type_of_feaut --> a 3d vector representing the domain of the featuer
% pass vect_feat --> as a 3 elements long vector representing th dimensions of
% the feauters
% alpha 4 element vector of apha
 
colors = ['b','g','y','r'];
fe= {Feaut{2,type_of_feaut(1)}{3,vect_feat(1)},Feaut{2,type_of_feaut(2)}{3,vect_feat(2)},Feaut{2,type_of_feaut(3)}{3,vect_feat(3)}};

% for i=1:3
% fe{i}=normalize(fe{i},'none');
% end


for i=1:4
plot3(fe{1}(:,i),fe{2}(:,i),fe{3}(:,i),'o')
hold on
k = boundary(fe{1}(:,i),fe{2}(:,i),fe{3}(:,i));
trisurf(k,fe{1}(:,i),fe{2}(:,i),fe{3}(:,i),'Facecolor',colors(i),'FaceAlpha',alpha(i));
hold on
end
xlabel(strrep(convertCharsToStrings(Feaut{2,type_of_feaut(1)}{1,vect_feat(1)}),'_',' '))
ylabel(strrep(convertCharsToStrings(Feaut{2,type_of_feaut(2)}{1,vect_feat(2)}),'_',' '))
zlabel(strrep(convertCharsToStrings(Feaut{2,type_of_feaut(3)}{1,vect_feat(3)}),'_',' '))
title('GSR')
grid on


end 