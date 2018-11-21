%%
% @file: tcq_encoder1.m
% @author: BLANCO CAAMANO, RAMON.
% 
% @about: TRELLIS CODE QUANTIZER(1bit).
%%
function [output,w_tcq] = tcq_encoder1(coset,input)

    % DECLARATION OF VARIABLES.
    frame_length = length(input);
    
    % TRANSITIONS: CENTROID & METRIC.
    centroid = zeros(4,frame_length); % STATE/CENTROID.
    code = zeros(4,frame_length); % STATE/BIT.
    cost = [0 0 0 0]; % STATE.
    transition = repmat(struct('centroid',centroid,'code',code,'metric',cost),2,1);
    
    for index = 1 : frame_length
        transition(1) = transition(2);
        
        [metric_S0,position_S0] = metric(input(index),coset.S0);
        [metric_S1,position_S1] = metric(input(index),coset.S1);
        [metric_S2,position_S2] = metric(input(index),coset.S2);
        [metric_S3,position_S3] = metric(input(index),coset.S3);
        
        if index == 1             
            %% STATE 0.
            % TRANSITION 1: STATE 0 - S0, CODE 0.
            transition(2).metric(1) = metric_S0;   
            transition(2).centroid(1,1) = coset.S0(position_S0);
            transition(2).code(1,1) = 0;           
            %% STATE 1.
            % TRANSITION 1: STATE 0 - S2, CODE 1.
            transition(2).metric(2) = metric_S2;
            transition(2).centroid(2,1) = coset.S2(position_S2);
            transition(2).code(2,1) = 1;
            continue;
        elseif index == 2
            %% STATE 0.
            % TRANSITION 1: STATE 0 - S0, CODE &0.
            transition(2).metric(1) = transition(1).metric(1) + metric_S0;
            transition(2).centroid(1,:) = transition(1).centroid(1,:);
            transition(2).centroid(1,2) = coset.S0(position_S0);
            transition(2).code(1,:) = transition(1).code(1,:);
            transition(2).code(1,2) = 0;
            %% STATE 1.
            % TRANSITION 1: STATE 0 - S2, CODE &1.
            transition(2).metric(2) = transition(1).metric(1)+ metric_S2;
            transition(2).centroid(2,:) = transition(1).centroid(1,:);
            transition(2).centroid(2,2) = coset.S2(position_S2);         
            transition(2).code(2,:) = transition(1).code(1,:);
            transition(2).code(2,2) = 1;
            %% STATE 2.
            % TRANSITION 2: STATE 1 - S1, CODE &0.
            transition(2).metric(3) = transition(1).metric(2) + metric_S1;
            transition(2).centroid(3,:) = transition(1).centroid(2,:);
            transition(2).centroid(3,2) = coset.S1(position_S1);             
            transition(2).code(3,:) = transition(1).code(2,:);
            transition(2).code(3,2) = 0;            
            %% STATE 3.
            % TRANSITION 2: STATE 1 - S3, CODE &1.
            transition(2).metric(4) = transition(1).metric(2) +  metric_S3;
            transition(2).centroid(4,:) = transition(1).centroid(2,:);
            transition(2).centroid(4,2) = coset.S3(position_S3); 
	    transition(2).code(4,:) = transition(1).code(2,:);
            transition(2).code(4,2) = 1;            
            continue;
        end
        %%
        % STATE 0.
        % TRANSITION 1: STATE 0 - S0, CODE &0. 
        % TRANSITION 3: STATE 2 - S2, CODE &0.
        T1 = transition(1).metric(1) + metric_S0;
        T3 = transition(1).metric(3) + metric_S2;        
        [value,state] = min([T1,+inf,T3,+inf]);
        
        transition(2).metric(1) = value;
        transition(2).centroid(1,:) = transition(1).centroid(state,:);
        switch state
            case 1
                transition(2).centroid(1,index) = coset.S0(position_S0);
            case 3
                transition(2).centroid(1,index) = coset.S2(position_S2);
        end
        transition(2).code(1,:) = transition(1).code(state,:);
        transition(2).code(1,index) = 0;
        %%
        % STATE 1.
        % TRANSITION 1: STATE 0 - S2, CODE &1. 
        % TRANSITION 3: STATE 2 - S0, CODE &1.
        T1 = transition(1).metric(1) + metric_S2;
        T3 = transition(1).metric(3) + metric_S0;
        [value,state] = min([T1,+inf,T3,+inf]);
       
        transition(2).metric(2) = value;
        transition(2).centroid(2,:) = transition(1).centroid(state,:);
        switch state
            case 1
                transition(2).centroid(2,index) = coset.S2(position_S2);
            case 3
                transition(2).centroid(2,index) = coset.S0(position_S0);
        end      
        transition(2).code(2,:) = transition(1).code(state,:);
        transition(2).code(2,index) = 1;
	%%
        % STATE 2.
        % TRANSITION 2: STATE 1 - S1, CODE &0.
        % TRANSITION 4: STATE 3 - S3, CODE &0.
        T2 = transition(1).metric(2) + metric_S1;
        T4 = transition(1).metric(4) + metric_S3;
        [value,state] = min([+inf,T2,+inf,T4]);
        
        transition(2).metric(3) = value;
        transition(2).centroid(3,:) = transition(1).centroid(state,:);
        switch state
            case 2
                transition(2).centroid(3,index) = coset.S1(position_S1);
            case 4
                transition(2).centroid(3,index) = coset.S3(position_S3);
        end
        transition(2).code(3,:) = transition(1).code(state,:);
        transition(2).code(3,index) = 0;
        %%
        % STATE 3.
        % TRANSITION 2: STATE 1 - S3, CODE &1.
        % TRANSITION 4: STATE 3 - S1, CODE &1.
        T2 = transition(1).metric(2) + metric_S3;
        T4 = transition(1).metric(4) + metric_S1;
        [value,state] = min([+inf,T2,+inf,T4]);
        
        transition(2).metric(4) = value;
        transition(2).centroid(4,:) = transition(1).centroid(state,:);
        switch state
            case 2
                transition(2).centroid(4,index) = coset.S3(position_S3);
            case 4
                transition(2).centroid(4,index) = coset.S1(position_S1);
        end
        transition(2).code(4,:) = transition(1).code(state,:);
        transition(2).code(4,index) = 1; 
    end
    
    %% SELECT BEST PATH.
    [~,position] = min(transition(2).metric);
    w_tcq = transition(2).centroid(position,:);
    output = transition(2).code(position,:);
end

