clc;
clear;
Ii=imread('SourceImage/theater1_input.jpg');
Iigrey=rgb2gray(Ii);
% Indices=zeros((size(Ii,1)*size(Ii,2)),2);
% k=1;
% for i=1:size(Ii,1)
%     for j=1:size(Ii,2)
%         Indices(k,1)=i;
%         Indices(k,2)=j;
%         k=k+1;
%     end
% end
close all
row=size(Ii,1);
col=size(Ii,2);
patch=Iigrey(1:32,1:32);
cell_sz=[16 16];
block_sz=[2 2];
num_bins=8;
%block_overlap=[4 4];
%hog1=extractHOGFeatures(patch,'BlockSize',block_sz,'CellSize',cell_sz,'BlockOverlap',block_overlap);
[hog1,ptVis]=extractHOGFeatures(patch,'BlockSize',block_sz,'CellSize',cell_sz,'NumBins',num_bins);
     figure;
     imshow(patch); hold on;
     plot(ptVis, 'Color','green');
size(hog1)
