%%
% @function: set_partitioning.m
% @author: BLANCO CAAMANO, RAMON.
% 
% @about: COSETS ASSOCIATED TO CENTROIDS(LEVELS). 
% EXAMPLE: S0{D0,D4},S1{D1,D5},S2{D2,D6},S3{D3,D7}
%%
function [coset] = set_partitioning(input)

    frame_length = length(input);
    
    coset.S0 = zeros(1,frame_length/4);
    coset.S1 = zeros(1,frame_length/4);
    coset.S2 = zeros(1,frame_length/4);
    coset.S3 = zeros(1,frame_length/4);
    
    index = 1;
    for i=1:4:frame_length        
        coset.S0(index) = input(i); 
        coset.S1(index) = input(i+1); 
        coset.S2(index) = input(i+2); 
        coset.S3(index) = input(i+3);
        
        index = index+1;
    end
end

