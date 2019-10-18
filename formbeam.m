function [beambest, G_complex_crossbf, G_complex_cobf, G_complex_crossbfh, G_complex_cobfh,...
    G_complex_crossbfs, G_complex_cobfs] = formbeam(phi, theta, res, matfile)

n = 2; % dividing beam results, because not sure

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
beambest = -100;

for ph1=0:res:359
    for ph2=0:res:359
        for ph3=0:res:359
            beamCo= (G_complex_co1(phi+1, theta+1) + G_complex_co2(phi+1, theta+1)*exp(1i*3.14*ph1/180)...
                + G_complex_co3(phi+1, theta+1)*exp(1i*3.14*ph2/180) + G_complex_co4(phi+1, theta+1)*exp(1i*3.14*ph3/180))/2;
            beamCross= (G_complex_cross1(phi+1, theta+1) + G_complex_cross2(phi+1, theta+1)*exp(1i*3.14*ph1/180)...
                + G_complex_cross3(phi+1, theta+1)*exp(1i*3.14*ph2/180) + G_complex_cross4(phi+1, theta+1)*exp(1i*3.14*ph3/180))/2;
            if (20*log10(sqrt(abs(beamCo)^2+abs(beamCross)^2)) > beambest)
                ph1_best = ph1;
                ph2_best = ph2;
                ph3_best = ph3;
                beambest = 20*log10(sqrt(abs(beamCo)^2+abs(beamCross)^2));
            end
        end
    end
end

G_complex_cobf = (G_complex_co1 + G_complex_co2.*exp(1i*3.14*ph1_best/180)...
                + G_complex_co3.*exp(1i*3.14*ph2_best/180) + G_complex_co4.*exp(1i*3.14*ph3_best/180))/n;
G_complex_crossbf = (G_complex_cross1 + G_complex_cross2.*exp(1i*3.14*ph1_best/180)...
                + G_complex_cross3.*exp(1i*3.14*ph2_best/180) + G_complex_cross4.*exp(1i*3.14*ph3_best/180))/n;
            
% G_complex_cobf = sqrt(abs(G_complex_cobf_t)).*exp(1i*3.14*angle(G_complex_cobf_t));
% G_complex_crossbf = sqrt(abs(G_complex_crossbf_t)).*exp(1i*3.14*angle(G_complex_crossbf_t));

G_complex_cobfh = (G_complex_co1h + G_complex_co2h.*exp(1i*3.14*ph1_best/180)...
                + G_complex_co3h.*exp(1i*3.14*ph2_best/180) + G_complex_co4h.*exp(1i*3.14*ph3_best/180))/n;
G_complex_crossbfh = (G_complex_cross1h + G_complex_cross2h.*exp(1i*3.14*ph1_best/180)...
                + G_complex_cross3h.*exp(1i*3.14*ph2_best/180) + G_complex_cross4h.*exp(1i*3.14*ph3_best/180))/n;
            
% G_complex_cobfh = sqrt(abs(G_complex_cobfh_t)).*exp(1i*3.14*angle(G_complex_cobfh_t));
% G_complex_crossbfh = sqrt(abs(G_complex_crossbfh_t)).*exp(1i*3.14*angle(G_complex_crossbfh_t));
            
G_complex_cobfs = (G_complex_co1s + G_complex_co2s.*exp(1i*3.14*ph1_best/180)...
                + G_complex_co3s.*exp(1i*3.14*ph2_best/180) + G_complex_co4s.*exp(1i*3.14*ph3_best/180))/n;
G_complex_crossbfs = (G_complex_cross1s + G_complex_cross2s.*exp(1i*3.14*ph1_best/180)...
                + G_complex_cross3s.*exp(1i*3.14*ph2_best/180) + G_complex_cross4s.*exp(1i*3.14*ph3_best/180))/n;
            
% G_complex_cobfs = sqrt(abs(G_complex_cobfs_t)).*exp(1i*3.14*angle(G_complex_cobfs_t));
% G_complex_crossbfs = sqrt(abs(G_complex_crossbfs_t)).*exp(1i*3.14*angle(G_complex_crossbfs_t));
