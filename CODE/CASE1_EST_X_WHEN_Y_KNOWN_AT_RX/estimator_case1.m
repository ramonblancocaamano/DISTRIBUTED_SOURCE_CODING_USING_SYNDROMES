%%
% @function: estimator_case1.m
% @author: BLANCO CAAMANO, RAMON.
% 
% @about: CODING AND DECODING OF X WHEN Y IS KNOWN AT RECEPTION.
%%
function [output] = estimator_case1(y,w,variance_n,variance_q)
    output = y*variance_q/(variance_q + variance_n)+w*variance_n/(variance_q + variance_n);  
end

