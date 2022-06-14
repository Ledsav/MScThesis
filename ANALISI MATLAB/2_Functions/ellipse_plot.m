function h = ellipse_plot(x,y,r1,r2,col)
hold on
th = 0:pi/50:2*pi;
xunit = r1 * cos(th) + x;
yunit = r2 * sin(th) + y;
h = plot(xunit, yunit,col);
h.Annotation.LegendInformation.IconDisplayStyle = 'off';
end