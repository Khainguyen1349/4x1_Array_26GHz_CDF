% function [beambest, G_complex_crossbf, G_complex_cobf, G_complex_crossbfh, G_complex_cobfh,...
%     G_complex_crossbfs, G_complex_cobfs] = formbeam(phi, theta, res, matfile)
clear all
close all
beam = 6;
res = 11.25;
n = 2; % dividing beam results, because not sure
matfile = strcat('beam',num2str(beam),'/Khaiantennas_beam',num2str(beam),'.mat');
FS = 20; % font size for figure

% Forming in specific direction
load(matfile, 'G_complex_co1', 'G_complex_co2',...
    'G_complex_co3', 'G_complex_co4',...
    'G_complex_cross1', 'G_complex_cross2',...
     'G_complex_cross3', 'G_complex_cross4', 'G_complex_co1h', 'G_complex_co2h',...
    'G_complex_co3h', 'G_complex_co4h',...
    'G_complex_cross1h', 'G_complex_cross2h',...
     'G_complex_cross3h', 'G_complex_cross4h', 'G_complex_co1s', 'G_complex_co2s',...
    'G_complex_co3s', 'G_complex_co4s',...
    'G_complex_cross1s', 'G_complex_cross2s',...
     'G_complex_cross3s', 'G_complex_cross4s');
ph1_best = 0;
ph2_best = 0;
ph3_best = 0;
maxGain = zeros(180,360)-100;
maxCo = zeros(180,360);
maxCross = zeros(180,360);

maxGainh = zeros(180,360)-100;
maxCoh = zeros(180,360);
maxCrossh = zeros(180,360);

maxGains = zeros(180,360)-100;
maxCos = zeros(180,360);
maxCrosss = zeros(180,360);

for ph1=0:res:359
    for ph2=0:res:359
        for ph3=0:res:359
            beamCo= (G_complex_co1 + G_complex_co2.*exp(1i*3.14*ph1/180)...
                + G_complex_co3.*exp(1i*3.14*ph2/180) + G_complex_co4.*exp(1i*3.14*ph3/180))/2;
            beamCross= (G_complex_cross1 + G_complex_cross2.*exp(1i*3.14*ph1/180)...
                + G_complex_cross3.*exp(1i*3.14*ph2/180) + G_complex_cross4.*exp(1i*3.14*ph3/180))/2;
            for i = 1:180
                for j = 1:360
                    if (20*log10(sqrt(abs(beamCo(i,j))^2+abs(beamCross(i,j))^2)) > maxGain(i,j))
                        maxGain(i,j) = 20*log10(sqrt(abs(beamCo(i,j))^2+abs(beamCross(i,j))^2));
                        maxCo(i,j) = beamCo(i,j);
                        maxCross(i,j) = beamCross(i,j);
                    end
                end
            end
            
            
            beamCoh= (G_complex_co1h + G_complex_co2h.*exp(1i*3.14*ph1/180)...
                + G_complex_co3h.*exp(1i*3.14*ph2/180) + G_complex_co4h.*exp(1i*3.14*ph3/180))/2;
            beamCrossh= (G_complex_cross1h + G_complex_cross2h.*exp(1i*3.14*ph1/180)...
                + G_complex_cross3h.*exp(1i*3.14*ph2/180) + G_complex_cross4h.*exp(1i*3.14*ph3/180))/2;
            for i = 1:180
                for j = 1:360
                    if (20*log10(sqrt(abs(beamCoh(i,j))^2+abs(beamCrossh(i,j))^2)) > maxGainh(i,j))
                        maxGainh(i,j) = 20*log10(sqrt(abs(beamCoh(i,j))^2+abs(beamCrossh(i,j))^2));
                        maxCoh(i,j) = beamCoh(i,j);
                        maxCrossh(i,j) = beamCrossh(i,j);
                    end
                end
            end
            
            beamCos= (G_complex_co1s + G_complex_co2s.*exp(1i*3.14*ph1/180)...
                + G_complex_co3s.*exp(1i*3.14*ph2/180) + G_complex_co4s.*exp(1i*3.14*ph3/180))/2;
            beamCrosss= (G_complex_cross1s + G_complex_cross2s.*exp(1i*3.14*ph1/180)...
                + G_complex_cross3s.*exp(1i*3.14*ph2/180) + G_complex_cross4s.*exp(1i*3.14*ph3/180))/2;
            for i = 1:180
                for j = 1:360
                    if (20*log10(sqrt(abs(beamCos(i,j))^2+abs(beamCrosss(i,j))^2)) > maxGains(i,j))
                        maxGains(i,j) = 20*log10(sqrt(abs(beamCos(i,j))^2+abs(beamCrosss(i,j))^2));
                        maxCos(i,j) = beamCos(i,j);
                        maxCrosss(i,j) = beamCrosss(i,j);
                    end
                end
            end
        end
    end
end

% figure(1)
% imagesc(maxGain);
% xlabel('Phi [^o]');
% ylabel('Theta [^o]');
% savefig(strcat('C:\Users\NGUYEN Khai\Documents\MATLAB\Measured Data at Nice\Khai_oldexport_Div20\maxBeam/w2Finger.fig'))

figure(2)
hold on
plot(0:359, maxGain(91,:), '--', 'LineWidth',2);
plot(0:359, maxGainh(91,:), 'LineWidth',2);
plot(0:359, maxGains(91,:), 'LineWidth',2);
hold off
grid on
grid minor
axis([0 360 -25 10])
xlabel('Azimuth [^o]')
ylabel('Gain [dBi]')
title('BF with 2 fingers - Azimuth')
legend('Scanning gain - w/o fingers', 'Scanning gain - w/ 1 fingers', 'Scanning gain - w/ 2 fingers');
savefig(strcat('C:\Users\NGUYEN Khai\Documents\MATLAB\Measured Data at Nice\Khai_oldexport_Div20\maxBeam/Scanning_Azimuth.fig'))

save('scanningGain.mat', 'maxCo', 'maxCoh', 'maxCos', 'maxCross' ,...
    'maxCrossh', 'maxCrosss', 'maxGain', 'maxGainh', 'maxGains')
% [f_1,x_1]=ecdf(maxGain(:));
% figure(3)
% set(gcf,'DefaultAxesFontSize',40);
% set(gcf,'Position',[0 100 1024 768]);
% semilogy(x_1,f_1,'b','LineWidth',2)
% grid on;
% xlabel('Max Array Gain [dB]','FontSize',FS,'Interpreter','latex');
% ylabel('CDF','FontSize',FS,'Interpreter','latex');
% savefig(strcat('C:\Users\NGUYEN Khai\Documents\MATLAB\Measured Data at Nice\Khai_oldexport_Div20\maxBeam/CDF.fig'))
% 

%export to text file to plot on Veusz
fidcov1 = fopen('ScanningGain_n2.txt','wt');

fprintf(fidcov1,'Phi, Gain_n2, Gainh_n2, Gains_n2\n');
for i = 1:360
    fprintf(fidcov1,'%f, %f, %f, %f\n',i-1, maxGain(91,i), maxGainh(91,i), maxGains(91,i));
end
fclose(fidcov1);

