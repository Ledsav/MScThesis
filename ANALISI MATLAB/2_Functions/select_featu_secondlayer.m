function select_featu_secondlayer(b2,b1,F,figs,tr,ki,ax)
global type
global fea

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
        type=[b1.Value type(2) type(3)];
        fea=[b2.Value fea(2) fea(3)];
        
    elseif ax == 'y'
        for i=1:4
            figs(i).YData = F{2,b1.Value}{3,val+1}(:,i);
            ki{i} = boundary(figs(i).XData',figs(i).YData',figs(i).ZData');
            tr(i).YData = F{2,b1.Value}{3,val+1}(:,i);
            tr(i).Faces = ki{i};
        end
        
        ylabel(strrep(convertCharsToStrings(str{val}),'_',' '))
        type=[ type(1) b1.Value type(3)];
        fea=[ fea(1) b2.Value fea(3)];
    else
        for i=1:4
            figs(i).ZData = F{2,b1.Value}{3,val+1}(:,i);
            ki{i} = boundary(figs(i).XData',figs(i).YData',figs(i).ZData');
            tr(i).ZData = F{2,b1.Value}{3,val+1}(:,i);
            tr(i).Faces = ki{i};
        end
        
        zlabel(strrep(convertCharsToStrings(str{val}),'_',' '))
        type=[ type(1) type(2)  b1.Value];
        fea=[ fea(1) fea(2) b2.Value];
    end
    
    
    
end