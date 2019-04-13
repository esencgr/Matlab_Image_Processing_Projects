clear all;
clc
% image = imread('Fig0314(a)(100-dollars).tif');
% for i=1:8
% imgbin=bitget(image,i);
% figure
% imshow(imgbin,[])
% end
image = imread('Fig0309(a)(washed_out_aerial_image).tif');
gamma = [0.05,0.2,0.67,1.5,2.5,5];
imageiki=im2double(image).^(gamma(6));
imagesc(imageiki)