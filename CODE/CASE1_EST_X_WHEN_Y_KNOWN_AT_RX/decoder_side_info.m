%%
% @function: decoder_side_info.m
% @author: BLANCO CAAMANO, RAMON.
% 
% @about: CONVOLUTIONAL CODE + SIDE INFORMATION.
%%
function [w] = decoder_side_info(coset,input,side_info)

    % DECLARATION OF VARIABLES.
    frame_length = length(input);
    w = zeros(1,frame_length);
    
    state = 0;
     for index = 1 : frame_length
         switch state
            case 0 %'00'
                if input(index) == 0                    
                    w(index) = coset.S0(decisor(side_info(index),coset.S0));
                    state = 0;
                else                    
                    w(index) = coset.S2(decisor(side_info(index),coset.S2));
                    state = 1;
                end
            case 1 %'01'
                if input(index) == 0                    
                    w(index) = coset.S1(decisor(side_info(index),coset.S1));
                    state = 2;
                else                    
                    w(index) = coset.S3(decisor(side_info(index),coset.S3));
                    state = 3;
                end
            case 2 %'10'
                if input(index) == 0                    
                    w(index) = coset.S2(decisor(side_info(index),coset.S2));
                    state = 0;
                else                    
                    w(index) = coset.S0(decisor(side_info(index),coset.S0));
                    state = 1;
                end
            case 3 %'11'
                if input(index) == 0                    
                    w(index) = coset.S3(decisor(side_info(index),coset.S3));
                    state = 2;
                else                    
                    w(index) = coset.S1(decisor(side_info(index),coset.S1));
                    state = 3;
                end
             otherwise
                 state = 0;
         end         
     end
end

