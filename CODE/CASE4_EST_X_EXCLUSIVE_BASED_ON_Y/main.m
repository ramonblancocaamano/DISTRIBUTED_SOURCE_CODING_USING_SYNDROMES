%%
% @file: main.m
% @author: BLANCO CAAMANO, RAMON.
%
% @about: DISTRIBUTED SOURCE CODING USING SYNDROMES.
%         CASE 4: ESTIMATION OF X EXCLUSIVELY BASED ON Y.
%%
clearvars;

%% DEFINE PARAMATERS.
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
    tic;
    for index_MC = 1:MC       

        %% GENERATE X AND Y.
        x = sqrt(variance_x)*randn(1,frame_length);
        n = sqrt(variance_n(index_snr))*randn(1,frame_length);
        y = x + n;                      

        %% ESTIMATION.
        x_est = estimator_case4(y,variance_x,variance_n(index_snr));

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
hold off;
xlabel('Correlation-SNR in dB');
ylabel('Average normalized distortion in dB');
title('CASE 4: ESTIMATION OF X EXCLUSIVELY BASED ON Y.');





