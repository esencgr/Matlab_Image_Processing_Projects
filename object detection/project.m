%% Ön Tanýmlama Bölgesi
clc;
% Kolay kullaným açýsýndan deðiþkenleri silmeden durdurup tekrar
% çalýþtýrýlmasý için yapýlan kontrol. Böylelikle stop düðmesi ile program
% durdurulup, tekrar run ile kaldýðý yerden devam edilebilir
if(~exist('video','var'))
    hardwareInfo=imaqhwinfo; % Kamera donanýmý hakkýnda gerekli bilgilerin alýnmasý
    [camera_name, camera_id, format]=cameraInfo(hardwareInfo); % Donaným bilgilerinden kameranýn özelliklerinin ayýklanmasý
    memoryInfo=imaqmem; % Bilgisayarýn bellek bilgisinin alýnmasý
    imaqmem(memoryInfo.AvailPhys); % Kullanýma müsait bütün belleðin görüntü iþleme iþlemleri için kullanýlabilir hale getirilmesi
    video = videoinput(camera_name, camera_id, format); % Kamera özelliklerine göre video objesinin oluþturulmasý
    %% Videonun ve bulunan objelerin gösterilmesi için gerekli figure'lerin açýlmasý
    figure;
    hmain = gca;
    f=figure;
    % Durdurma Butonu
    isRunning = 1;
    u=uicontrol('String','Stop','Callback','isRunning = 0; disp(''Hesaplamalar Durduruldu.'')',...                                                                                                             %
    'ForegroundColor','w','BackgroundColor','r','Fontsize',14,'FontWeight','Demi','Position',[1 1 60 60]); 
    set(u,'position',[1 1 60 60])
    %stop butonunun görünümü ile ilgili yazý ve 
    %butonun büyüklük ve pozisyon ayarlarý 
    hsub = zeros(1,16);           %bulunan ve gösterilecek olan maksimium nesne sayýsýnýn belirlenmesi 
    for i = 1:16                  %ve gerekli figure pencerelerinin açýlmasý
         hsub(i) = subplot(4,4,i);
    end
else
    isRunning = 1;
    stop(video);                      %videonun durdurulmasý 
    flushdata(video);                 %belleðin boþaltýlmasý
end
%% Ana Döngüde kullanýlan Deðiþkenlerin Tanýmlanmasý
% ("doc framegrabinterval" komutundaki þekil incelerek bu kýsýmýn iþleyiþi hakkýnda bilgi edinilmiþtir .)
set(video, 'FramesPerTrigger', Inf); % Videonun sürekli frame almasý için gerekli düzeltme
set(video, 'ReturnedColorspace', 'rgb'); % Videonun rgb uzayda dönmesi için gerekli ayarlama
video.FrameGrabInterval = 1; % Videodan ne kadar sýklýkla frame çekileceði.

start(video); % Videonun baþlatýlmasý
% Çözünürlüðün dinamik olarak ayarlanmasý
resolutionY = str2double(format(strfind(format,'_')+1:strfind(format,'x')-1));
resolutionX = str2double(format(strfind(format,'x')+1:length(format)));
% Deðiþkenlerin ön tanýmlanmasý
img = zeros(resolutionX,resolutionY);
imgSize = resolutionX*resolutionY;
objPosition = zeros(3,3,16);
filledImage = cell(16,1);
boundingBox = cell(16,1);
centroid = cell(16,1);
area = zeros(16,2);
threshold = 33; % Mavi renk katmanýndan ne kadar mavi olan renklerin seçileceðinin eþik deðeri

