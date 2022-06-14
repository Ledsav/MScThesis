function plot_boxplot_and_stats(Features,path)

for i=2:size(Features,2)
    figure(1)
    boxplot(Features{3,i},'labels',{'s','r','h','f'})
    name=strrep(convertCharsToStrings(Features{1,i}),'_',' ');
    title(strcat('boxplot .',name));
    
    if Features{4,i}<0.05
        saveas(gcf,strcat(path,'\good\',name,'box'),'fig')
        saveas(gcf,strcat(path,'\good\',name,'box'),'png')
    else
        saveas(gcf,strcat(path,'\bad\',name),'fig')
        saveas(gcf,strcat(path,'\bad\',name,'box'),'png')
    end
    close all
    
    figure()
    multcompare(Features{5,i},'CType','hsd');
    title(strcat('multcompare .',name))
    
    if Features{4,i}<0.05
        saveas(gcf,strcat(path,'\good\',name,'mult'),'fig')
        saveas(gcf,strcat(path,'\good\',name,'mult'),'png')
    else
        saveas(gcf,strcat(path,'\bad\',name,'mult'),'fig')
        saveas(gcf,strcat(path,'\bad\',name,'mult'),'png')
    end
    close all
end



end