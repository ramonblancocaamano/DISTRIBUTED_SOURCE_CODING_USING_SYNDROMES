%%
% @file: main.m
% @author: BLANCO CAAMANO, RAMON.
%
% @about: DISTRIBUTED SOURCE CODING USING SYNDROMES.
%         CASE 3: CODING AND DECODING OF X WHEN Y IS KNOWN AT BOTH SIDES.
%%
clearvars;

%% DEFINE PARAMATERS.
% NOTE: LLOYD-MAX 4 LEVELS. 
%       TCQ RATE 1 BITS/SAMPLE.
%       RATE 1 BIT/SAMPLE.
quantizer = 2; 
frame_length = 1000;
SNR = -10:4:30;

% RESULTS.
dist = zeros(length(SNR),1);

% MONTECARLO.
MC = 100;
dist_mc = zeros(MC,1);

% VARIANCES.
variance_x = 1;
variance_n = variance_x./(10.^(SNR/10));
    
for index_snr = 1:length(SNR)
    
    %% LLOYD-MAX ALGORITHM.
    [~,levels] = lloyd_max_quantizer(variance_n(index_snr),quantizer);

    %% SET PARTITIONING.
    coset = set_partitioning(levels);
    
    tic;
    for index_MC = 1:MC       

        %% GENERATE X AND Y.
        x = sqrt(variance_x)*randn(1,frame_length);
        n = sqrt(variance_n(index_snr))*randn(1,frame_length);
        y = x + n;

        %% TRELLIS CODE QUANTIZER
        [frame,w_tcq] = tcq_encoder1(coset,n);    

        %% DECODER.            
        w = decoder1(coset,frame);

        %% QUANTIZATION NOISE.            
        variance_q = mse_calculation(n,w_tcq);          

        %% ESTIMATION.
        x_est = estimator_case3(y,w,variance_x,variance_q);

        %% EQUATIONS.
        dist_mc(index_MC) = mse_calculation(x,x_est);

    end
    dist(index_snr) = mean(dist_mc);
    toc;
end

%% RESULTS.
dist = 10*log10(dist/variance_x);

figure(1)
hold on;
plot(SNR,dist);
legend('1 bit/sample');
hold off;
xlabel('Correlation-SNR in dB');
ylabel('Average normalized distortion in dB');
title('CASE 3: CODING AND DECODING OF X WHEN Y IS KNOWN AT BOTH SIDES.');





