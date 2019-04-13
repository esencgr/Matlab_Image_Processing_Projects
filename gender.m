clc
close all
 
FDetect = vision.CascadeObjectDetector;
resim1 = imread('lena.jpg');

%boyut ayarlanýyor
resim=imresize(resim1, [240 320]);

% yüz belirleniyor
BB = step(FDetect,resim);
figure,
subplot(4,4,1);
imshow(resim); hold on
for i = 1:size(BB,1)
rectangle('Position',BB(i,:),'LineWidth',1,'LineStyle','-','EdgeColor','r');
end
title('yüz belirlendi');
hold off;

% yüz kýrpýlýyor
yuz=imcrop(resim,BB);
subplot(4,4,2);
imshow(yuz);
title('yüz kýrpýldý');

%yüze gaus filtreleme ile canny yapýlýyor
yuz_gri=rgb2gray(yuz);
h = fspecial('gaussian',[3 3], 0.5);
yuz_filtre = filter2(h,yuz_gri)/255;
yuz_canny = edge(yuz_filtre(:,:,1),'canny');
subplot(4,4,3);
imshow(yuz_canny);
title('canny yüz');

% aðýz belirleniyor
MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',130);
BBb=step(MouthDetect,yuz);
subplot(4,4,4);
imshow(yuz);
title('aðýz belirleme');
hold on
for i = 1:size(BBb,1)
rectangle('Position',BBb(i,:),'LineWidth',1,'LineStyle','-','EdgeColor','r');
end
hold off;

% aðýz kýrpýlýyor
agiz=imcrop(yuz,BBb); %AÐIZ
subplot(4,4,5);
imshow(agiz);
title('aðýz kýrpýldý');

%aðýza gaus filtreleme ile canny yapýlýyor
agiz_gri=rgb2gray(agiz);
h = fspecial('gaussian',[3 3], 0.5);
agiz_filtre = filter2(h,agiz_gri)/255;
agiz_canny = edge(agiz_filtre(:,:,1),'canny');
subplot(4,4,6);
imshow(agiz_canny);
title('canny aðýz');

% göz belirleniyor
EyeDetect = vision.CascadeObjectDetector('EyePairBig');
BBa=step(EyeDetect,yuz);
subplot(4,4,7);
imshow(yuz);
title('göz belirlendi');
rectangle('Position',BBa,'LineWidth',1,'LineStyle','-','EdgeColor','b');

% göz kýrpýlýyor
goz=imcrop(yuz,BBa);
subplot(4,4,8);
imshow(goz);
title('göz kýrpýldý');

%göze gaus filtreleme ile canny yapýlýyor
goz_gri=rgb2gray(goz);
h2 = fspecial('gaussian',[3 3], 0.5);
goz_filtre = filter2(h2,goz_gri)/255;
goz_canny = edge(goz_filtre(:,:,1),'canny');
subplot(4,4,9);
imshow(goz_canny);
title('canny göz');

% burun belirleniyor
NoseDetect = vision.CascadeObjectDetector('Nose','MergeThreshold',45);
BBs=step(NoseDetect,yuz);
subplot(4,4,10);
imshow(yuz); hold on
for i = 1:size(BBs,1)
rectangle('Position',BBs(i,:),'LineWidth',1,'LineStyle','-','EdgeColor','b');
end
title('burun belirleniyor');
hold off;

% burun kýrpýlýyor
burun=imcrop(yuz,BBs);
subplot(4,4,11);
imshow(burun);
title('burun kýrpýldý');

% buruna gaus filtreleme ile canny yapýlýyor
burun_gri=rgb2gray(burun);
h3 = fspecial('gaussian',[3 3], 0.5);
burun_filtre = filter2(h3,burun_gri)/255;
burun_canny = edge(burun_filtre(:,:,1),'canny');
subplot(4,4,12);
imshow(burun_canny);
title('canny burun');

%göz pixellerinin sayýmý
bw1=bwareaopen(goz_canny,50);
subplot(4,4,13);
imshow(bw1);
title('göz pixelin sayýmý')
gozpixelsayisi=bwconncomp(goz_canny,4);
goz_deger = bweuler(goz_canny,8);

%aðýz pixellerinin sayýmý
bw2 = bwareaopen(agiz_canny, 50);
subplot(4,4,14);
imshow(bw2);
title('agiz pixelin sayimi');
dudakpixelsayisi = bwconncomp(agiz_canny,8);
agiz_deger = bweuler(agiz_canny,8);

% burun pixellerinin sayýmý
bw3 = bwareaopen(burun_canny, 50);
subplot(4,4,15);
imshow(bw3);
title('burun pixelin sayimi');
burunpixelsayisi = bwconncomp(burun_canny,8);
burun_deger = bweuler(burun_canny,8);

%yüz pixellerinin sayýmý
bw3 = bwareaopen(yuz_canny,50);
subplot(4,4,16);
imshow(bw3);
title('yuz pixelin sayimi');
yuz_pixelsayisi = bwconncomp(yuz_canny,8);
yuz_deger = bweuler(yuz_canny,8);
 
goz_agiz_toplam= goz_deger+agiz_deger;
goz_burun_toplam= burun_deger+agiz_deger;
goz_agiz_burun_toplam= goz_deger+agiz_deger+burun_deger;
 
% oranlamalar
goz_yuz_orani= goz_deger/yuz_deger
agiz_yuz_orani= agiz_deger/yuz_deger
burun_yuz_orani= burun_deger/yuz_deger
goz_agiz_yuz_orani= goz_agiz_toplam/yuz_deger
goz_burun_yuz_orani= goz_burun_toplam/yuz_deger
goz_agiz_burun_yuz_orani= goz_agiz_burun_toplam/yuz_deger
 
fark1=goz_agiz_burun_yuz_orani-goz_burun_yuz_orani
fark2=goz_agiz_burun_yuz_orani-burun_yuz_orani
fark3=goz_agiz_burun_yuz_orani-goz_yuz_orani

% sýnamalar
 if((fark1<0.2274=fark2=fark3=>0.37))
  figure,imshow(resim);
  title('cinsiyet=erkek');
  disp('cinsiyet=erkek');
 else if 
   figure,imshow(resim);
   title('cinsiyet=bayan');
   disp('cinsiyet=bayan');    
  
end
end
