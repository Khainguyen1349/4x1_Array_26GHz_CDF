clear all
close all
load('Khaiantennas_beam6.mat')

Gain1 = 20*log10(sqrt(abs(G_complex_cross1(60:120,:)).^2 + abs(G_complex_co1(60:120,:)).^2));
Gain1h = 20*log10(sqrt(abs(G_complex_cross1h(60:120,:)).^2 + abs(G_complex_co1h(60:120,:)).^2));
Gain1s = 20*log10(sqrt(abs(G_complex_cross1s(60:120,:)).^2 + abs(G_complex_co1s(60:120,:)).^2));

Gain2 = 20*log10(sqrt(abs(G_complex_cross2(60:120,:)).^2 + abs(G_complex_co2(60:120,:)).^2));
Gain2h = 20*log10(sqrt(abs(G_complex_cross2h(60:120,:)).^2 + abs(G_complex_co2h(60:120,:)).^2));
Gain2s = 20*log10(sqrt(abs(G_complex_cross2s(60:120,:)).^2 + abs(G_complex_co2s(61:121,:)).^2));

Gain3 = 20*log10(sqrt(abs(G_complex_cross3(60:120,:)).^2 + abs(G_complex_co3(60:120,:)).^2));
Gain3h = 20*log10(sqrt(abs(G_complex_cross3h(60:120,:)).^2 + abs(G_complex_co3h(60:120,:)).^2));
Gain3s = 20*log10(sqrt(abs(G_complex_cross3s(60:120,:)).^2 + abs(G_complex_co3s(60:120,:)).^2));

Gain4 = 20*log10(sqrt(abs(G_complex_cross4(60:120,:)).^2 + abs(G_complex_co4(60:120,:)).^2));
Gain4h = 20*log10(sqrt(abs(G_complex_cross4h(60:120,:)).^2 + abs(G_complex_co4h(60:120,:)).^2));
Gain4s = 20*log10(sqrt(abs(G_complex_cross4s(60:120,:)).^2 + abs(G_complex_co4s(60:120,:)).^2));

%export to text file to plot on Veusz
fidcov1 = fopen('Gain_n2.txt','wt');

fprintf(fidcov1,'Phi, Gain1_n2, Gain1h_n2, Gain1s_n2, Gain2_n2, Gain2h_n2, Gain2s_n2, Gain3_n2, Gain3h_n2, Gain3s_n2, Gain4_n2, Gain4h_n2, Gain4s_n2\n');
for i = 1:360
    fprintf(fidcov1,'%f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f\n',i-1, Gain1(31,i),Gain1h(31,i),Gain1s(31,i),...
        Gain2(31,i),Gain2h(31,i),Gain2s(31,i), Gain3(31,i),Gain3h(31,i),Gain3s(31,i), Gain4(31,i),Gain4h(31,i),Gain4s(31,i));
end
fclose(fidcov1);

y = [60 120];
x = [0 360];
colormap(jet(256))
figure(1)
subtightplot(4,3,1, [0.05 0.03], [0.1 0.01], [0.03 0.01])
imagesc(x,y,Gain1)
% colorbar
caxis([-20 10])
% xlabel('a1)','fontweight','bold','fontsize',13)
% ylabel('Antenna 1','fontweight','bold','fontsize',13)

subtightplot(4,3,2, [0.05 0.03], [0.1 0.01], [0.03 0.01])
imagesc(x,y,Gain1h)
% colorbar
caxis([-20 10])
% xlabel('a2)','fontweight','bold','fontsize',13)

subtightplot(4,3,3, [0.05 0.03], [0.1 0.01], [0.03 0.01])
imagesc(x,y,Gain1s)
% colorbar
caxis([-20 10])
% xlabel('a3)','fontweight','bold','fontsize',13)

subtightplot(4,3,4, [0.05 0.03], [0.1 0.01], [0.03 0.01])
imagesc(x,y,Gain2)
% colorbar
caxis([-20 10])
% xlabel('b1)','fontweight','bold','fontsize',13)
% ylabel('Antenna 2','fontweight','bold','fontsize',13)

subtightplot(4,3,5, [0.05 0.03], [0.1 0.01], [0.03 0.01])
imagesc(x,y,Gain2h)
% colorbar
caxis([-20 10])
% xlabel('b2)','fontweight','bold','fontsize',13)

subtightplot(4,3,6, [0.05 0.03], [0.1 0.01], [0.03 0.01])
imagesc(x,y,Gain2s)
% colorbar
caxis([-20 10])
% xlabel('b3)','fontweight','bold','fontsize',13)

subtightplot(4,3,7, [0.05 0.03], [0.1 0.01], [0.03 0.01])
imagesc(x,y,Gain3)
% colorbar
caxis([-20 10])
% xlabel('c1)','fontweight','bold','fontsize',13)
% ylabel('Antenna 3','fontweight','bold','fontsize',13)

subtightplot(4,3,8, [0.05 0.03], [0.1 0.01], [0.03 0.01])
imagesc(x,y,Gain3h)
% colorbar
caxis([-20 10])
% xlabel('c2)','fontweight','bold','fontsize',13)

subtightplot(4,3,9, [0.05 0.03], [0.1 0.01], [0.03 0.01])
imagesc(x,y,Gain3s)
% colorbar
caxis([-20 10])
% xlabel('c3)','fontweight','bold','fontsize',13)

subtightplot(4,3,10, [0.05 0.03], [0.1 0.01], [0.03 0.01])
imagesc(x,y,Gain4)
% colorbar
caxis([-20 10])
% xlabel('W/o finger','fontweight','bold','fontsize',13)
% ylabel('Antenna 4','fontweight','bold','fontsize',13)

subtightplot(4,3,11, [0.05 0.03], [0.1 0.01], [0.03 0.01])
imagesc(x,y,Gain4h)
% colorbar
caxis([-20 10])
% xlabel('W/ 1 finger','fontweight','bold','fontsize',13)

subtightplot(4,3,12, [0.05 0.03], [0.1 0.01], [0.03 0.01])
imagesc(x,y,Gain4s)
% colorbar
caxis([-20 10])
% xlabel('W/ 2 finger','fontweight','bold','fontsize',13)