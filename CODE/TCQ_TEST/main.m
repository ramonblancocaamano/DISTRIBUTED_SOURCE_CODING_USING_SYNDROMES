%%
% @file: main.m
% @author: BLANCO CAAMANO, RAMON.
%
% @about: TRELLIS CODED QUANTIZER TEST.
%%
clearvars;

%% DEFINE PARAMATERS.
tcq_rate = 1:2;
frame_length = 10000;

% RESULTS.
tcq = zeros(length(tcq_rate),1);

% MONTECARLO.
MC = 100;
err_q = zeros(MC,1);

% VARIANCES.
variance_x = 1;

for index_rate = 1:length(tcq_rate)
    %% LLOYD-MAX ALGORITHM.
    [~,levels] = lloyd_max_quantizer(variance_x,tcq_rate(index_rate)+1);

    %% SET PARTITIONING.
    coset = set_partitioning(levels);
    
    tic;
    for index_mc = 1:MC       

        %% GENERATE X AND Y.
        x = sqrt(variance_x)*randn(1,frame_length);

        %% TRELLIS CODE QUANTIZER
        w_tcq = tcq_encoder(coset,x);             
        err_q(index_mc) = mse_calculation(x,w_tcq); 

    end
    tcq(index_rate) = mean(err_q);
    toc;
end

%% RESULTS.
tcq = 10*log10(tcq);

for index = 1: length(tcq_rate)
    fprintf('TCQ_RATE %d -> SNR: %f dB\n', tcq_rate(index), tcq(index));
end





