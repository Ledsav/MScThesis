function select_featu(b1,b2,F,figs,tr,ki,ax)
global type
global fea

val = b1.Value;
str = b1.String;

if (val == 1 || val == 3 || val == 5 || val == 6)
    b2.Enable="on";
    b2.String = F{2,val}(1,2:end);
    b2.Value=1;
    
else
    
    b2.Enable="off";
    
    if ax == 'x'
        for i=1:4
            figs(i).XData = F{2,val}{3,2}(:,i);
            ki{i} = boundary(figs(i).XData',figs(i).YData',figs(i).ZData');
            tr(i).XData = F{2,val}{3,2}(:,i);
            tr(i).Faces = ki{i};
        end
        
        xlabel(strrep(convertCharsToStrings(str{val}),'_',' '))
        type=[b1.Value type(2) type(3)];

        
    elseif ax == 'y'
        for i=1:4
            figs(i).YData = F{2,val}{3,2}(:,i);
            ki{i} = boundary(figs(i).XData',figs(i).YData',figs(i).ZData');
            tr(i).YData = F{2,val}{3,2}(:,i);
            tr(i).Faces = ki{i};
        end
        
        ylabel(strrep(convertCharsToStrings(str{val}),'_',' '))
        type=[ type(1) b1.Value type(3)];

    else
        for i=1:4
            figs(i).ZData = F{2,val}{3,2}(:,i);
            ki{i} = boundary(figs(i).XData',figs(i).YData',figs(i).ZData');
            tr(i).ZData = F{2,val}{3,2}(:,i);
            tr(i).Faces = ki{i};
        end
        
        zlabel(strrep(convertCharsToStrings(str{val}),'_',' '))
        type=[ type(1) type(2)  b1.Value];

    end
    
    
end





end
