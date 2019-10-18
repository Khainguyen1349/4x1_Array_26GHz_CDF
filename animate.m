% load('C:\Users\NGUYEN Khai\Documents\MATLAB\Measured Data at Nice\Khai_oldexport\beam6\Formed_beam6.mat')
a = 1;
while 1
    if a == 17
        a = 1;
    else
        a = a + 1;
    end
    name = strcat('Beam',str2double(a));
    imagesc(10*log10(sqrt(abs(G_complex_cobf(:,:,1,a)).^2 + abs(G_complex_crossbf(:,:,1,a)).^2)));
    xlabel(name);
    pause(0.5)
end