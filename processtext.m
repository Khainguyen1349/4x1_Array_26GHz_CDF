function processtext(beam)
%Process data as the fuction of beam order
%% Process data files
nphi = 361;
ntheta = 181;

%Without hand
filep1 = strcat('Khai-array_P1_3dNF26Smain_beam',num2str(beam),'.txt');
filep2 = strcat('Khai-array_P2_3dNF26Smain_beam',num2str(beam),'.txt');
filep3 = strcat('Khai-array_P3_3dNF26Smain_beam',num2str(beam),'.txt');
filep4 = strcat('Khai-array_P4_3dNF26Smain_beam',num2str(beam),'.txt');

[G_complex_co1, G_complex_cross1,gain1] = readtext(filep1, beam, ntheta, nphi,0,0);
[G_complex_co2, G_complex_cross2,gain2] = readtext(filep2, beam, ntheta, nphi,0,1);
[G_complex_co3, G_complex_cross3,gain3] = readtext(filep3, beam, ntheta, nphi,0,0);
[G_complex_co4, G_complex_cross4,gain4] = readtext(filep4, beam, ntheta, nphi,0,0);

%With One finger
filep1h = strcat('Khai-array_P1_3dNF26_beam',num2str(beam),'.txt');
filep2h = strcat('Khai-array_P2_3dNF26_beam',num2str(beam),'.txt');
filep3h = strcat('Khai-array_P3_3dNF26_beam',num2str(beam),'.txt');
filep4h = strcat('Khai-array_P4_3dNF26_beam',num2str(beam),'.txt');

[G_complex_co1h, G_complex_cross1h,~] = readtext(filep1h, beam, ntheta, nphi, 1, 0);
[G_complex_co2h, G_complex_cross2h,~] = readtext(filep2h, beam, ntheta, nphi, 1, 1);
[G_complex_co3h, G_complex_cross3h,~] = readtext(filep3h, beam, ntheta, nphi, 1, 0);
[G_complex_co4h, G_complex_cross4h,~] = readtext(filep4h, beam, ntheta, nphi, 1, 0);

%With Two fingers
filep1s = strcat('Khai-array_P1_3dNF26suzanHAnd_beam',num2str(beam),'.txt');
filep2s = strcat('Khai-array_P2_3dNF26suzanHAnd_beam',num2str(beam),'.txt');
filep3s = strcat('Khai-array_P3_3dNF26suzanHAnd_beam',num2str(beam),'.txt');
filep4s = strcat('Khai-array_P4_3dNF26suzanHAnd_beam',num2str(beam),'.txt');

[G_complex_co1s, G_complex_cross1s,~] = readtext(filep1s, beam, ntheta, nphi, 1, 0);
[G_complex_co2s, G_complex_cross2s,~] = readtext(filep2s, beam, ntheta, nphi, 1, 1);
[G_complex_co3s, G_complex_cross3s,~] = readtext(filep3s, beam, ntheta, nphi, 1, 0);
[G_complex_co4s, G_complex_cross4s,~] = readtext(filep4s, beam, ntheta, nphi, 1, 0);

GaindB1 = 10*log10(abs(G_complex_co1).^2 + abs(G_complex_cross1).^2);
GaindB2 = 10*log10(abs(G_complex_co2).^2 + abs(G_complex_cross2).^2);
GaindB3 = 10*log10(abs(G_complex_co3).^2 + abs(G_complex_cross3).^2);
GaindB4 = 10*log10(abs(G_complex_co4).^2 + abs(G_complex_cross4).^2);

GaindB1h = 10*log10(abs(G_complex_co1h).^2 + abs(G_complex_cross1h).^2);
GaindB2h = 10*log10(abs(G_complex_co2h).^2 + abs(G_complex_cross2h).^2);
GaindB3h = 10*log10(abs(G_complex_co3h).^2 + abs(G_complex_cross3h).^2);
GaindB4h = 10*log10(abs(G_complex_co4h).^2 + abs(G_complex_cross4h).^2);

