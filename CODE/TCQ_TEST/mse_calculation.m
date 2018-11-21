%
% @function: mse_calculation.m
% @author: BLANCO CAAMANO, RAMON.
% 
% @about: MEAN SQUARED ERROR.
%%
function [output] = mse_calculation(x,y)    
    output = (1/length(x))*sum((x-y).^2);
end

