clear all
clc
image=imread('resim.tif');
cozum=input('Çözümü Ýstediðiniz Ödev Þýkkýný Giriniz (2,3,4); ');
switch cozum
    case 2
disp(image);
    case 3
figure;
subplot(1,2,1);imshow(image);
title('Orjinal');
image(image<120)=0;
image(image>120)=255;
disp(image);
subplot(1,2,2);imshow(image);
title('Ýki Renk');
    case 4
figure;
subplot(1,2,1);imshow(image);
title('Orjinal');
image(image<=50)=50;
image(image>50&image<=100)=100;
image(image>100&image<=150)=150;
image(image>150&image<=200)=200;
image(image>200)=255;
title('5 Renk');
subplot(1,2,2);imshow(image);
    otherwise
        disp('Lütfen Geçerli Bir Çözüm Þýkký Seçiniz')
end