%%
% @function: decisor.m
% @author: BLANCO CAAMANO, RAMON.
% 
% @about: DECISION BASED IN EUCLIDEAN DISTANCE.
%%
function [output] = decisor(input, coset)
    [~,output] = min(abs(input-coset));
    %W_tx = output por S0 :  D0  ou D3
end
