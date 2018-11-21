%%
% @file: main.m
% @author: BLANCO CAAMANO, RAMON.
%
% @about: DISTRIBUTED SOURCE CODING USING SYNDROMES.
%         CONCLUSIONS: COMPARISON BETWEEN DIFERENTS CASES PROPOSED.
%%
load('SAVE/CONCLUSIONS.mat')

dist_case_2_1 = ones(length(SNR),1)*dist_case2(1);
dist_case_2_2 = ones(length(SNR),1)*dist_case2(2);

figure(1)
hold on;
plot(SNR,dist_case1);
plot(SNR,dist_case_2_1);
plot(SNR,dist_case_2_2);
plot(SNR,dist_case3);
plot(SNR,dist_case4);
legend('CASE 1: CODING AND DECODING OF X WHEN Y IS KNOWN AT RECEPTION - 1 bit/sample','CASE 2: CODING AND DECODING OF X WHEN Y IS INDEPENDENT - 1 bit/sample','CASE 2: CODING AND DECODING OF X WHEN Y IS INDEPENDENT - 2 bit/sample','CASE 3: CODING AND DECODING OF X WHEN Y IS KNOWN AT BOTH SIDES - 1 bit/sample','CASE 4: ESTIMATION OF X EXCLUSIVELY BASED ON Y');
hold off;
xlabel('Correlation-SNR in dB');
ylabel('Average normalized distortion in dB');
title('COMPARISON OF ALL THE CONSIDERED SCENARIOS');