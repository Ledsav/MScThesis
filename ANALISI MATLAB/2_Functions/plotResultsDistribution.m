function []=plotResultsDistribution(MAT_PRE,MAT_POST,choice)
% put m as third entry if you want to plot the mean
% put s as third entry if you want to plot single values



if choice == 'm'
% ----------------------------------- MEAN ROW --------------------------------------       
    % plot B1.1
    figure()

    subplot(1,2,1)
    plot(mean(MAT_PRE(:,1)),mean(MAT_PRE(:,2)),'bo')
    hold on 
    plot(mean(MAT_POST(:,1)),mean(MAT_POST(:,2)),'ro')
    axis([-1 1    -1 1])
    hold on 
    plot(-1:1,[0 0 0 ],'k')
    hold on 
    plot([0 0 0],-1:1,'k')
    legend('26 subjects pre','31 subjects post')
    title('Image baseline 1.1')
    xlabel('Valence')
    ylabel('Arousal')

    subplot(1,2,2)
    plot(mean(MAT_PRE(:,17)),mean(MAT_PRE(:,18)),'bo')
    hold on 
    plot(mean(MAT_POST(:,17)),mean(MAT_POST(:,18)),'ro')
    axis([-1 1    -1 1])
    hold on 
    plot(-1:1,[0 0 0 ],'k')
    hold on 
    plot([0 0 0],-1:1,'k')
    legend('pre','post')
    title('Audio baseline')
    xlabel('Valence')
    ylabel('Arousal')

    % plot S
    figure()
    subplot(1,2,1)
    plot(mean(MAT_PRE(:,3)),mean(MAT_PRE(:,4)),'bo')
    hold on 
    plot(mean(MAT_POST(:,3)),mean(MAT_POST(:,4)),'ro')
    axis([-1 1    -1 1])
    hold on 
    plot(-1:1,[0 0 0 ],'k')
    hold on 
    plot([0 0 0],-1:1,'k')
    legend('pre','post')
    title('Image sadness')
    xlabel('Valence')
    ylabel('Arousal')

    subplot(1,2,2)
    plot(mean(MAT_PRE(:,19)),mean(MAT_PRE(:,20)),'bo')
    hold on 
    plot(mean(MAT_POST(:,19)),mean(MAT_POST(:,20)),'ro')
    axis([-1 1    -1 1])
    hold on 
    plot(-1:1,[0 0 0 ],'k')
    hold on 
    plot([0 0 0],-1:1,'k')
    legend('pre','post')
    title('Audio sadness')
    xlabel('Valence')
    ylabel('Arousal')

    % plot B2.2
    figure()
    plot(mean(MAT_PRE(:,5)),mean(MAT_PRE(:,6)),'bo')
    hold on 
    plot(mean(MAT_POST(:,5)),mean(MAT_POST(:,6)),'ro')
    axis([-1 1    -1 1])
    hold on 
    plot(-1:1,[0 0 0 ],'k')
    hold on 
    plot([0 0 0],-1:1,'k')
    legend('pre','post')
    title('Image baseline 2.2')
    xlabel('Valence')
    ylabel('Arousal')


    % plot R
    figure()
    subplot(1,2,1)
    plot(mean(MAT_PRE(:,7)),mean(MAT_PRE(:,8)),'bo')
    hold on 
    plot(mean(MAT_POST(:,7)),mean(MAT_POST(:,8)),'ro')
    axis([-1 1    -1 1])
    hold on 
    plot(-1:1,[0 0 0 ],'k')
    hold on 
    plot([0 0 0],-1:1,'k')
    legend('pre','post')
    title('Image Relax')
    xlabel('Valence')
    ylabel('Arousal')

    subplot(1,2,2)
    plot(mean(MAT_PRE(:,21)),mean(MAT_PRE(:,22)),'bo')
    hold on 
    plot(mean(MAT_POST(:,21)),mean(MAT_POST(:,22)),'ro')
    axis([-1 1    -1 1])
    hold on 
    plot(-1:1,[0 0 0 ],'k')
    hold on 
    plot([0 0 0],-1:1,'k')
    legend('pre','post')
    title('Audio Relax')
    xlabel('Valence')
    ylabel('Arousal')

    % plot B1.2
    figure()
    plot(mean(MAT_PRE(:,9)),mean(MAT_PRE(:,10)),'bo')
    hold on 
    plot(mean(MAT_POST(:,9)),mean(MAT_POST(:,10)),'ro')
    axis([-1 1    -1 1])
    hold on 
    plot(-1:1,[0 0 0 ],'k')
    hold on 
    plot([0 0 0],-1:1,'k')
    legend('pre','post')
    title('Image B1.2')
    xlabel('Valence')
    ylabel('Arousal')
    % plot H
    figure()
    subplot(1,2,1)
    plot(mean(MAT_PRE(:,11)),mean(MAT_PRE(:,12)),'bo')
    hold on 
    plot(mean(MAT_POST(:,11)),mean(MAT_POST(:,12)),'ro')
    axis([-1 1    -1 1])
    hold on 
    plot(-1:1,[0 0 0 ],'k')
    hold on 
    plot([0 0 0],-1:1,'k')
    legend('pre','post')
    title('Image Happyness')
    xlabel('Valence')
    ylabel('Arousal')

    subplot(1,2,2)
    plot(mean(MAT_PRE(:,23)),mean(MAT_PRE(:,24)),'bo')
    hold on 
    plot(mean(MAT_POST(:,23)),mean(MAT_POST(:,24)),'ro')
    axis([-1 1    -1 1])
    hold on 
    plot(-1:1,[0 0 0 ],'k')
    hold on 
    plot([0 0 0],-1:1,'k')
    legend('pre','post')
    title('Audio Happyness')
    xlabel('Valence')
    ylabel('Arousal')

    % plot B2.1

    figure()
    plot(mean(MAT_PRE(:,13)),mean(MAT_PRE(:,14)),'bo')
    hold on 
    plot(mean(MAT_POST(:,13)),mean(MAT_POST(:,14)),'ro')
    axis([-1 1    -1 1])
    hold on 
    plot(-1:1,[0 0 0 ],'k')
    hold on 
    plot([0 0 0],-1:1,'k')
    legend('pre','post')
    title('Image B2.1')
    xlabel('Valence')
    ylabel('Arousal')
    % plot F
    figure()
    subplot(1,2,1)
    plot(mean(MAT_PRE(:,15)),mean(MAT_PRE(:,16)),'bo')
    hold on 
    plot(mean(MAT_POST(:,15)),mean(MAT_POST(:,16)),'ro')
    axis([-1 1    -1 1])
    hold on 
    plot(-1:1,[0 0 0 ],'k')
    hold on 
    plot([0 0 0],-1:1,'k')
    legend('pre','post')
    title('Image Fear')
    xlabel('Valence')
    ylabel('Arousal')

    subplot(1,2,2)
    plot(mean(MAT_PRE(:,25)),mean(MAT_PRE(:,26)),'bo')
    hold on 
    plot(mean(MAT_POST(:,25)),mean(MAT_POST(:,26)),'ro')
    axis([-1 1    -1 1])
    hold on 
    plot(-1:1,[0 0 0 ],'k')
    hold on 
    plot([0 0 0],-1:1,'k')
    legend('pre','post')
    title('Audio Fear')
    xlabel('Valence')
    ylabel('Arousal')

