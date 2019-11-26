clear all
close all

load KhaiSimulHFSS_Finger_MultiFrequency.mat

% Gainbf = zeros(180,360,18,5);
Gainbfmax = zeros(180,360,5);
% for i = 1:5
%     for j = 1:18
%         Gainbf(:,:,j,i) = 10*log10(abs(G_complex_cobf(:,:,j,i)).^2 + abs(G_complex_crossbf(:,:,j,i)).^2);
%     end 
% end
Gainbf = 10*log10(abs(G_complex_cobf).^2 + abs(G_complex_crossbf).^2);

for n = 1:5
    for i = 1:180
        for j = 1:360
            Gainbfmax(i,j,n) = max(Gainbf(i,j,:,n));
        end
    end
end

%% making vector Gainmax out of matrix
Gainbfmaxt1 = Gainbfmax(:,:,1)';
Gainbfmaxt2 = Gainbfmax(:,:,2)';
Gainbfmaxt3 = Gainbfmax(:,:,3)';
Gainbfmaxt4 = Gainbfmax(:,:,4)';
Gainbfmaxt5 = Gainbfmax(:,:,5)';

% making vector out of transpose result
Gainbfmaxline1 = Gainbfmaxt1(:);
Gainbfmaxline2 = Gainbfmaxt2(:);
Gainbfmaxline3 = Gainbfmaxt3(:);
Gainbfmaxline4 = Gainbfmaxt4(:);
Gainbfmaxline5 = Gainbfmaxt5(:);


% making possibility matrix because distance between point of a sphere is
% not the same
modify = zeros(length(Gainbfmaxline2),1);
sort1 = zeros(length(Gainbfmaxline1),1);
sort2 = zeros(length(Gainbfmaxline2),1);
sort3 = zeros(length(Gainbfmaxline3),1);
sort4 = zeros(length(Gainbfmaxline4),1);
sort5 = zeros(length(Gainbfmaxline5),1);

for i = 1:180
    for j = 1:360
        modify(360*(i-1) + j) = sin(deg2rad(i - 1));
    end
end

indexModify = modify/(sum(modify));
Gainbfmaxline1 = [Gainbfmaxline1 indexModify];
Gainbfmaxline2 = [Gainbfmaxline2 indexModify];
Gainbfmaxline3 = [Gainbfmaxline3 indexModify];
Gainbfmaxline4 = [Gainbfmaxline4 indexModify];
Gainbfmaxline5 = [Gainbfmaxline5 indexModify];

[~,idx1] = sort(Gainbfmaxline1(:,1)); % sort just the first column
[~,idx2] = sort(Gainbfmaxline2(:,1));
[~,idx3] = sort(Gainbfmaxline3(:,1));
[~,idx4] = sort(Gainbfmaxline4(:,1));
[~,idx5] = sort(Gainbfmaxline5(:,1));

sortGainbfmaxline1 = Gainbfmaxline1(idx1,:);   % sort the whole matrix using the sort indices
sortGainbfmaxline2 = Gainbfmaxline2(idx2,:);
sortGainbfmaxline3 = Gainbfmaxline3(idx3,:);
sortGainbfmaxline4 = Gainbfmaxline4(idx4,:);
sortGainbfmaxline5 = Gainbfmaxline5(idx5,:);

for i  = 1:length(Gainbfmaxline2)
    if i == 1
        sort1(i) = 1;
        sort2(i) = 1;
        sort3(i) = 1;
        sort4(i) = 1;
        sort5(i) = 1;
    else
        sort1(i) = sort1(i-1)- sortGainbfmaxline1(i-1,2);
        sort2(i) = sort2(i-1)- sortGainbfmaxline2(i-1,2);
        sort3(i) = sort3(i-1)- sortGainbfmaxline3(i-1,2);
        sort4(i) = sort4(i-1)- sortGainbfmaxline4(i-1,2);
        sort5(i) = sort5(i-1)- sortGainbfmaxline5(i-1,2);
    end
end

% [a2,b2] = ecdf(Gainbfmaxline2(:,1));

% fid = fopen('Mymatrix.txt','wt');
% for ii = 1:180
%         fprintf(fid,'%g,',Gainbfmax(ii,91));
%     fprintf(fid,'\n');
% end
% 
% fclose(fid);

%coverage efficiency
sortGainbfmaxline1 = sort(Gainbfmaxline1);
sortGainbfmaxline2 = sort(Gainbfmaxline2);
sortGainbfmaxline3 = sort(Gainbfmaxline3);
sortGainbfmaxline4 = sort(Gainbfmaxline4);
sortGainbfmaxline5 = sort(Gainbfmaxline5);

% figure(3)
% set(gcf,'DefaultAxesFontSize',40);
% set(gcf,'Position',[0 100 1024 768]);
% semilogy(b2,a2,'r','LineWidth',2)
% grid on
% legend('w/ 1 finger')

figure(5)
hold on
plot(sortGainbfmaxline1(:,1), sort1)
plot(sortGainbfmaxline2(:,1), sort2)
plot(sortGainbfmaxline3(:,1), sort3)
plot(sortGainbfmaxline4(:,1), sort4)
plot(sortGainbfmaxline5(:,1), sort5)
hold off
grid on
legend('24GHz','25GHz','26GHz','27GHz','28GHz')
savefig('RotatedAntenna_FullyCover.fig')
