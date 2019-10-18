function [G_complex_cross, G_complex_co, normalize] = readtext(filestr, beam, ntheta, nphi, hand, nml_gain)

%this part is just for test, after testing, it should be commented while
%removing '%' from function
% filestr = 'Khai-array_P1_3dNF26Smain_beam1.txt';
% beam = 1;
% ntheta = 361;
% nphi = 181;
% hand = 0;
test = 0;

load gainhorn/Horn_ref.mat gain;
SGH = gain(2, beam);

%%
nbelement = ntheta*nphi;
f = fopen(filestr,'r');

Theta = zeros(nbelement:1);
Phi = zeros(nbelement:1);
AmpCo = zeros(nbelement:1);
PhaseCo = zeros(nbelement:1);
AmpX = zeros(nbelement:1);
PhaseX = zeros(nbelement:1);
nbline = 0;
i = 0;
j = 0;
while ~feof(f)
    line = fgets(f); %# read line by line
    sp_line = strsplit(line);
    nbline = nbline + 1;
    if(nbline == 2)
        [gain, status] = str2num(cell2mat(sp_line(8)));
        fprintf("Gain: %f \n",gain);
%         if hand == 1
%             normalize = nml_gain;
%         else
%             normalize = gain - 8;
%         end
    elseif(nbline == 35)
        [frequency, status] = str2num(cell2mat(sp_line(2)));
        if nml_gain  == 0
            normalize = SGH - (10 + frequency/3) - 0.976 - 0.9 - 0.589; %cable - connecters - microstrip
        else
            normalize = SGH - (10 + frequency/3) - 0.976 - 0.9 - 0.589 - 2; %cable - connecters - microstrip - uncertainties for antenna 2
        end
        fprintf("Normalized Gain: %f \n",normalize);
    elseif(nbline > 77)&&(nbline < 65419)
        i = i + 1;
        [Theta(i), status] = str2num(cell2mat(sp_line(2)));
        [Phi(i), status] = str2num(cell2mat(sp_line(3)));
        [AmpCo(i), status] = str2num(cell2mat(sp_line(4)));
        [PhaseCo(i), status] = str2num(cell2mat(sp_line(5)));
    elseif(nbline > 65420)
        j = j + 1;
        [AmpX(j), status] = str2num(cell2mat(sp_line(4))); 
        [PhaseX(j), status] = str2num(cell2mat(sp_line(5)));
    end
end

angleInRadians_theta_measX = deg2rad(PhaseX');
normalized_gainX = AmpX'- normalize;
normalized_gain_linX = 10.^(normalized_gainX/20); % Divide by 20 as Fabien has done
G_complex_theta_measX = normalized_gain_linX(:,1).*exp(1i*angleInRadians_theta_measX);

Test_meas_dipX = reshape(G_complex_theta_measX(:,1),[361,181]);
aX = flip(Test_meas_dipX(1:180,1:180));
bX =Test_meas_dipX(181:360,2:181);
G_complex_cross1 = [bX aX];
G_complex_cross = [G_complex_cross1(:,91:360) G_complex_cross1(:,1:90)];

angleInRadians_theta_measCo = deg2rad(PhaseCo');
normalized_gainCo = AmpCo'- normalize;
normalized_gain_linCo = 10.^(normalized_gainCo/20); % Divide by 20 as Fabien has done
G_complex_theta_measCo = normalized_gain_linCo(:,1).*exp(1i*angleInRadians_theta_measCo);

Test_meas_dipCo = reshape(G_complex_theta_measCo(:,1),[361,181]);
aCo = flip(Test_meas_dipCo(1:180,1:180));
bCo = Test_meas_dipCo(181:360,2:181);
G_complex_co1 = [bCo aCo];
G_complex_co = [G_complex_co1(:,91:360) G_complex_co1(:,1:90)];

%% Ploting
figure(1)
hold on
plot(1:360, [20*log10(abs(G_complex_cross(:,1))); 20*log10(abs(G_complex_cross(180:-1:1,181)))], '.-', 'LineWidth',2)
plot(1:360, [20*log10(abs(G_complex_cross(:,91))); 20*log10(abs(G_complex_cross(180:-1:1,271)))], '.-', 'LineWidth',2)
plot(1:360, 20*log10(abs(G_complex_cross(91,:))), 'LineWidth',2)
plot(1:360, 20*log10(abs(G_complex_cross(1,:))), 'LineWidth',2)
hold off
grid on
grid minor
axis([0 360 -50 10])
xlabel('Azimuth (deg)')
ylabel('Polarimetric Gain(dBi)')
legend('Elevation1', 'Elevation2', 'Azimuth 1', 'Azimuth 2')
title('Polarimetric Gain Co')

if test == 0  
    savefig(strcat('beam',num2str(beam),'/',filestr(1:length(filestr)-4),'.fig'))
    close all
end

fprintf(strcat('Finished :', filestr,'\n'));

fclose(f);