elseif choice =='s' 
% ----------------------------------- ALL ROW --------------------------------------       
    % plot B1.1
    figure()

    subplot(1,2,1)
    plot(MAT_PRE(:,1),MAT_PRE(:,2),'bo')
    hold on 
    plot(MAT_POST(:,1),MAT_POST(:,2),'ro')
    axis([-1 1    -1 1])
    hold on 
    plot(-1:1,[0 0 0 ],'k')
    hold on 
    plot([0 0 0],-1:1,'k')
    legend('pre','post')
    title('Image baseline 1.1')
    xlabel('Valence')
    ylabel('Arousal')

    subplot(1,2,2)
    plot(MAT_PRE(:,17),MAT_PRE(:,18),'bo')
    hold on 
    plot(MAT_POST(:,17),MAT_POST(:,18),'ro')
    axis([-1 1    -1 1])
    hold on 
    plot(-1:1,[0 0 0 ],'k')
    hold on 
    plot([0 0 0],-1:1,'k')
    legend('pre','post')
    title('Audio baseline')
    xlabel('Valence')
    ylabel('Arousal')

    % plot S
    figure()
    subplot(1,2,1)
    plot(MAT_PRE(:,3),MAT_PRE(:,4),'bo')
    hold on 
    plot(MAT_POST(:,3),MAT_POST(:,4),'ro')
    axis([-1 1    -1 1])
    hold on 
    plot(-1:1,[0 0 0 ],'k')
    hold on 
    plot([0 0 0],-1:1,'k')
    legend('pre','post')
    title('Image sadness')
    xlabel('Valence')
    ylabel('Arousal')

    subplot(1,2,2)
    plot(MAT_PRE(:,19),MAT_PRE(:,20),'bo')
    hold on 
    plot(MAT_POST(:,19),MAT_POST(:,20),'ro')
    axis([-1 1    -1 1])
    hold on 
    plot(-1:1,[0 0 0 ],'k')
    hold on 
    plot([0 0 0],-1:1,'k')
    legend('pre','post')
    title('Audio sadness')
    xlabel('Valence')
    ylabel('Arousal')

    % plot B2.2
    figure()
    plot(MAT_PRE(:,5),MAT_PRE(:,6),'bo')
    hold on 
    plot(MAT_POST(:,5),MAT_POST(:,6),'ro')
    axis([-1 1    -1 1])
    hold on 
    plot(-1:1,[0 0 0 ],'k')
    hold on 
    plot([0 0 0],-1:1,'k')
    legend('pre','post')
    title('Image baseline 2.2')
    xlabel('Valence')
    ylabel('Arousal')


    % plot R
    figure()
    subplot(1,2,1)
    plot(MAT_PRE(:,7),MAT_PRE(:,8),'bo')
    hold on 
    plot(MAT_POST(:,7),MAT_POST(:,8),'ro')
    axis([-1 1    -1 1])
    hold on 
    plot(-1:1,[0 0 0 ],'k')
    hold on 
    plot([0 0 0],-1:1,'k')
    legend('pre','post')
    title('Image Relax')
    xlabel('Valence')
    ylabel('Arousal')

    subplot(1,2,2)
    plot(MAT_PRE(:,21),MAT_PRE(:,22),'bo')
    hold on 
    plot(MAT_POST(:,21),MAT_POST(:,22),'ro')
    axis([-1 1    -1 1])
    hold on 
    plot(-1:1,[0 0 0 ],'k')
    hold on 
    plot([0 0 0],-1:1,'k')
    legend('pre','post')
    title('Audio Relax')
    xlabel('Valence')
    ylabel('Arousal')

    % plot B1.2
    figure()
    plot(MAT_PRE(:,9),MAT_PRE(:,10),'bo')
    hold on 
    plot(MAT_POST(:,9),MAT_POST(:,10),'ro')
    axis([-1 1    -1 1])
    hold on 
    plot(-1:1,[0 0 0 ],'k')
    hold on 
    plot([0 0 0],-1:1,'k')
    legend('pre','post')
    title('Image B1.2')
    xlabel('Valence')
    ylabel('Arousal')
    % plot H
    figure()
    subplot(1,2,1)
    plot(MAT_PRE(:,11),MAT_PRE(:,12),'bo')
    hold on 
    plot(MAT_POST(:,11),MAT_POST(:,12),'ro')
    axis([-1 1    -1 1])
    hold on 
    plot(-1:1,[0 0 0 ],'k')
    hold on 
    plot([0 0 0],-1:1,'k')
    legend('pre','post')
    title('Image Happyness')
    xlabel('Valence')
    ylabel('Arousal')

    subplot(1,2,2)
    plot(MAT_PRE(:,23),MAT_PRE(:,24),'bo')
    hold on 
    plot(MAT_POST(:,23),MAT_POST(:,24),'ro')
    axis([-1 1    -1 1])
    hold on 
    plot(-1:1,[0 0 0 ],'k')
    hold on 
    plot([0 0 0],-1:1,'k')
    legend('pre','post')
    title('Audio Happyness')
    xlabel('Valence')
    ylabel('Arousal')

    % plot B2.1

    figure()
    plot(MAT_PRE(:,13),MAT_PRE(:,14),'bo')
    hold on 
    plot(MAT_POST(:,13),MAT_POST(:,14),'ro')
    axis([-1 1    -1 1])
    hold on 
    plot(-1:1,[0 0 0 ],'k')
    hold on 
    plot([0 0 0],-1:1,'k')
    legend('pre','post')
    title('Image B2.1')
    xlabel('Valence')
    ylabel('Arousal')
    % plot F
    figure()
    subplot(1,2,1)
    plot(MAT_PRE(:,15),MAT_PRE(:,16),'bo')
    hold on 
    plot(MAT_POST(:,15),MAT_POST(:,16),'ro')
    axis([-1 1    -1 1])
    hold on 
    plot(-1:1,[0 0 0 ],'k')
    hold on 
    plot([0 0 0],-1:1,'k')
    legend('pre','post')
    title('Image Fear')
    xlabel('Valence')
    ylabel('Arousal')

    subplot(1,2,2)
    plot(MAT_PRE(:,25),MAT_PRE(:,26),'bo')
    hold on 
    plot(MAT_POST(:,25),MAT_POST(:,26),'ro')
    axis([-1 1    -1 1])
    hold on 
    plot(-1:1,[0 0 0 ],'k')
    hold on 
    plot([0 0 0],-1:1,'k')
    legend('pre','post')
    title('Audio Fear')
    xlabel('Valence')
    ylabel('Arousal')
    
    