GaindB1s = 10*log10(abs(G_complex_co1s).^2 + abs(G_complex_cross1s).^2);
GaindB2s = 10*log10(abs(G_complex_co2s).^2 + abs(G_complex_cross2s).^2);
GaindB3s = 10*log10(abs(G_complex_co3s).^2 + abs(G_complex_cross3s).^2);
GaindB4s = 10*log10(abs(G_complex_co4s).^2 + abs(G_complex_cross4s).^2);

%% Ploting
figure(1)
hold on
plot(1:360,[20*log10(abs(G_complex_co1(:,91))); 20*log10(abs(G_complex_co1(180:-1:1,271)))], 'LineWidth',2);
plot(1:360,[20*log10(abs(G_complex_co2(:,91))); 20*log10(abs(G_complex_co2(180:-1:1,271)))], 'LineWidth',2);
plot(1:360,[20*log10(abs(G_complex_co3(:,91))); 20*log10(abs(G_complex_co3(180:-1:1,271)))], 'LineWidth',2);
plot(1:360,[20*log10(abs(G_complex_co4(:,91))); 20*log10(abs(G_complex_co4(180:-1:1,271)))], 'LineWidth',2);
hold off
grid on
grid minor
axis([0 360 -50 10])
xlabel('Azimuth angles [^o]')
ylabel('Polarimetric Gain (Co)(dBi)')
legend('ANT1 Co90', 'ANT2 Co90','ANT3 Co90', 'ANT4 Co90')
title('Gain Co all antennas - Elevation')
savefig(strcat('beam',num2str(beam),'/Singles_co_Elevation_wohand.fig'))

figure(2)
hold on
plot(1:360,20*log10(abs(G_complex_co1(91,:))), 'LineWidth',2);
plot(1:360,20*log10(abs(G_complex_co2(91,:))), 'LineWidth',2);
plot(1:360,20*log10(abs(G_complex_co3(91,:))), 'LineWidth',2);
plot(1:360,20*log10(abs(G_complex_co4(91,:))), 'LineWidth',2);
hold off
grid on
grid minor
axis([0 360 -50 10])
xlabel('Elevation angles [^o]')
ylabel('Polarimetric Gain (Co)[dBi]')
legend('ANT1 Co90', 'ANT2 Co90','ANT3 Co90', 'ANT4 Co90')
title('Gain Co all antennas - Azimuth')
savefig(strcat('beam',num2str(beam),'/Singles_co_Azimuth_wohand.fig'))

figure(3)
hold on
plot(1:360,[20*log10(abs(G_complex_co1h(:,91))); 20*log10(abs(G_complex_co1h(180:-1:1,271)))], 'LineWidth',2);
plot(1:360,[20*log10(abs(G_complex_co2h(:,91))); 20*log10(abs(G_complex_co2h(180:-1:1,271)))], 'LineWidth',2);
plot(1:360,[20*log10(abs(G_complex_co3h(:,91))); 20*log10(abs(G_complex_co3h(180:-1:1,271)))], 'LineWidth',2);
plot(1:360,[20*log10(abs(G_complex_co4h(:,91))); 20*log10(abs(G_complex_co4h(180:-1:1,271)))], 'LineWidth',2);
hold off
grid on
grid minor
axis([0 360 -40 5])
xlabel('Azimuth angles [^o]')
ylabel('Polarimetric Gain (Co)[dBi]')
legend('ANT1 Co90', 'ANT2 Co90','ANT3 Co90', 'ANT4 Co90')
title('Gain Co all antennas One finger - Elevation')
savefig(strcat('beam',num2str(beam),'/Singles_co_Elevation_1finger.fig'))

