function beamforming(beam, nbform, res)
matfile = strcat('beam',num2str(beam),'/Khaiantennas_beam',num2str(beam),'.mat');

beambest = zeros(1,nbform);
G_complex_crossbf = zeros(180,360,3,nbform); % 3 rows including wwithout hand, with Khai's hand
G_complex_cobf = zeros(180,360,3,nbform);% 3 rows including wwithout hand, with Khai's hand
Gainbf = zeros(180,360,nbform);
Gainbfh = zeros(180,360,nbform);
Gainbfs = zeros(180,360,nbform);
Gainbfco = zeros(180,360,nbform);
Gainbfcoh = zeros(180,360,nbform);
Gainbfcos = zeros(180,360,nbform);


%% Let's loop!
for i = 1:nbform
    [beambest(i), G_complex_crossbf(:,:,1,i), G_complex_cobf(:,:,1,i), G_complex_crossbf(:,:,2,i), G_complex_cobf(:,:,2,i),...
        G_complex_crossbf(:,:,3,i), G_complex_cobf(:,:,3,i)]...
        = formbeam(90, 10*i -10, res, matfile);
    Gainbf(:,:,i) = 20*log10(sqrt(abs(G_complex_cobf(:,:,1,i)).^2 + abs(G_complex_crossbf(:,:,1,i)).^2));
    Gainbfh(:,:,i) = 20*log10(sqrt(abs(G_complex_cobf(:,:,2,i)).^2 + abs(G_complex_crossbf(:,:,2,i)).^2));
    Gainbfs(:,:,i) = 20*log10(sqrt(abs(G_complex_cobf(:,:,3,i)).^2 + abs(G_complex_crossbf(:,:,3,i)).^2));
    Gainbfco(:,:,i) = 20*log10(abs(G_complex_cobf(:,:,1,i)));
    Gainbfcoh(:,:,i) = 20*log10(abs(G_complex_cobf(:,:,2,i)));
    Gainbfcos(:,:,i) = 20*log10(abs(G_complex_cobf(:,:,3,i)));
end

%save BF data
save(strcat('beam',num2str(beam),'/Formed_beam',num2str(beam),'.mat'), 'G_complex_cobf', 'G_complex_crossbf');

%% Ploting 
% Plot Amplitude of Phi = 0deg of formed beams
figure(1)
hold on
for i = 1:nbform
    plot(0:359, Gainbf(91,:,i), 'LineWidth',2);
end
hold off
legend('B00', 'B10','B20', 'B30', 'B40','B50', 'B60', 'B70','B80','B90', 'B100','B110', 'B120', 'B130','B140', 'B150','B160','B170')
grid on
grid minor
axis([0 360 -30 10])
xlabel('Elevation angles [^o]')
ylabel('Gain [dBi]')
title('BF w/o finger - Azimuth')
savefig(strcat('beam',num2str(beam),'/BFwohand_Azimuth.fig'))

figure(2)
hold on
for i = 1:nbform
    plot(0:359, Gainbfh(91,:,i), 'LineWidth',2);
end
hold off
legend('B00', 'B10','B20', 'B30', 'B40','B50', 'B60', 'B70','B80','B90', 'B100','B110', 'B120', 'B130','B140', 'B150','B160','B170')
grid on
grid minor
axis([0 360 -30 10])
xlabel('Elevation angles [^o]')
ylabel('Gain [dBi]')
title('BF w/ 1 finger - Azimuth')
savefig(strcat('beam',num2str(beam),'/BF1Finger_Azimuth.fig'))

figure(3)
hold on
for i = 1:nbform
    plot(0:359, Gainbfs(91,:,i), 'LineWidth',2);
end
hold off
legend('B00', 'B10','B20', 'B30', 'B40','B50', 'B60', 'B70','B80','B90', 'B100','B110', 'B120', 'B130','B140', 'B150','B160','B170')
grid on
grid minor
axis([0 360 -30 10])
xlabel('Elevation angles [^o]')
ylabel('Gain [dBi]')
title('BF w/ 2 Finger - Azimuth')
savefig(strcat('beam',num2str(beam),'/BF2Finger_Azimuth.fig'))

figure(4)
hold on
for i = 1:nbform
    plot(0:359, Gainbfco(91,:,i), 'LineWidth',2);
end
hold off
legend('B00', 'B10','B20', 'B30', 'B40','B50', 'B60', 'B70','B80','B90', 'B100','B110', 'B120', 'B130','B140', 'B150','B160','B170')
grid on
grid minor
axis([0 360 -30 10])
xlabel('Elevation angles [^o]')
ylabel('Polarimetric Gain (co)[dBi]')
title('Polarimetric Formed Beam Gain w/o hand - Azimuth')
savefig(strcat('beam',num2str(beam),'/BFco_woFinger_Azimuth.fig'))

figure(5)
hold on
for i = 1:nbform
    plot(0:359, Gainbfcoh(91,:,i), 'LineWidth',2);
end
hold off
legend('B00', 'B10','B20', 'B30', 'B40','B50', 'B60', 'B70','B80','B90', 'B100','B110', 'B120', 'B130','B140', 'B150','B160','B170')
grid on
grid minor
axis([0 360 -30 10])
xlabel('Elevation angles [^o]')
ylabel('Polarimetric Gain (co)[dBi]')
title('Polarimetric Formed Beam Gain w/ 1 Finger - Azimuth')
savefig(strcat('beam',num2str(beam),'/BFco_OneFinger_Azimuth.fig'))

figure(6)
hold on
for i = 1:nbform
    plot(0:359, Gainbfcos(91,:,i), 'LineWidth',2);
end
hold off
legend('B00', 'B10','B20', 'B30', 'B40','B50', 'B60', 'B70','B80','B90', 'B100','B110', 'B120', 'B130','B140', 'B150','B160','B170')
grid on
grid minor
axis([0 360 -30 10])
xlabel('Elevation angles [^o]')
ylabel('Polarimetric Gain (co)[dBi]')
title('Polarimetric Formed Beam Gain w/ 2 Fingers - Azimuth')
savefig(strcat('beam',num2str(beam),'/BFco_TwoFinger_Azimuth.fig'))

figure(7)
plot(0:10:170, beambest, 'LineWidth',2);
grid on
xlabel('Phi [^o]')
ylabel('Max Gain level [dB]')
title('Beamforming')
savefig(strcat('beam',num2str(beam),'/BF_Gain.fig'))

close all