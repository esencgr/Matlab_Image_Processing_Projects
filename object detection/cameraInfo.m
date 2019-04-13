function [camera_name, camera_id, resolution] = cameraInfo(hardwareInfo)
    % Donaným bilgisine göre kameranýn isminin, bilgilerinin, çözünürlük
    % deðerlerinin alýnmasý.
    camera_name = char(hardwareInfo.InstalledAdaptors(end));
    camera_info = imaqhwinfo(camera_name);
    camera_id = camera_info.DeviceInfo.DeviceID(end);
    resolution = char(camera_info.DeviceInfo.SupportedFormats(end-2));
    % Burada çözünürlük deðerlerinden sondan 2 önceki deðer seçiliyor.
    % Çünkü kullandýðýmýz kamerada istenen çözünürlük (800x600) bu deðere denk geliyor.
end