clear all
close all

% load Formed_beam6.mat
load('scanningGain.mat')

% Gainbf = zeros(180,360,3,18);
% Gainbfmax = zeros(180,360,3);
% for i  = 1:3
%     for j = 1:18
%         Gainbf(:,:,i,j) = 10*log10(abs(G_complex_cobf(:,:,i,j)).^2 + abs(G_complex_crossbf(:,:,i,j)).^2);
%     end 
% end

% for i = 1:180
%     for j = 1:360
%         for k = 1:3
%             Gainbfmax(i,j,k) = max(Gainbf(i,j,k,:));
%         end
%     end
% end

%% making vector Gainmax out of matrix
Gainbfmaxt1 = maxGain';
Gainbfmaxt2 = maxGainh';
Gainbfmaxt3 = maxGains';
% making vector out of transpose result
Gainbfmaxline1 = Gainbfmaxt1(:);
Gainbfmaxline2 = Gainbfmaxt2(:);
Gainbfmaxline3 = Gainbfmaxt3(:);
% making possibility matrix because distance between point of a sphere is
% not the same
modify = zeros(length(Gainbfmaxline1),1);
sort1 = zeros(length(Gainbfmaxline1),1);
sort2 = zeros(length(Gainbfmaxline1),1);
sort3 = zeros(length(Gainbfmaxline1),1);
for i = 1:180
    for j = 1:360
        modify(360*(i-1) + j) = sin(deg2rad(i - 1));
    end
end
indexModify = modify/(sum(modify));
Gainbfmaxline1 = [Gainbfmaxline1 indexModify];
Gainbfmaxline2 = [Gainbfmaxline2 indexModify];
Gainbfmaxline3 = [Gainbfmaxline3 indexModify];

[~,idx1] = sort(Gainbfmaxline1(:,1)); % sort just the first column
sortGainbfmaxline1 = Gainbfmaxline1(idx1,:);   % sort the whole matrix using the sort indices
[~,idx2] = sort(Gainbfmaxline2(:,1)); % sort just the first column
sortGainbfmaxline2 = Gainbfmaxline2(idx2,:);   % sort the whole matrix using the sort indices
[~,idx3] = sort(Gainbfmaxline3(:,1)); % sort just the first column
sortGainbfmaxline3 = Gainbfmaxline3(idx3,:);   % sort the whole matrix using the sort indices

for i  = 1:length(Gainbfmaxline3)
    if i == 1
        sort1(i) = 1;
        sort2(i) = 1;
        sort3(i) = 1;
    else
        sort1(i) = sort1(i-1)- sortGainbfmaxline1(i-1,2);
        sort2(i) = sort2(i-1)- sortGainbfmaxline2(i-1,2);
        sort3(i) = sort3(i-1)- sortGainbfmaxline3(i-1,2);
    end
end

[a1,b1] = ecdf(Gainbfmaxline1(:,1));
[a2,b2] = ecdf(Gainbfmaxline2(:,1));
[a3,b3] = ecdf(Gainbfmaxline3(:,1));

% fid = fopen('Mymatrix.txt','wt');
% for ii = 1:180
%     for jj = 1:3
%         fprintf(fid,'%g,',Gainbfmax(91,ii,jj));
%     end
%     fprintf(fid,'\n');
% end
% 
% fclose(fid);

%%coverage efficiency
% 
% sortGainbfmaxline1 = sort(Gainbfmaxline1);
% sortGainbfmaxline2 = sort(Gainbfmaxline2);
% sortGainbfmaxline3 = sort(Gainbfmaxline3);

fidcov1 = fopen('coverageEff_n2.txt','wt');
fprintf(fidcov1,'cindex1_n2, cov1_n2, cindex2_n2, cov2_n2, cindex3_n2, cov3_n2\n');
for ii = 1:64800
    fprintf(fidcov1,'%f, %f, %f, %f, %f, %f\n',sort1(ii),sortGainbfmaxline1(ii),sort2(ii),sortGainbfmaxline2(ii),sort3(ii),sortGainbfmaxline3(ii));
end

fclose(fidcov1);

% figure(1)
% hold on
% plot(1:180, Gainbfmax(91,1:180,1), 'LineWidth',2)
% plot(1:180, Gainbfmax(91,1:180,2), 'LineWidth',2)
% plot(1:180, Gainbfmax(91,1:180,3), 'LineWidth',2)
% hold off
% grid on
% grid minor

figure(2)
set(gcf,'DefaultAxesFontSize',40);
set(gcf,'Position',[0 100 1024 768]);
semilogy(b1,a1,'b','LineWidth',2)
grid on
grid minor
legend('w/o finger')

figure(3)
set(gcf,'DefaultAxesFontSize',40);
set(gcf,'Position',[0 100 1024 768]);
semilogy(b2,a2,'r','LineWidth',2)
grid on
legend('w/ 1 finger')

figure(4)
set(gcf,'DefaultAxesFontSize',40);
set(gcf,'Position',[0 100 1024 768]);
semilogy(b3,a3,'g','LineWidth',2)
grid on
legend('w/ 2 finger')

figure(5)
hold on
plot(sortGainbfmaxline1(:,1), sort1)
plot(sortGainbfmaxline2(:,1), sort2)
plot(sortGainbfmaxline3(:,1), sort3)
hold off
grid on
legend('w/o finger','w/ 1 finger','w/ 2 finger')



% y = [60 120];
% x = [0 360];
% colormap(jet(256))
% figure(6)
% subtightplot(1,3,1, [0.05 0.03], [0.2 0.01], [0.03 0.01])
% imagesc(x,y,Gainbfmax(60:120,:,1))
% % colorbar
% caxis([-35 6])
% xlabel('No finger','fontweight','bold','fontsize',13)
% 
% subtightplot(1,3,2, [0.05 0.03], [0.2 0.01], [0.03 0.01])
% imagesc(x,y,Gainbfmax(60:120,:,2))
% % colorbar
% caxis([-35 6])
% xlabel('1 finger','fontweight','bold','fontsize',13)
% 
% subtightplot(1,3,3, [0.05 0.03], [0.2 0.01], [0.03 0.01])
% imagesc(x,y,Gainbfmax(60:120,:,3))
% % colorbar
% caxis([-35 6])
% xlabel('2 finger','fontweight','bold','fontsize',13)
% 
