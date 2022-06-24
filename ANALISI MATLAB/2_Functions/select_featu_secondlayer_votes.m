function select_featu_secondlayer_votes(b2,b1,F,r,c,m,tr,ki,ax)
val = b2.Value;
str = b2.String;


if str{val}~="select feature"
    
    if ax == 'x'
        for i=1:4
            figs(i).XData = F{2,b1.Value}{3,val+1}(:,i);
            ki{i} = boundary(figs(i).XData',figs(i).YData',figs(i).ZData');
            tr(i).XData = F{2,b1.Value}{3,val+1}(:,i);
            tr(i).Faces = ki{i};
        end
        
        xlabel(strrep(convertCharsToStrings(str{val}),'_',' '))
        
    elseif ax == 'y'
        for i=1:4
            figs(i).YData = F{2,b1.Value}{3,val}(:,i);
            ki{i} = boundary(figs(i).XData',figs(i).YData',figs(i).ZData');
            tr(i).YData = F{2,b1.Value}{3,val}(:,i);
            tr(i).Faces = ki{i};
        end
        
        ylabel(strrep(convertCharsToStrings(str{val}),'_',' '))
        
    else
        for i=1:4
            figs(i).ZData = F{2,b1.Value}{3,val}(:,i);
            ki{i} = boundary(figs(i).XData',figs(i).YData',figs(i).ZData');
            tr(i).ZData = F{2,b1.Value}{3,val}(:,i);
            tr(i).Faces = ki{i};
        end
        
        zlabel(strrep(convertCharsToStrings(str{val}),'_',' '))
    end
    
    
end