function SliderControl_mks(fig,b,mk,colors)

fig.FaceAlpha = b.Value;
fig.EdgeAlpha = b.Value;

if b.Value == 0
    for i=1:4
        mk(i).MarkerFaceColor = 'none';
        mk(i).MarkerEdgeColor = 'none';
    end
    
else
    for i=1:4
        mk(i).MarkerFaceColor = colors(i,:);
        mk(i).MarkerEdgeColor = colors(i,:);
    end
end


end