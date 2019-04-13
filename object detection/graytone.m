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
    img =rgb2gray( data );
    imshow(img,'Parent',hmain); % resmin gri hali
stop (video);
