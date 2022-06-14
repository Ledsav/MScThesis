function [K,clusters] = Cluster_Passports(labels,Title,Mat,x,y,z,type,k,norm,bound)
%labels are the name of the subjects
%Title are the names of the featuers
%Mat is the featuers vs observation matrix (columns = features)
%x,y,z are 3 dimension
%type = link if ypu want to use linkage as cluster method
%type = km if ypu want to use kmeans as cluster method
%k = number of maximum clusters
%norm ='range' if you want minmax normalization, norm ='zcore' if you want zindex norm or 0 otherwise

ABS = [Mat(:,x),Mat(:,y),Mat(:,z)];
clust = zeros(size(Mat,1),k);

if class(norm) == "char"
    %ABS = (ABS-min(ABS))./(max(ABS)-min(ABS)) ;
    ABS = normalize(ABS,norm);
    
end

if type == "dend"
    for i=1:k
        Z = linkage(ABS,'ward');
        %dendrogram(Z)
        clust(:,i)= cluster(Z,'Maxclust',i);
    end
    
else
    for i=1:k
        clust(:,i) = kmeans(ABS,i,'emptyaction','singleton','replicate',5);
    end
    
end


%color

va = evalclusters(ABS,clust,'CalinskiHarabasz');
figure()
scatter3(ABS(:,1),ABS(:,2),ABS(:,3),50,clust(:,va.OptimalK),'filled','LineWidth',10)
initialColorOrder = get(gca,'ColorOrder');
xlabel(Title(x),'FontWeight' ,'bold')
ylabel(Title(y),'FontWeight' ,'bold')
zlabel(Title(z),'FontWeight' ,'bold')
text(ABS(:,1),ABS(:,2),ABS(:,3),labels,'FontSize',5,'VerticalAlignment','bottom','HorizontalAlignment','right')
hold on

K=va.OptimalK;
clusters = clust(:,va.OptimalK);
p=colormap;
if bound==1
    un = unique(clusters);
    for i=1:length(un)
        k = boundary(ABS((clusters == un(i)),1),ABS((clusters == un(i)),2),ABS((clusters == un(i)),3));
        h(i,1)=trisurf(k,ABS((clusters == un(i)),1),ABS((clusters == un(i)),2),ABS((clusters == un(i)),3),'FaceAlpha',0.1,'FaceColor',initialColorOrder(i,:));
        hold on
    end
    
end


end

