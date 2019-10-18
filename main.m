%% Main function
clear all
close all
clc

% Number of formed beams desired starting from 0
nbform = 18;
res = 11.25;

for i = 6
    mkdir(strcat('beam',num2str(i)));
    processtext(i);
    beamforming(i,nbform, res);
end