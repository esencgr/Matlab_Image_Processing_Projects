hardwareInfo=imaqhwinfo; % Kamera donanýmý hakkýnda gerekli bilgilerin alýnmasý
[camera_name, camera_id, format]=cameraInfo(hardwareInfo); % Donaným bilgilerinden kameranýn özelliklerinin ayýklanmasý
memoryInfo=imaqmem; % Bilgisayarýn bellek bilgisinin alýnmasý
imaqmem(memoryInfo.AvailPhys); % Kullanýma müsait bütün belleðin görüntü  iþleme iþlemleri için kullanýlabilir hale getirilmesi
video = videoinput(camera_name, camera_id, format); % Kamera özelliklerine göre video objesinin oluþturulmasý
 
set(video, 'FramesPerTrigger', Inf); % Videonun sürekli frame almasý için gerekli düzeltme
set(video, 'ReturnedColorspace', 'rgb'); % Videonun rgb uzayda dönmesi için gerekli ayarlama
video.FrameGrabInterval = 1; % Videodan ne kadar sýklýkla frame çekileceði.
 
start(video); % Videonun baþlatýlmasý
% Çözünürlüðün dinamik olarak ayarlanmasý
resolutionY = str2double(format(strfind(format,'_')+1:strfind(format,'x')-1));
resolutionX = str2double(format(strfind(format,'x')+1:length(format)));
% Deðiþkenlerin ön tanýmlanmasý
hmain = gca;
img = zeros(resolutionX,resolutionY);
imgSize = resolutionX*resolutionY;
threshold = 33; % Mavi renk katmanýndan ne kadar mavi olan renklerin seçileceðinin eþik deðeri
preview(video);
data = getsnapshot(video); % Videodan ekran görüntüsü alýnmasý
    img = imsubtract(data(:,:,3), rgb2gray(data)); % Mavi resim katmanýndan gri katmanýn çýkarýlmasý
    img = medfilt2(img, [9 9]); % 9x9 Median filtresi uygulanmasý
    % Eþik deðerine göre renklerin ayýklanmasý
    img(img<threshold) = 0;
    img(img>=threshold) = 255;
    img = bwareaopen(img,(imgSize)/1200); % Küçük objelerin resimden ayýklanmasý (Resim alanýn 1200'de birinden küçük objeler atýlmaktadýr
    data(img>0) = 255; % Bulunan mavi bölgelerin resim üzerine boyanmasý
    imshow(data,'Parent',hmain); % Mavi objelerin boyanmýþ halde gösterilmesi
stop (video);
