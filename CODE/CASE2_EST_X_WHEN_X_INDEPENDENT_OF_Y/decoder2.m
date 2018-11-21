%%
% @function: decoder2.m
% @author: BLANCO CAAMANO, RAMON.
% 
% @about: CONVOLUTIONAL CODE(2bit).
%%
function [w] = decoder2(coset,input)

    % DECLARATION OF VARIABLES.
    frame_length = length(input);
    w = zeros(1,frame_length/2);
    
    state = 0;
     for index = 1:2:frame_length
         switch state
            case 0 %'00'
                if input(index) == 0                    
                    w((index+1)/2) = coset.S0(input(index+1)+1);
                    state = 0;
                else                    
                    w((index+1)/2) = coset.S2(input(index+1)+1);
                    state = 1;
                end
            case 1 %'01'
                if input(index) == 0                    
                    w((index+1)/2) = coset.S1(input(index+1)+1);
                    state = 2;
                else                    
                    w((index+1)/2) = coset.S3(input(index+1)+1);
                    state = 3;
                end
            case 2 %'10'
                if input(index) == 0                    
                    w((index+1)/2) = coset.S2(input(index+1)+1);
                    state = 0;
                else                    
                    w((index+1)/2) = coset.S0(input(index+1)+1);
                    state = 1;
                end
            case 3 %'11'
                if input(index) == 0                    
                    w((index+1)/2) = coset.S3(input(index+1)+1);
                    state = 2;
                else                    
                    w((index+1)/2) = coset.S1(input(index+1)+1);
                    state = 3;
                end
             otherwise
                 state = 0;
         end         
     end
end

