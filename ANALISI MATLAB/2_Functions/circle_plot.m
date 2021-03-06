function h = circle_plot(x,y,r,col)
hold on
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h = plot(xunit, yunit,col);
h.Annotation.LegendInformation.IconDisplayStyle = 'off';

    
