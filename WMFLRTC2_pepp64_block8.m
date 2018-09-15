%%aggregation weight
%inpainting
%%
clear all; close all; clc;
getd = @(p)path(path,p);% Add some directories to the path
getd('.\MFLRTC_ulities\');
getd('.\hosvd_ulities\');
getd('.\ulities\');
getd('.\FOE_ulities201696\');
getd('.\inpaintingmask\');
getd('./image\');
FOEkernels = load('FOE_ulities201696/csf_5x5sigma15.mat');
FOEfilters = reshape(FOEkernels.model.f,[prod(size(FOEkernels.model.f)),1]); 
clear FOEkernels;
%% 
M0=double(imread('pepp_org_64.pgm'));
I1 =  M0;
%% %%%%%%
Q1=zeros(size(I1));
 Q1(28:36,28:36)=1;
 Q1=1-Q1;
Q1=double(Q1);
figure(1);imshow(Q1.*M0,[]);
[m,n] = size(M0);
fprintf('rate:%f\n',sum(Q1(:))./(size(Q1,1)*size(Q1,2)))
figure(2); imshow(M0,[]);
I11 = image_reconstruct(I1,~Q1);%(0-128)
figure(455); imshow(I11,[]);
%initializing simulation metrics
%% WMFLRTC%%%%%%%%
par.num          = 150;  %300; %
par.FOEfilters   =  FOEfilters;
par.numfilter    =  128; %
par.mu2          =22.2; %22.2
par.Threshvalue  =  0.005; %0.001; %0.1;%
par.win          =  4; %4
par.nblk         =  45;
par.l            =4;%tensor Numbel
par.n            =  par.numfilter/par.l;%tensor
par.step         =   min(6, par.win-1);
par.p            =   1;
par.l1flag       =  0; 
par.nomvalue     =  0.01;
[Iout1,param1]   =  AW_inpaint(I1, I11, Q1, par);
param1.Im        =   Iout1;


