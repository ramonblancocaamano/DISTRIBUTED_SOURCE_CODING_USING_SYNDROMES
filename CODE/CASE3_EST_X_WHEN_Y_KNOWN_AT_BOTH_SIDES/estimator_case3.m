%%
% @function: estimator_case3.m
% @author: BLANCO CAAMANO, RAMON.
% 
% @about: CODING AND DECODING OF X WHEN Y IS KNONW AT BOTH SIDES.
%%
function [output] = estimator_case3(y,w,variance_x,variance_q)
    output = y-(y*variance_q/(variance_x + variance_q)+w*variance_x/(variance_x + variance_q));  
end