figure(4)
hold on
plot(1:360,20*log10(abs(G_complex_co1h(91,:))), 'LineWidth',2);
plot(1:360,20*log10(abs(G_complex_co2h(91,:))), 'LineWidth',2);
plot(1:360,20*log10(abs(G_complex_co3h(91,:))), 'LineWidth',2);
plot(1:360,20*log10(abs(G_complex_co4h(91,:))), 'LineWidth',2);
hold off
grid on
grid minor
axis([0 360 -40 5])
xlabel('Elevation angles [^o]')
ylabel('Polarimetric Gain (Co)[dBi]')
legend('ANT1 Co90', 'ANT2 Co90','ANT3 Co90', 'ANT4 Co90')
title('Gain Co all antennas One finger - Azimuth')
savefig(strcat('beam',num2str(beam),'/Singles_co_Azimuth_1finger.fig'))

figure(5)
hold on
plot(1:360,[20*log10(abs(G_complex_co1s(:,91))); 20*log10(abs(G_complex_co1s(180:-1:1,271)))], 'LineWidth',2);
plot(1:360,[20*log10(abs(G_complex_co2s(:,91))); 20*log10(abs(G_complex_co2s(180:-1:1,271)))], 'LineWidth',2);
plot(1:360,[20*log10(abs(G_complex_co3s(:,91))); 20*log10(abs(G_complex_co3s(180:-1:1,271)))], 'LineWidth',2);
plot(1:360,[20*log10(abs(G_complex_co4s(:,91))); 20*log10(abs(G_complex_co4s(180:-1:1,271)))], 'LineWidth',2);
hold off
grid on
grid minor
axis([0 360 -40 5])
xlabel('Azimuth angles [^o]')
ylabel('Polarimetric Gain (Co)[dBi]')
legend('ANT1 Co90', 'ANT2 Co90','ANT3 Co90', 'ANT4 Co90')
title('Gain Co all antennas Two finger - Elevation')
savefig(strcat('beam',num2str(beam),'/Singles_co_Elevation_2finger.fig'))

figure(6)
hold on
plot(1:360,20*log10(abs(G_complex_co1s(91,:))), 'LineWidth',2);
plot(1:360,20*log10(abs(G_complex_co2s(91,:))), 'LineWidth',2);
plot(1:360,20*log10(abs(G_complex_co3s(91,:))), 'LineWidth',2);
plot(1:360,20*log10(abs(G_complex_co4s(91,:))), 'LineWidth',2);
hold off
grid on
grid minor
axis([0 360 -40 5])
xlabel('Elevation angles [^o]')
ylabel('Polarimetric Gain (Co)[dBi]')
legend('ANT1 Cross90', 'ANT2 Co90','ANT3 Co90', 'ANT4 Co90')
title('Gain Co all antennas Two finger - Azimuth')
savefig(strcat('beam',num2str(beam),'/Singles_co_Azimuth_2finger.fig'))

save(strcat('beam',num2str(beam),'/Khaiantennas_beam',num2str(beam),'.mat'), 'G_complex_co1h', 'G_complex_cross1h',...
    'G_complex_co2h', 'G_complex_cross2h', 'G_complex_co3h', 'G_complex_cross3h', 'G_complex_co4h', 'G_complex_cross4h',...
    'G_complex_co1', 'G_complex_cross1', 'G_complex_co2', 'G_complex_cross2',...
    'G_complex_co3', 'G_complex_cross3', 'G_complex_co4', 'G_complex_cross4',...
    'G_complex_co1s', 'G_complex_cross1s', 'G_complex_co2s', 'G_complex_cross2s',...
    'G_complex_co3s', 'G_complex_cross3s', 'G_complex_co4s', 'G_complex_cross4s');

save(strcat('beam',num2str(beam),'/GaindB_beam',num2str(beam),'.mat'),...
    'GaindB1', 'GaindB2', 'GaindB3', 'GaindB4', 'GaindB1h', 'GaindB2h', 'GaindB3h', 'GaindB4h',...
    'GaindB1s', 'GaindB2s', 'GaindB3s', 'GaindB4s');

fprintf(strcat('Finished beam :',num2str(beam),'\n'));
close all
