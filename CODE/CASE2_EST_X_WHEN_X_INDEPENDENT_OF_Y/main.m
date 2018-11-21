%%
% @file: main.m
% @author: BLANCO CAAMANO, RAMON.
%
% @about: DISTRIBUTED SOURCE CODING USING SYNDROMES.
%         CASE 2: CODING AND DECODING OF X WHEN Y IS INDEPENDENT.
%%
clearvars;

%% DEFINE PARAMATERS.
% NOTE: LLOYD-MAX 4:8 LEVELS. 
%       TCQ RATE 1:2 BITS/SAMPLE.
%       RATE 1:2 BIT/SAMPLE.
rate = [1 2];
quantizer = rate + 1;
frame_length = 1000;
SNR = [-10 30];

% RESULTS.
dist = zeros(length(rate),1);

% MONTECARLO.
MC = 100;
dist_mc = zeros(MC,1);

% VARIANCES.
variance_x = 1;

for index_rate = 1:length(rate) 
    %% LLOYD-MAX ALGORITHM.
    [~,levels] = lloyd_max_quantizer(variance_x,quantizer(index_rate));

    %% SET PARTITIONING.
    coset = set_partitioning(levels);
    
    tic;
    for index_MC = 1:MC       

        %% GENERATE X AND Y.
        x = sqrt(variance_x)*randn(1,frame_length);

        switch index_rate
            case 1
                %% TRELLIS CODE QUANTIZER
                [frame,w_tcq] = tcq_encoder1(coset,x);    

                %% DECODER.            
                w = decoder1(coset,frame);
            case 2
                %% TRELLIS CODE QUANTIZER
                [frame,w_tcq] = tcq_encoder2(coset,x);    

                %% DECODER.            
                w = decoder2(coset,frame);
        end

        %% ESTIMATION.
        x_est = w;

        %% EQUATIONS.
        dist_mc(index_MC) = mse_calculation(x,x_est);

    end
    dist(index_rate) = mean(dist_mc);
    toc;
end

%% RESULTS.
dist = 10*log10(dist/variance_x);

rate1 = [dist(1) dist(1)];
rate2 = [dist(2) dist(2)];

figure(1)
hold on;
plot(SNR,rate1);
plot(SNR,rate2)
legend('1 bit/sample','2 bit/sample');
hold off;
xlabel('Correlation-SNR in dB');
ylabel('Average normalized distortion in dB');
title('CASE 2: CODING AND DECODING OF X WHEN Y IS INDEPENDENT.');





