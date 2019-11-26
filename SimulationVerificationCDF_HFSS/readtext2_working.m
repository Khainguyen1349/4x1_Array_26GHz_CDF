clear all
close all

%% Process data
div = 20;
matfile = strcat('KhaiSimulHFSS_Finger_MultiFrequency.mat');

%Gain to E field ratio
Z0 = 120*pi; % Zo for air
ratio = sqrt(2*Z0/(4 * pi));
% Ephi=Ephi/ratio;
% Etheta=Etheta/ratio;
% 
% T = { Ephi Etheta dim };

G_complex_co_pre = zeros(181,361,5,4);
G_complex_cross_pre = zeros(181,361,5,4);
G_complex_co = zeros(180,360,5,4);
G_complex_cross = zeros(180,360,5,4);

for i = 1:4
    file = strcat('P',num2str(i),'.csv');
    S = load(file);
    reCross = reshape(S(:,4)',181*5,361);
    imCross = reshape(S(:,5)',181*5,361);
    reCo = reshape(S(:,6)',181*5,361);
    imCo = reshape(S(:,7)',181*5,361);
    for j = 1:5
        G_complex_cross_pre(:,:,j,i) = (reCross((j-1)*181+1:j*181,:) + 1i*imCross((j-1)*181+1:j*181,:))/ratio;
        G_complex_co_pre(:,:,j,i) = (reCo((j-1)*181+1:j*181,:) + 1i*imCo((j-1)*181+1:j*181,:))/ratio;
        G_complex_cross(:,:,j,i) = G_complex_cross_pre(1:180,1:360,j,i);
        G_complex_co(:,:,j,i) = G_complex_co_pre(1:180,1:360,j,i);
%         gain_total = 20*log10(sqrt(abs(G_complex_co(:,:,i)).^2 + abs(G_complex_cross(:,:,i)).^2));
    end
%     figure(i)
%     fig1 = contourf(gain_total);

    clear file S ampCo phaseCo ampX phaseX gain_total fig
    
end

figure(5)
hold on
for i = 1:4
plot(1:360, 20*log10(abs(G_complex_co(91,:,1,i)))); %Plot co pattern in yOz plane
plot(1:360, 20*log10(abs(G_complex_cross(91,:,1,i)))); %Plot cross pattern in yOz plane
end
legend('co1', 'cross1','co2', 'cross2','co3', 'cross3','co4', 'cross4')
hold off
savefig('ElementDiv20Div2_Casing.fig')


%% Forming beams
res = 11.25; % Discritizing phase-shifting
nbform = 18; % Number of beams formed

G_complex_crossbf = zeros(180,360,nbform,5); % 
G_complex_cobf = zeros(180,360,nbform,5);
for j = 1:5
    for i = 1:nbform
        phi = 90 - 10*(floor(nbform/2) - i + 1);
        ph1_best = 0;
        ph2_best = 0;
        ph3_best = 0;
        beambest = -100;

        for ph1=0:res:359
            for ph2=0:res:359
                for ph3=0:res:359
                    beamCo = G_complex_co(91, phi + 1,j, 1) + G_complex_co(91, phi + 1,j, 2)*exp(1i*pi*ph1/180)...
                        + G_complex_co(91, phi + 1,j, 3)*exp(1i*pi*ph2/180) + G_complex_co(91, phi + 1,j, 4)*exp(1i*pi*ph3/180);
                    beamCross = G_complex_cross(91, phi + 1,j, 1) + G_complex_cross(91, phi + 1,j, 2)*exp(1i*pi*ph1/180)...
                        + G_complex_cross(91, phi + 1,j, 3)*exp(1i*pi*ph2/180) + G_complex_cross(91, phi + 1,j, 4)*exp(1i*pi*ph3/180);
                    if (div*log10(sqrt(abs(beamCo)^2+abs(beamCross)^2)) > beambest)
                        ph1_best = ph1;
                        ph2_best = ph2;
                        ph3_best = ph3;
                        beambest = div*log10(sqrt(abs(beamCo)^2+abs(beamCross)^2));
                    end
                end
            end
        end


        G_complex_cobf(:,:,i,j) = (G_complex_co(:,:,j,1) + G_complex_co(:,:,j,2)*exp(1i*pi*ph1_best/180)...
                        + G_complex_co(:,:,j,3)*exp(1i*pi*ph2_best/180) + G_complex_co(:,:,j,4)*exp(1i*pi*ph3_best/180))/2;
        G_complex_crossbf(:,:,i,j) = (G_complex_cross(:,:,j,1) + G_complex_cross(:,:,j,2)*exp(1i*3.14*ph1_best/180)...
                        + G_complex_cross(:,:,j,3)*exp(1i*pi*ph2_best/180) + G_complex_cross(:,:,j,4)*exp(1i*pi*ph3_best/180))/2;   

        clear ph1_best ph2_best ph3_best ph4_best beambest beamCo beamCross
    end
end

Gainbf = 20*log10(sqrt(abs(G_complex_crossbf).^2 + abs(G_complex_cobf).^2));
GainbfCo = 20*log10(abs(G_complex_cobf));
GainbfCross = 20*log10(abs(G_complex_crossbf));

save(matfile,'G_complex_cobf','G_complex_crossbf');

% Ploting beams continuously
% n = 1
% while(1)
%     if n == nbform
%         n = 1
%     else
%         n = n + 1
%     end
%     figure(6)
%     fig2 = contourf(Gainbf(:,:,n));
%     pause(1);
% end

figure(11)
hold on
for i = 1:nbform
plot(1:360, GainbfCo(91,:,i,1)); %Plot beamforming Gain pattern in yOz plane
end
legend('B1', 'B2','B3','B4','B5','B6','B7','B8','B9','B10','B11','B12','B13', 'B14', 'B15', 'B16', 'B17', 'B18')
hold off
savefig('BeamDiv20Div2_Casing.fig')
