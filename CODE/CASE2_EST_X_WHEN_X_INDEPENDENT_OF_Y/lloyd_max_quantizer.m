%%
% @file: lloyd_max_quantizer.m
% @author: BLANCO CAAMANO, RAMON.
%
% @about: ITS OBTAINS OPTIMAL QUANTIZER, MINIMIZE THE MEAN SQUARED 
% QUANTIZER ERROR.
%%
function [intervals,levels] = lloyd_max_quantizer(variance,n)

    % INITIALIZATION.
    intervals = [-inf,-6:12/(2^n-2):6,+inf]*sqrt(variance);
    levels = zeros(1,2^n);

    % LLOYD-MAX ALGORITHM
    for iter=1:10000
        % REPRESENTATIVE LEVELS.
        for i=1:length(levels)
            levels(i)=(sqrt(variance/(2*pi))*(exp(-(intervals(i)^2)/(2*variance))-exp(-(intervals(i+1))^2/(2*variance))))/(qfunc(intervals(i)/sqrt(variance))- qfunc(intervals(i+1)/sqrt(variance)));
        end
        % DECISION THRESHOLDS.
        for i=2:length(levels)
            intervals(i) = 1/2 *(levels(i) + levels(i-1));
        end
    end

end

