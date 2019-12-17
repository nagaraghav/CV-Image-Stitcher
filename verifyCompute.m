
close all;
I = imread('crop1.jpg');
I2 = imread('crop2.jpg');

points1 = cc1;
points2 = cc2;

x = computeH(points1, points2);


subplot(1,2,1);
imshow(I);
axis on
hold on;
points = ginput(5);

for i = 1:5
    plot(points(i,1),points(i,2),'r+', 'MarkerSize', 5, 'LineWidth', 1);
end

subplot(1,2,2);
imshow(I2);
axis on
hold on;

for i = 1:5
    pHat = x * [points(i,1);points(i,2);1]
    xHat = pHat(1)/pHat(3)
    yHat = pHat(2)/pHat(3)
    plot(xHat,yHat,'r+', 'MarkerSize', 5, 'LineWidth', 1);
end


