%%
% @function: decoder1.m
% @author: BLANCO CAAMANO, RAMON.
% 
% @about: CONVOLUTIONAL CODE(1bit).
%%
function [w] = decoder1(coset,input)

    % DECLARATION OF VARIABLES.
    frame_length = length(input);
    w = zeros(1,frame_length);
    
    state = 0;
     for index = 1 : frame_length
         switch state
            case 0 %'00'
                if input(index) == 0                    
                    w(index) = coset.S0(1);
                    state = 0;
                else                    
                    w(index) = coset.S2(1);
                    state = 1;
                end
            case 1 %'01'
                if input(index) == 0                    
                    w(index) = coset.S1(1);
                    state = 2;
                else                    
                    w(index) = coset.S3(1);
                    state = 3;
                end
            case 2 %'10'
                if input(index) == 0                    
                    w(index) = coset.S2(1);
                    state = 0;
                else                    
                    w(index) = coset.S0(1);
                    state = 1;
                end
            case 3 %'11'
                if input(index) == 0                    
                    w(index) = coset.S3(1);
                    state = 2;
                else                    
                    w(index) = coset.S1(1);
                    state = 3;
                end
             otherwise
                 state = 0;
         end         
     end
end

