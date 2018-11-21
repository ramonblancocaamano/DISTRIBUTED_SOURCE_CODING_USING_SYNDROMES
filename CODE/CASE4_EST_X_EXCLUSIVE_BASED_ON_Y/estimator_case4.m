%%
% @function: estimator_case4.m
% @author: BLANCO CAAMANO, RAMON.
% 
% @about: ESTIMATION OF X EXCLUSIVELY BASED ON Y.
%%
function [output] = estimator_case4(y,variance_x,variance_n)
    output = y*variance_x/(variance_x + variance_n);  
end