elseif choice == 'e'
    % caso con ellissi-----------------------------------
    Mean_PRE = mean(MAT_PRE);
    Mean_POST = mean(MAT_POST);   
    %std on x and y normalized over the maximum in all the tests
    STD_PRE_norm= std(MAT_PRE);
    STD_POST_norm = std(MAT_POST);


 % plot B1.1
    figure()

    subplot(1,2,1)
    plot((Mean_PRE(1)),(Mean_PRE(2)),'bo')
    hold on 
    plot((Mean_POST(1)),(Mean_POST(2)),'ro')
    legend('26 subjects pre','31 subjects post')
    ellipse_plot(Mean_PRE(1),Mean_PRE(2),STD_PRE_norm(1),STD_PRE_norm(2),'b')
    ellipse_plot(Mean_POST(1),Mean_POST(2),STD_POST_norm(1),STD_POST_norm(2),'r')
    axis([-1 1    -1 1])
    hold on 
    a=plot(-1:1,[0 0 0 ],'k');
    hold on 
    b=plot([0 0 0],-1:1,'k');
    hold off
    title('Image baseline 1.1')
    xlabel('Valence')
    ylabel('Arousal')
    axis('square')
    a.Annotation.LegendInformation.IconDisplayStyle = 'off';
    b.Annotation.LegendInformation.IconDisplayStyle = 'off';
   

    subplot(1,2,2)
    plot((Mean_PRE(17)),(Mean_PRE(18)),'bo')
    hold on 
    plot((Mean_POST(17)),(Mean_POST(18)),'ro')
    legend('26 subjects pre','31 subjects post')
    ellipse_plot(Mean_PRE(17),Mean_PRE(18),STD_PRE_norm(17),STD_PRE_norm(18),'b')
    ellipse_plot(Mean_POST(17),Mean_POST(18),STD_POST_norm(17),STD_POST_norm(18),'r')
    axis([-1 1    -1 1])
    hold on 
    a=plot(-1:1,[0 0 0 ],'k');
    hold on 
    b=plot([0 0 0],-1:1,'k');
    hold off
    title('Audio baseline')
    xlabel('Valence')
    ylabel('Arousal')
    axis('square')
    a.Annotation.LegendInformation.IconDisplayStyle = 'off';
    b.Annotation.LegendInformation.IconDisplayStyle = 'off';
    
    % plot S
    figure()

    subplot(1,2,1)
    plot((Mean_PRE(3)),(Mean_PRE(4)),'bo')
    hold on 
    plot((Mean_POST(3)),(Mean_POST(4)),'ro')
    legend('26 subjects pre','31 subjects post')
    ellipse_plot(Mean_PRE(3),Mean_PRE(4),STD_PRE_norm(3),STD_PRE_norm(4),'b')
    ellipse_plot(Mean_POST(3),Mean_POST(4),STD_POST_norm(3),STD_POST_norm(4),'r')
    axis([-1 1    -1 1])
    hold on 
    a=plot(-1:1,[0 0 0 ],'k');
    hold on 
    b=plot([0 0 0],-1:1,'k');
    hold off
    title('Image Sadnenss')
    xlabel('Valence')
    ylabel('Arousal')
    axis('square')
    a.Annotation.LegendInformation.IconDisplayStyle = 'off';
    b.Annotation.LegendInformation.IconDisplayStyle = 'off';
   

    subplot(1,2,2)
    plot((Mean_PRE(19)),(Mean_PRE(20)),'bo')
    hold on 
    plot((Mean_POST(19)),(Mean_POST(20)),'ro')
    legend('26 subjects pre','31 subjects post')
    ellipse_plot(Mean_PRE(19),Mean_PRE(20),STD_PRE_norm(19),STD_PRE_norm(20),'b')
    ellipse_plot(Mean_POST(19),Mean_POST(20),STD_POST_norm(19),STD_POST_norm(20),'r')
    axis([-1 1    -1 1])
    hold on 
    a=plot(-1:1,[0 0 0 ],'k');
    hold on 
    b=plot([0 0 0],-1:1,'k');
    hold off
    title('Audio Sadness')
    xlabel('Valence')
    ylabel('Arousal')
    axis('square')
    a.Annotation.LegendInformation.IconDisplayStyle = 'off';
    b.Annotation.LegendInformation.IconDisplayStyle = 'off';
    
    
    % plot baseline 2.2
    figure()
    
    plot((Mean_PRE(5)),(Mean_PRE(6)),'bo')
    hold on 
    plot((Mean_POST(5)),(Mean_POST(6)),'ro')
    legend('26 subjects pre','31 subjects post')
    ellipse_plot(Mean_PRE(5),Mean_PRE(6),STD_PRE_norm(5),STD_PRE_norm(6),'b')
    ellipse_plot(Mean_POST(5),Mean_POST(6),STD_POST_norm(5),STD_POST_norm(6),'r')
    axis([-1 1    -1 1])
    hold on 
    a=plot(-1:1,[0 0 0 ],'k');
    hold on 
    b=plot([0 0 0],-1:1,'k');
    hold off
    title('Image baseline 2.2')
    xlabel('Valence')
    ylabel('Arousal')
    axis('square')
    a.Annotation.LegendInformation.IconDisplayStyle = 'off';
    b.Annotation.LegendInformation.IconDisplayStyle = 'off';
    
    
    % plot R
    figure()

    subplot(1,2,1)
    plot((Mean_PRE(7)),(Mean_PRE(8)),'bo')
    hold on 
    plot((Mean_POST(7)),(Mean_POST(8)),'ro')
    legend('26 subjects pre','31 subjects post')
    ellipse_plot(Mean_PRE(7),Mean_PRE(8),STD_PRE_norm(7),STD_PRE_norm(8),'b')
    ellipse_plot(Mean_POST(7),Mean_POST(8),STD_POST_norm(7),STD_POST_norm(8),'r')
    axis([-1 1    -1 1])
    hold on 
    a=plot(-1:1,[0 0 0 ],'k');
    hold on 
    b=plot([0 0 0],-1:1,'k');
    hold off
    title('Image Relax')
    xlabel('Valence')
    ylabel('Arousal')
    axis('square')
    a.Annotation.LegendInformation.IconDisplayStyle = 'off';
    b.Annotation.LegendInformation.IconDisplayStyle = 'off';
   

    subplot(1,2,2)
    plot((Mean_PRE(21)),(Mean_PRE(22)),'bo')
    hold on 
    plot((Mean_POST(21)),(Mean_POST(22)),'ro')
    legend('26 subjects pre','31 subjects post')
    ellipse_plot(Mean_PRE(21),Mean_PRE(22),STD_PRE_norm(21),STD_PRE_norm(22),'b')
    ellipse_plot(Mean_POST(21),Mean_POST(22),STD_POST_norm(21),STD_POST_norm(22),'r')
    axis([-1 1    -1 1])
    hold on 
    a=plot(-1:1,[0 0 0 ],'k');
    hold on 
    b=plot([0 0 0],-1:1,'k');
    hold off
    title('Audio Relax')
    xlabel('Valence')
    ylabel('Arousal')
    axis('square')
    a.Annotation.LegendInformation.IconDisplayStyle = 'off';
    b.Annotation.LegendInformation.IconDisplayStyle = 'off';
    
    % plot baseline 1.2
    figure()
    
    plot((Mean_PRE(9)),(Mean_PRE(10)),'bo')
    hold on 
    plot((Mean_POST(9)),(Mean_POST(10)),'ro')
    legend('26 subjects pre','31 subjects post')
    ellipse_plot(Mean_PRE(9),Mean_PRE(10),STD_PRE_norm(9),STD_PRE_norm(10),'b')
    ellipse_plot(Mean_POST(9),Mean_POST(10),STD_POST_norm(9),STD_POST_norm(10),'r')
    axis([-1 1    -1 1])
    hold on 
    a=plot(-1:1,[0 0 0 ],'k');
    hold on 
    b=plot([0 0 0],-1:1,'k');
    hold off
    title('Image baseline 1.2')
    xlabel('Valence')
    ylabel('Arousal')
    axis('square')
    a.Annotation.LegendInformation.IconDisplayStyle = 'off';
    b.Annotation.LegendInformation.IconDisplayStyle = 'off';
        
    % plot H
    figure()

    subplot(1,2,1)
    plot((Mean_PRE(11)),(Mean_PRE(12)),'bo')
    hold on 
    plot((Mean_POST(11)),(Mean_POST(12)),'ro')
    legend('26 subjects pre','31 subjects post')
    ellipse_plot(Mean_PRE(11),Mean_PRE(12),STD_PRE_norm(11),STD_PRE_norm(12),'b')
    ellipse_plot(Mean_POST(11),Mean_POST(12),STD_POST_norm(11),STD_POST_norm(12),'r')
    axis([-1 1    -1 1])
    hold on 
    a=plot(-1:1,[0 0 0 ],'k');
    hold on 
    b=plot([0 0 0],-1:1,'k');
    hold off
    title('Image Happyness')
    xlabel('Valence')
    ylabel('Arousal')
    axis('square')
    a.Annotation.LegendInformation.IconDisplayStyle = 'off';
    b.Annotation.LegendInformation.IconDisplayStyle = 'off';
   

    subplot(1,2,2)
    plot((Mean_PRE(23)),(Mean_PRE(24)),'bo')
    hold on 
    plot((Mean_POST(23)),(Mean_POST(24)),'ro')
    legend('26 subjects pre','31 subjects post')
    ellipse_plot(Mean_PRE(23),Mean_PRE(24),STD_PRE_norm(23),STD_PRE_norm(24),'b')
    ellipse_plot(Mean_POST(23),Mean_POST(24),STD_POST_norm(23),STD_POST_norm(24),'r')
    axis([-1 1    -1 1])
    hold on 
    a=plot(-1:1,[0 0 0 ],'k');
    hold on 
    b=plot([0 0 0],-1:1,'k');
    hold off
    title('Audio Happyness')
    xlabel('Valence')
    ylabel('Arousal')
    axis('square')
    a.Annotation.LegendInformation.IconDisplayStyle = 'off';
    b.Annotation.LegendInformation.IconDisplayStyle = 'off';
    
    % plot baseline 2.1
    figure()
    
    plot((Mean_PRE(13)),(Mean_PRE(14)),'bo')
    hold on 
    plot((Mean_POST(13)),(Mean_POST(14)),'ro')
    legend('26 subjects pre','31 subjects post')
    ellipse_plot(Mean_PRE(13),Mean_PRE(14),STD_PRE_norm(13),STD_PRE_norm(14),'b')
    ellipse_plot(Mean_POST(13),Mean_POST(14),STD_POST_norm(13),STD_POST_norm(14),'r')
    axis([-1 1    -1 1])
    hold on 
    a=plot(-1:1,[0 0 0 ],'k');
    hold on 
    b=plot([0 0 0],-1:1,'k');
    hold off
    title('Image baseline 2.1')
    xlabel('Valence')
    ylabel('Arousal')
    axis('square')
    a.Annotation.LegendInformation.IconDisplayStyle = 'off';
    b.Annotation.LegendInformation.IconDisplayStyle = 'off';
    
    % plot F
    figure()

    subplot(1,2,1)
    plot((Mean_PRE(15)),(Mean_PRE(16)),'bo')
    hold on 
    plot((Mean_POST(15)),(Mean_POST(16)),'ro')
    legend('26 subjects pre','31 subjects post')
    ellipse_plot(Mean_PRE(15),Mean_PRE(16),STD_PRE_norm(15),STD_PRE_norm(16),'b')
    ellipse_plot(Mean_POST(15),Mean_POST(16),STD_POST_norm(15),STD_POST_norm(16),'r')
    axis([-1 1    -1 1])
    hold on 
    a=plot(-1:1,[0 0 0 ],'k');
    hold on 
    b=plot([0 0 0],-1:1,'k');
    hold off
    title('Image Fear')
    xlabel('Valence')
    ylabel('Arousal')
    axis('square')
    a.Annotation.LegendInformation.IconDisplayStyle = 'off';
    b.Annotation.LegendInformation.IconDisplayStyle = 'off';
   

    subplot(1,2,2)
    plot((Mean_PRE(25)),(Mean_PRE(26)),'bo')
    hold on 
    plot((Mean_POST(25)),(Mean_POST(26)),'ro')
    legend('26 subjects pre','31 subjects post')
    ellipse_plot(Mean_PRE(25),Mean_PRE(26),STD_PRE_norm(25),STD_PRE_norm(26),'b')
    ellipse_plot(Mean_POST(25),Mean_POST(26),STD_POST_norm(25),STD_POST_norm(26),'r')
    axis([-1 1    -1 1])
    hold on 
    a=plot(-1:1,[0 0 0 ],'k');
    hold on 
    b=plot([0 0 0],-1:1,'k');
    hold off
    title('Audio Fear')
    xlabel('Valence')
    ylabel('Arousal')
    axis('square')
    a.Annotation.LegendInformation.IconDisplayStyle = 'off';
    b.Annotation.LegendInformation.IconDisplayStyle = 'off';
    
end   
    
end