%% Asýl Video Döngüsü
while isRunning
    data = getsnapshot(video); % Videodan ekran görüntüsü alýnmasý
    img = imsubtract(data(:,:,3), rgb2gray(data)); % Mavi resim katmanýndan gri katmanýn çýkarýlmasý
    img = medfilt2(img, [9 9]); % 9x9 Median filtresi uygulanmasý
    % Eþik deðerine göre renklerin ayýklanmasý
    img(img<threshold) = 0;
    img(img>=threshold) = 255;
    img = bwareaopen(img,(imgSize)/1200); % Küçük objelerin resimden ayýklanmasý (Resim alanýn 1200'de birinden küçük objeler atýlmaktadýr)
    
    data(img>0) = 255; % Bulunan mavi bölgelerin resim üzerine boyanmasý
    imshow(data,'Parent',hmain); % Mavi objelerin boyanmýþ halde gösterilmesi
    
    hold(hmain,'on')
    
    [Label, Count] = bwlabel(img, 4); % 4 Komþuluðuna göre baðlý bileþenlerin bulunmasý (8 komþuluðu ile ayný sonucu daha hýzlý saðlamakta)
    clc
    disp(['Count = ' num2str(Count)]);
    stats = regionprops(logical(Label),'BoundingBox','Centroid','FilledImage','Area'); % Baðlý bileþenlerin özelliklerinin çýkarýlmasý
    
    if(exist('stats','var')) % Herhangi bir obje bulunmasý durumunda
        for object = 1:length(stats) % Bulunan her obje için
            if(object < 16 && object > 0) % Obje sayýsý sýnýrlamasý
                boundingBox{object} = stats(object).BoundingBox; % Objeyi çevreleyen dikdörtgenin koordinatlarý
                centroid{object} = stats(object).Centroid; % Objenin merkez noktasý koordinatlarý
                area(object,2) = stats(object).Area; % Objenin alaný
                if(area(object,2) >= 0) % Objenin alanýnýn kontrolüne göre önceki alan bilgisinin güncellenmesi
                    area(object,1) = area(object,2);
                end
                
                % Objenin bir önceki konumundan ne kadar uzaklaþtýðýnýn hesaplanmasý
                dx=round(objPosition(2,1,object)-objPosition(1,1,object));
                dy=round(objPosition(2,2,object)-objPosition(1,2,object));
                
                filledImage{object} = stats(object).FilledImage; % Objenin küçük resminin alýnmasý
                rectangle('Position',boundingBox{object},'EdgeColor','r','LineWidth',2,'Parent',hmain) % Objenin etrafýna dikdörtgen çizilmesi
                plot(hmain,centroid{object}(1),centroid{object}(2), ' ys','MarkerSize',6,'MarkerFaceColor','y') % Merkez noktasýna sarý iþaretçi konulmasý
                imshow(filledImage{object},'Parent',hsub(object)) % Bulunan küçük resimlerin ikinci grafiðe çizilmesi
                title(hsub(object),[num2str(object) '. Obje']); % Objelerin baþlýklarýnýn atanmasý
                objPosition(1,:,object) = objPosition(2,:,object); % Objenin eski konumunun güncellenmesi
                objPosition(2,:,object) = [centroid{object}(1),centroid{object}(2),area(object,2)/imgSize]; % Objenin yeni konumunun bulunmasý
                
              
                if(length(stats) == 1) % Tek obje bulunmasý durumunda
                    % Objenin konumlarýnýn bulunmasýn ve tek obje olmasý
                    % durumunda hýz ,konum ,alan bilgileri
                   
                    x = boundingBox{object}(1);
                    y = boundingBox{object}(2);
              
                    txtInfo = text(centroid{object}(1)+15,centroid{object}(2),...
                    [num2str(object) '. X: ' num2str(round(centroid{object}(1))) ' Y: ' num2str(round(centroid{object}(2)))],'Parent',hmain);
                    txtSpeed = text(centroid{object}(1),centroid{object}(2)+15,...
                    [' dx: ' num2str(dx) ' dy: ' num2str(dy) '  area: ' num2str(round(area(object,2)))],'Parent',hmain);
                    set(txtInfo, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
                    set(txtSpeed, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
                    % Gürültüden veya objenin engel arkasýna gitmesindendolayý alandaki deðiþikliklerin ekarte edilmesi
                    % bu kýsým tek obje olmasý durumunda hesaplanabileceðinden
                    % if else kullanýlarak ayrýca belirtildi     
                   
                    if(area(object,2)/area(object,1) >= 0.9 && area(object,2)/area(object,1) <= 1.1)
                        theImage = stats(object).FilledImage;
                    end
                    
                    
                else % Birden fazla obje olmasý durumunda
                    % Hýz, Konum, Alan bilgilerinin kullanýcýya gösterilmesi
                    txtInfo = text(centroid{object}(1)+15,centroid{object}(2), [num2str(object)...
                        '. X: ' num2str(round(centroid{object}(1))) '   Y: ' num2str(round(centroid{object}(2)))],'Parent',hmain);
                    txtSpeed = text(centroid{object}(1),centroid{object}(2)+15, ['   dx: ' num2str(dx)...
                        '   dy: ' num2str(dy) '  area: ' num2str(round(area(object,2)))],'Parent',hmain);
                    set(txtInfo, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
                    set(txtSpeed, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
                end
            end
        end
    end
    
    % Objenin bilgileri varsa fakat ekranda hiç obje yoksa cismin
    % hareketinin tahmini
    if(exist('object','var') && exist('x','var') && exist('y','var') && length(stats) < 1)
        % Cismin sabit hýzla ayný yönde gittiði tahmin edilerek bir sonraki
        % konumunun hesaplanmasý
        x=x+dx;
        y=y+dy;
        % Bulunan konuma küçük resmin çizilmesi
        image(x,y,theImage*255,'Parent',hmain);
    end
    
    drawnow
    hold(hmain,'off')
    
    % Performans açýsýndan RAM'in dolmamasý için belleðin her 100 kare
    % alýndýðýnda bir sýfýrlanmasý
    if mod(video.FramesAcquired,100)==0
        flushdata(video);
    end
end

% Stop düðmesine basýldýktan sonra döngünden çýkýp videoyu durdurup
% belleðin boþaltýlmasý
stop(video);
flushdata(video);
