% load('cc2.mat');
% load('cc1.mat');
close all;
I = imread('crop1.jpg'); % test with dc pictures here
I2 = imread('crop2.jpg');

imshow(I);
points1 = ginput(4)';

figure;
imshow(I2);
points2 = ginput(4)';
%save('points.mat','points1','points2');


points1 = cc1
points2 = cc2

x = computeH(points1, points2);

[d,f] = warpImage(I, I2, x); 
figure;
imshow(d);
figure;
imshow(f);