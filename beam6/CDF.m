s = 180*360;
range = (10:1:70);
CDF1 = zeros(4,length(range));
CDF1h = zeros(4,length(range));
CDF1s = zeros(4,length(range));

for i = 1:length(range)
    %First antenna
    norm1 = max(Gain1(:)-range(i));
    Gain_temp = Gain1 - norm1;
    CDF1(1,i) = sum(Gain_temp(:)>11.5)/s;
    Gain_temph = Gain1h - norm1;
    CDF1h(1,i) = sum(Gain_temph(:)>11.5)/s;
    Gain_temps = Gain1s - norm1;
    CDF1s(1,i) = sum(Gain_temps(:)>11.5)/s;
    clear Gain_temp Gain_temph Gain_temps
    
    %Second antenna
    norm2 = max(Gain2(:)-range(i));
    Gain_temp = Gain2 - norm2;
    CDF1(2,i) = sum(Gain_temp(:)>11.5)/s;
    Gain_temph = Gain2h - norm2;
    CDF1h(2,i) = sum(Gain_temph(:)>11.5)/s;
    Gain_temps = Gain2s - norm2;
    CDF1s(2,i) = sum(Gain_temps(:)>11.5)/s;
    clear Gain_temp Gain_temph Gain_temps
    
    %Third antenna
    norm3 = max(Gain3(:)-range(i));
    Gain_temp = Gain3 - norm3;
    CDF1(3,i) = sum(Gain_temp(:)>11.5)/s;
    Gain_temph = Gain3h - norm3;
    CDF1h(3,i) = sum(Gain_temph(:)>11.5)/s;
    Gain_temps = Gain3s - norm3;
    CDF1s(3,i) = sum(Gain_temps(:)>11.5)/s;
    clear Gain_temp Gain_temph Gain_temps
    
    %Fourth antenna
    norm4 = max(Gain4(:)-range(i));
    Gain_temp = Gain4 - norm4;
    CDF1(4,i) = sum(Gain_temp(:)>11.5)/s;
    Gain_temph = Gain4h - norm4;
    CDF1h(4,i) = sum(Gain_temph(:)>11.5)/s;
    Gain_temps = Gain4s - norm4;
    CDF1s(4,i) = sum(Gain_temps(:)>11.5)/s;
    clear Gain_temp Gain_temph Gain_temps
end

figure(1)
subtightplot(2,2,1, [0.05 0.03], [0.05 0.01], [0.03 0.01])
hold on
plot(range, CDF1(1,:), 'linewidth', 2)
plot(range, CDF1h(1,:), 'linewidth', 2)
plot(range, CDF1s(1,:), 'linewidth', 2)
hold off
xlabel('EIRP')
ylabel('CDF')
legend('CDF','CDF 1 finger','CDF 2 finger')
grid on
% title('Antenna1')

subtightplot(2,2,2, [0.05 0.03], [0.05 0.01], [0.03 0.01])
hold on
plot(range, CDF1(2,:), 'linewidth', 2)
plot(range, CDF1h(2,:), 'linewidth', 2)
plot(range, CDF1s(2,:), 'linewidth', 2)
hold off
xlabel('EIRP')
ylabel('CDF')
legend('CDF','CDF 1 finger','CDF 2 finger')
grid on
% title('Antenna2')

subtightplot(2,2,3, [0.05 0.03], [0.05 0.01], [0.03 0.01])
hold on
plot(range, CDF1(3,:), 'linewidth', 2)
plot(range, CDF1h(3,:), 'linewidth', 2)
plot(range, CDF1s(3,:), 'linewidth', 2)
hold off
xlabel('EIRP')
ylabel('CDF')
legend('CDF','CDF 1 finger','CDF 2 finger')
grid on
% title('Antenna3')

subtightplot(2,2,4, [0.05 0.03], [0.05 0.01], [0.03 0.01])
hold on
plot(range, CDF1(4,:), 'linewidth', 2)
plot(range, CDF1h(4,:), 'linewidth', 2)
plot(range, CDF1s(4,:), 'linewidth', 2)
hold off
xlabel('EIRP')
ylabel('CDF')
legend('CDF','CDF 1 finger','CDF 2 finger')
grid on
% title('Antenna4')

