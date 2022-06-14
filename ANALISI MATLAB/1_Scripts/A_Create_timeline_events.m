clear all 
clc 

%fixed time axis for the experience
time = (0:1/2048:((300*8)+120))';
events = zeros(length(time),1);
%in events if there is:
% o 1 = audio
% o 2 = visual
% o 3 = both

description_events = string(zeros(length(time),1));
description_events(1:end) = '_';

%da fare una volta e salvare 

    %% baseline
    timebirds = [50,100,150,200,250,300]*2048;
    offset_start = 245760;
    scene_change_offset = 300*2048;
        % baseline1.1
        events(timebirds+offset_start) = 1;
        description_events(timebirds+offset_start)= 'Birds';
        % baseline2.1
        events(timebirds+2*scene_change_offset+offset_start) = 1;
        description_events(timebirds+2*scene_change_offset+offset_start)= 'Birds';
        % baseline1.2
        events(timebirds+4*scene_change_offset+offset_start) = 1;
        description_events(timebirds+4*scene_change_offset+offset_start)= 'Birds';
        % baseline2.2
        events(timebirds+6*scene_change_offset+offset_start) = 1;
        description_events(timebirds+6*scene_change_offset+offset_start)= 'Birds';
     %% sadness
     
     %SEGNA RAGAZZA CHE PIANGE
     
        events(7*2048+scene_change_offset+offset_start) = 1;
        description_events(7*2048+scene_change_offset+offset_start) = 'Sad Song start';
        
        events(46*2048+scene_change_offset+offset_start) = 3;
        description_events(46*2048+scene_change_offset+offset_start) = 'Ambulance , car crash and cry';
        
        events(46*2048+scene_change_offset+offset_start) = 2;
        description_events(46*2048+scene_change_offset+offset_start) = 'Bus stop and homeless with dog';
        
        events(150*2048+scene_change_offset+offset_start) = 2;
        description_events(150*2048+scene_change_offset+offset_start) = 'Policeman walking';
        
        withe_car=[20,140,260];
        events(withe_car*2048+scene_change_offset+offset_start) = 2;
        description_events(withe_car*2048+scene_change_offset+offset_start) = 'withe car';
        
      %% Relax
     
        events(3*scene_change_offset+offset_start) = 2;
        description_events(3*scene_change_offset+offset_start) = 'Boat';
        
      %% Happyness
      
        bottle_falling = [15, 254];
        events(bottle_falling*2048+5*scene_change_offset+offset_start) = 1;
        description_events(bottle_falling*2048+5*scene_change_offset+offset_start) = 'bottle falling';
        
      %% Fear
       
       Flash = [6,30,70,125,179,220,270];
       Thunder = Flash+3;

       events(Flash*2048+7*scene_change_offset+offset_start) = 2;
       description_events(Flash*2048+7*scene_change_offset+offset_start) = 'Flash';

       
       events(Thunder*2048+7*scene_change_offset+offset_start) = 1;
       description_events(Thunder*2048+7*scene_change_offset+offset_start) = 'Thunder';
       
       events(31*2048+7*scene_change_offset+offset_start) = 3;
       description_events(31*2048+7*scene_change_offset+offset_start) = 'Door';
       
       events(65*2048+7*scene_change_offset+offset_start) = 3;
       description_events(65*2048+7*scene_change_offset+offset_start) = 'Ghost1';
       
       events(90*2048+7*scene_change_offset+offset_start) = 3;
       description_events(90*2048+7*scene_change_offset+offset_start) = 'Jar fly';
       
       events(120*2048+7*scene_change_offset+offset_start) = 1;
       description_events(120*2048+7*scene_change_offset+offset_start) = 'Jar drop';
       
       events(121*2048+7*scene_change_offset+offset_start) = 1;
       description_events(121*2048+7*scene_change_offset+offset_start) = 'IADS Crying woman';
       
       events(125*2048+7*scene_change_offset+offset_start) = 2;
       description_events(125*2048+7*scene_change_offset+offset_start) = 'Ghost2';
       
       events(155*2048+7*scene_change_offset+offset_start) = 1;
       description_events(155*2048+7*scene_change_offset+offset_start) = 'Frame drop';
       
       events(180*2048+7*scene_change_offset+offset_start) = 3;
       description_events(180*2048+7*scene_change_offset+offset_start) = 'Ghost3';
       
       events(210*2048+7*scene_change_offset+offset_start) = 1;
       description_events(210*2048+7*scene_change_offset+offset_start) = 'IADS Laughing baby';
       
       events(240*2048+7*scene_change_offset+offset_start) = 3;
       description_events(240*2048+7*scene_change_offset+offset_start) = 'Ghost 4';
       
       events(265*2048+7*scene_change_offset+offset_start) = 2;
       description_events(265*2048+7*scene_change_offset+offset_start) = 'Ligtsh fading';
       
       events(270*2048+7*scene_change_offset+offset_start) = 2;
       description_events(270*2048+7*scene_change_offset+offset_start) = 'Ghost 5';
       
       
       % aggiungi eventi a tempo 0 in ongi stanza. 
       
       
       filename = 'description_events.mat';
       save(filename,'description_events')
       
       filename = 'events.mat';
       save(filename,'events')
       
       
       

        
               
        
        
     
        