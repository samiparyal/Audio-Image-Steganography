clear; clc;

% Read the original and modified images
originalImg = imread('demo.png');
modifiedImg = imread('modified.png');

% Calculate the absolute difference between the images
diffImg = abs(double(originalImg) - double(modifiedImg));

% Display the original, modified, and difference images
figure;
subplot(2,2,1);
imshow(originalImg);
title('Original Image');

subplot(2,2,2);
imshow(modifiedImg);
title('Modified Image with Embedded Audio');

subplot(2,2,3);
imshow(diffImg, []);
title('Pixel Differences: Original vs Modified');

% Calculate the total change per pixel by summing across color channels
totalChange = sum(diffImg, 3);

% Plotting a heatmap of the total change
subplot(2,2,4);
imagesc(totalChange);
title('Heatmap of Pixel Changes');
xlabel('Horizontal Position (pixels)');
ylabel('Vertical Position (pixels)');
colorbar;
axis image;
