clear all
close all

load('scanningGain.mat')

% making vector out of transpose result
Gainmax = maxGain(:);
Gainmaxh = maxGainh(:);
Gainmaxs = maxGains(:);
% making possibility matrix because distance between point of a sphere is
% not the same
modify = zeros(length(Gainmax),1);
sort1 = zeros(length(Gainmax),1);
sort2 = zeros(length(Gainmax),1);
sort3 = zeros(length(Gainmax),1);

for i = 1:180
    for j = 1:360
        modify(360*(i-1) + j) = sin(deg2rad(i-1));
    end
end
indexModify = modify/(sum(modify));
Gainbfmaxline1 = [Gainmax indexModify];
Gainbfmaxline2 = [Gainmaxh indexModify];
Gainbfmaxline3 = [Gainmaxs indexModify];

[~,idx1] = sort(Gainbfmaxline1(:,1)); % sort just the first column
sortGainbfmaxline1 = Gainbfmaxline1(idx1,:);   % sort the whole matrix using the sort indices
[~,idx2] = sort(Gainbfmaxline2(:,1)); % sort just the first column
sortGainbfmaxline2 = Gainbfmaxline2(idx2,:);   % sort the whole matrix using the sort indices
[~,idx3] = sort(Gainbfmaxline3(:,1)); % sort just the first column
sortGainbfmaxline3 = Gainbfmaxline3(idx3,:);   % sort the whole matrix using the sort indices

for i  = 1:length(Gainbfmaxline1)
    if i == 1
        sort1(i) = 0;
        sort2(i) = 0;
        sort3(i) = 0;
    else
        sort1(i) = sort1(i-1)+ sortGainbfmaxline1(i-1,2);
        sort2(i) = sort2(i-1)+ sortGainbfmaxline2(i-1,2);
        sort3(i) = sort3(i-1)+ sortGainbfmaxline3(i-1,2);
    end
end

figure(1)
semilogy(sortGainbfmaxline1(:,1), sort1, 'r', 'linewidth', 2)
grid on
xlabel('CDF')
ylabel('Maximum Gain [dB]')
legend('w/o finger')

figure(2)
semilogy(sortGainbfmaxline2(:,1), sort2, 'g', 'linewidth', 2)
grid on
xlabel('CDF')
ylabel('Maximum Gain [dB]')
legend('w/ 1 finger')

figure(3)
semilogy(sortGainbfmaxline3(:,1), sort3, 'b', 'linewidth', 2)
grid on
xlabel('CDF')
ylabel('Maximum Gain [dB]')
legend('w/ 2 fingers')

% figure(1)
% hold on
% plot(sortGainbfmaxline1(:,1), sort1, 'r', 'linewidth', 2)
% plot(sortGainbfmaxline2(:,1), sort2, 'g', 'linewidth', 2)
% plot(sortGainbfmaxline3(:,1), sort3, 'b', 'linewidth', 2)
% hold off
% grid on
% xlabel('Maximum Gain [dB]')
% ylabel('CDF')
% legend('w/o finger', 'w/ 1 finger', 'w/ 2 finger')

