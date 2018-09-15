%% MFLRFOE
%inpainting
%%
clear all; close all; clc;
getd = @(p)path(path,p);% Add some directories to the path
getd('.\MFLRTC_ulities\');
getd('.\hosvd_ulities\');
getd('.\ulities\');
getd('.\FOE_ulities\');
getd('.\inpaintingmask\');
getd('./image\');
FOEkernels = load('FOE_ulities/csf_5x5sigma15.mat');
FOEfilters = reshape(FOEkernels.model.f,[prod(size(FOEkernels.model.f)),1]); 
clear FOEkernels;
%%
I1=double(imread('tile_org_64.pgm'));
load S_85list_mask;mask=S_85list_mask;
Q1=mask;
Q1=double(Q1);
figure(1);imshow(Q1,[]);
[m,n] = size(I1);
fprintf('rate:%f\n',sum(Q1(:))./(size(Q1,1)*size(Q1,2)))
figure(2); imshow(I1,[]);

%% 
 I11 = image_reconstruct(I1,~Q1);%(0-128)
figure(455); imshow(I11,[]);
%initializing simulation metrics
%% MFLRTC
par.num          = 100;  
par.FOEfilters   =   FOEfilters;
par.numfilter    =  64; %16; %64; 
par.mu2          =22.2; %22.2
par.Threshvalue  =   0.005; %0.001; %0.1;
par.win          =   4; %4
par.nblk         =   45;
par.step         =   min(6, par.win-1);
par.p            =   1;
par.l1flag       =  0; 
par.nomvalue     =   0.01;
[Iout1,param1]   =   MFLRTC_inpaint(I1, I11, Q1, par);
param1.Im        =   Iout1;
% [param1.InputPSNR, param1.PSNR0, param1.PSNR(end)]


