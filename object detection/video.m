hardwareInfo=imaqhwinfo; % Kamera donanýmý hakkýnda gerekli bilgilerin alýnmasý
[camera_name, camera_id, format]=cameraInfo(hardwareInfo); % Donaným bilgilerinden kameranýn özelliklerinin ayýklanmasý
memoryInfo=imaqmem; % Bilgisayarýn bellek bilgisinin alýnmasý
imaqmem(memoryInfo.AvailPhys); % Kullanýma müsait bütün belleðin görüntü  iþleme iþlemleri için kullanýlabilir hale getirilmesi
video = videoinput(camera_name, camera_id, format); % Kamera özelliklerine göre video objesinin oluþturulmasý
 
set(video, 'FramesPerTrigger', Inf); % Videonun sürekli frame almasý için gerekli düzeltme
set(video, 'ReturnedColorspace', 'rgb'); % Videonun rgb uzayda dönmesi için gerekli ayarlama
video.FrameGrabInterval = 1; % Videodan ne kadar sýklýkla frame çekileceði.
 
start(video); % Videonun baþlatýlmasý
preview(video);
stop (video);
