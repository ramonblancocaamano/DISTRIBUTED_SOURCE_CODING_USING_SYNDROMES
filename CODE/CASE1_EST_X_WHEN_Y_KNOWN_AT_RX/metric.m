%%
% @function: metric.m
% @author: BLANCO CAAMANO, RAMON.
% 
% @about: EUCLIDEAN DISTANCE.   
%%
function [output,position] = metric(input, coset)
    [output,position] = min((input-coset).^2);
end

