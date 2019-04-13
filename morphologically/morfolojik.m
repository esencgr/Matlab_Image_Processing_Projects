bw = imread('resim1.PNG');
lvl=graythresh(bw);
bw=im2bw(bw,lvl);
se = strel('line',11,70);
se1 = strel('disk',30);
bw2 = imdilate(bw,se);
bw3 = imerode(bw,se1);
subplot(231), imshow(bw), title('Original')
subplot(232), imshow(bw2), title('Dilate sonucu')
subplot(233), imshow(bw3), title('erode sonucu')