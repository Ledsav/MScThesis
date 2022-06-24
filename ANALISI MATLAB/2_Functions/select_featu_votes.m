function select_featu_votes(b1,b2,F,r,m,tr,ki,ax)
val = b1.Value;
str = b1.String;

ro=[];

if (val == 1 || val == 3 || val == 5 || val == 6)
    b2.Enable="on";
    b2.String = F{2,val}(1,2:end);
    
else
    
    b2.Enable="off";
    
    if ax == 'x'
        

        
        for i=1:4
            for k=1:4
                m(k,i).XData = F{2,val}{3,2}(r{k,i},i);
                hold on
                ro=[ro;r{k,1}];
            end
           [B,I]=sort(ro);
           
           y=[m(:,i).YData]';
           z=[m(:,i).ZData]';
           
            ki{i} = boundary(F{2,val}{3,2}(:,i),y(I,1),z(I,1));
            tr(i).XData = F{2,val}{3,2}(:,i);
            tr(i).Faces = ki{i};
            
            ro=[];
        end
        
        xlabel(strrep(convertCharsToStrings(str{val}),'_',' '))
        
    elseif ax == 'y'
        for i=1:4
            figs(i).YData = F{2,val}{3,2}(:,i);
            ki{i} = boundary(figs(i).XData',figs(i).YData',figs(i).ZData');
            tr(i).YData = F{2,val}{3,2}(:,i);
            tr(i).Faces = ki{i};
        end
        
        ylabel(strrep(convertCharsToStrings(str{val}),'_',' '))
    else
        for i=1:4
            figs(i).ZData = F{2,val}{3,2}(:,i);
            ki{i} = boundary(figs(i).XData',figs(i).YData',figs(i).ZData');
            tr(i).ZData = F{2,val}{3,2}(:,i);
            tr(i).Faces = ki{i};
        end
        
        zlabel(strrep(convertCharsToStrings(str{val}),'_',' '))
    end
    
    
end
end
