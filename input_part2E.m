% load('cc2.mat');
% load('cc1.mat');
close all;
I = imread('c3p1.jpg'); 
I2 = imread('c3p2.jpg');

imshow(I);
points1 = ginput(6)';

figure;
imshow(I2);
points2 = ginput(6)';
%save('points.mat','points1','points2');-


x = computeH(points1, points2);

[d,f] = warpImage(I, I2, x); 
figure;
imshow(d);
figure;
imshow(f);