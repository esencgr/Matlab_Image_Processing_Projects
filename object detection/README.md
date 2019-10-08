# OBJECT DETECTİON PROJECT FINAL DOCUMENTS


 ## Özet: 
Günümüzde görüntü işleme ile ilgili teknolojiler hızla gelişen ve dünya standartlarını önünde sürükleyen sistemlerin gelişmesini sağlamıştır.  Askeri, sivil, bilimsel amaçlı birçok alanda kullanılmakta olup bu alanların gelişiminde çok önemli bir yere sahip olduğu yadsınamamaktadır. Gözetleme sistemleri temelinde bilgisayar bilimleri kapsamındaki video ve görüntü işleme araştırma alanları bulunmaktadır. Video işleme, belirli bir video görüntüsünde var olan sahne içerisindeki değişimleri incelemede kullanılabilecek çeşitli yöntemleri içermektedir. Günümüzde video işleme bilgisayar bilimlerinin en önemli araştırma alanlarından birisidir. İki-boyutlu videolar; çoklu ortam içerik tabanlı endekslemede, bilgi elde etmede, görsel gözetleme ve dağıtık çapraz-kamera ile gözetleme sistemlerinde, insan takibi, trafik izleme ve benzeri uygulamalardaki çeşitli bölütleme, nesne tespit ve takibinde kullanılmaktadır. 




## 1. GİRİŞ 


Teknolojik gelişmeler her alanda olduğu gibi görüntü ve video işleme konularında da çığ gibi artan bir şekilde büyümektedir. Bu gelişim son 40 yıldır teknolojideki gelişmelere paralel olarak daha da artmıştır. Bilgisayarların giderek boyutlarının küçülmesi, bellek kapasitelerinin ve veri işleme hızlarının artışı görüntü işleme teknolojilerindeki gelişmeyi hızlandırmıştır. Boyutların küçülmesi ile birlikte görüntü işleme uygulamaları cep telefonlarından fotoğraf makinelerine, askeri  uygulamalardan  sağlık  alanına birçok alanda kullanılmaktadır. Görüntülerde hareketli nesnelerin takip edilmesi bilgisayarlı görme uygulamalarındaki  önemli  konulardan  biridir. Hareket tespiti ve analizi konusunda yapılmış çok sayıda farklı uygulamalar vardır. Örneğin askeri uygulamalar kapsamında hareketli bir hedefin takip edilerek imha edilmesi, ulusal güvenlik için akıllı silahların geliştirilmesi açısından büyük bir önem taşımaktadır. Benzer şekilde hassas güvenlikli ortamlardaki insan aktivitelerinin otomatik olarak yorumlanabilmesi, insanları algılama ve takip etme yeteneğine sahip görmeye dayalı, sağlam ve güvenilir bir sistemin kurulmasıyla  sağlanabilir. Hareketli hedeflerin bulunması yol trafik kontrolü, otopark kontrolü gibi durumlarda da önem kazanmaktadır . Hareket verilerine doğru ulaşabilmek ise görüntüdeki ilgilenilen nesnenin şekil ve konum bilgilerinin minimum hatayla tespit edilmesini gerektirmektedir .Görüntüde aranan nesnenin kenarlarının doğru ve hatasız bulunması ya da cisim hareketinin hassas tespit edilmesi, cismin gerçek şeklini de ortaya çıkarmaktadır






## 2. MATLAB İLE NESNE TAKİBİ 

Matlab görüntü işleme konusunda da diğer birçok konuda olduğu gibi oldukça gelişmiş araçlara sahip bir programdır. Bu yazıda matlab programının özellikleri kullanarak kameradan gerçek zamanlı nesne takibi yapan bir proje geliştireceğiz. Projenin özellikleri ise şu şekilde olacak;
[x] Gerçek zamanlı takip
[x]	Birden fazla objenin ayırt edilebilmesi
[x] Görüntüde tek bir obje varsa hareketinin (engel arkasında görünmeme durumunda) tahmini
[x] Bulunan objelerin gösterilmesi

Bir nesneyi takip etmek için çeşitli görüntü işleme teknikleri birbiri ardına kullanılarak, görüntüler daha işlenebilir ve anlaşılabilir hale getirilmektedir. Bu kapsamda sırasıyla hangi işlemler yapacağımıza bakalım. 
Bu projede nesne takibi yapılırken ilk olarak kullanım kolaylığı açısından ve avantaj sağlamak için ayrı bir görüntü alma fonksiyonu yazılarak dışardan harici bir kamera  donanımı kullandığımızda da herhangi bir değer girmeden görüntü alma imkanı sağlanır. Daha sonra bir referans çerçevesi alınmaktadır. Sonraki görüntüler bu referans çerçevesi ile karşılaştırılır. Alınan çerçevedeki değişimler çeşitli teknikler kullanılarak belirlenebilir ve hareketleri öngörülür. Referans çerçevesine göre değişimler oldukça nesneler ve hareketleri algılanır. Referans çerçevesine göre değişimin olduğu yerler nesnelerin olduğu yerlere denk gelir. Nesnelerin bulunduğu yerler beyaza yakınsanır etrafı ise siyaha yakınsanır. Böylelikle nesneler o ortamdan seçilmiş olur. Median filtresi ile seçilen nesneler üzerindeki gürültüler yok edilir ve nesne daha sağlıklı bir şekilde belirlenir. Nesneyi çevreleyen çerçeve ile ana ekran karşılaştırılır ve nesnelerin merkez noktası bulunarak ekranın neresinde olduğu tespit edilir. Ve daha sonra tespit edilen bu noktanın koordinatları ekrana yansıtılarak kullanıcıya sarı işaretçilerle gösterilir. 
Öncelikle kameradan aşağıdaki gibi bir görüntü elde ettiğimizi varsayalım ve buradan mavi renkli objeleri takip etmek istediğimizi düşünelim.

## 2.1 Görüntü Alma ve Ayarlar 

Video işleme işleminde iyi sonuçlar alınabilmesi için görüntünün düzgün bir şekilde alınabilmesi çok önemlidir ve diğer adımları tamamı ile etkilemektedir. Görüntünün hangi aygıtla alındığı ve hangi çözünürlükte olduğunun belirlenmesi için imaq.VideoDevice komutu kullanılmaktadır. Bu komut, görüntülerin tek bir kare şeklinde alınabilmesini sağladığı için işlem yapılırken kolaylık sağlamaktadır. Aynı zamanda da farklı aygıtlardan görüntü alımını sağladığı için ve aygıta özgü sayısal olarak skaler değerler verebildiği için kullanıcıya kolaylık sağlamaktadır. Ayrıca bu projede kullanım kolaylığı ve avantaj sağlamak için görüntü almak için ayrıca bir cameraInfo.m fonksiyonu kullanılarak ayrı bir kamera kullanılması halinde programın kameranın özelliklerini tanıyıp görüntü alması sağlanmıştır. imaqhwinfo komutu görüntüleyici araç ile matlab haberleşmesini kuran ve operatörün görüntüyü görmesini sağlayan arayüzdür. Bu iki komut ile hangi cihazın seçildiği, hangi çözünürlükte ekrana verildiği ortaya konulmuştur. Görüntü alma işlemleri için oluşturulan fonksiyon ,yazılan kod ve  kodun çıktısı olarak ekrana gelen görüntü gösterilmiştir.

![1](https://user-images.githubusercontent.com/32637622/66401720-4cb51400-e9ec-11e9-9fc9-47c17ccee532.png)


***1.Görüntü almak için kullanılan fonksiyon***


![2](https://user-images.githubusercontent.com/32637622/66401729-50e13180-e9ec-11e9-9797-ac1a52e5b8fd.png)



***2.Videonun başlaması için gereken kod ve ayarlamalar***


![3](https://user-images.githubusercontent.com/32637622/66401736-53dc2200-e9ec-11e9-99ed-db2166ef693e.png)


***3. Programın çıktısı***

## 2.2 Nesne Algılama
Nesne algılanıp sınırları belirlenerek çerçevelendikten sonra istenilen fonksiyonların yapılabilmesi ve operatörün ayarlamaları kolaylıkla yapabilmesi açısından hesaplanan değerler ekrana yazılması sağlanmaktadır. Nesne algılanıp sınırları belirlenerek çerçevelendikten sonra istenilen fonksiyonların yapılabilmesi ve operatörün ayarlamaları kolaylıkla yapabilmesi açısından hesaplanan değerler ekrana yazılması sağlanmaktadır.
Buradan mavi renkleri ayıklamak için birkaç adım gereklidir. Öncelikle 3 renk katmanından (RGB) oluşan bu resmin mavi katmanını ayıklamak ve gri katmana göre farkına bakmak bize oldukça iyi bir tahmin verecektir. Resmin mavi katmanı aşağıdaki gibidir. Bu katman data değişkeninin 3. boyutunda tutulmaktadır ve erişmek için data(:,:,3) yazılması yeterlidir. Resmin gri renkli hali için ise Matlab içinde bulunan rgb2gray() fonksiyonu kullanılabilir.

![4](https://user-images.githubusercontent.com/32637622/66401788-67878880-e9ec-11e9-956b-d050619095a9.png) 


***4. Ekran görüntüsünün gri hali***

![5](https://user-images.githubusercontent.com/32637622/66401793-69e9e280-e9ec-11e9-8914-4818b88d1914.png)


***5. Program çıktısı***

Daha sonra bulunan mavi ve gri katmanlar birbirinden imsubtract() fonksiyonu ile çıkartılıp, aşağıdaki fark elde edilir. Bu resme “Median Filtresi” uygulanarak tuz-biber gürültüsü adı verilen karıncalanmaların giderilmesi sağlanabilir. Görüntü veya sinyal işlenirken gürültü olmaması önemlidir. Bunun içindir ki gürültüyü engelleyen doğrusal olmayan sayısal filtreme tekniği olan median filtresi kullanılmaktadır. 
Bu filtreleme işlemi görüntü işlemenin daha sonraki adımlarında daha net değerler alabilmek için bir ön işleme anlamına da gelmektedir. Görüntüsü işlenen maddenin gürültüden arındırılırken genel özellikleri bozulmadığı için (madde kenarları gibi) median filtresi sayısal görüntü işleme de yaygın olarak kullanılmaktadır. Bu işlem 2 boyutlu median filtresi fonksiyonu olan medfilt2() fonksiyonu ile yapılabilir. Daha sonra eşik değerine göre resim içindeki renkler ayırt edilip, resim daha kolay çalışılabilir hale getirilmiştir. Bu işlemler şöyle yapılmaktadır.
 
![6](https://user-images.githubusercontent.com/32637622/66401815-71a98700-e9ec-11e9-98b9-f3215d15274e.png)
![6 1](https://user-images.githubusercontent.com/32637622/66401818-73734a80-e9ec-11e9-9b5f-6e76e6c1e308.png)


***6. Mavi nesnenin algılanması için mavi ve gri katmanın farkı ve median filtresi sonucu***

Daha sonra bwareaopen komutu ile belli bir büyüklüğün altındaki küçük objelerin resimden ayıklanması (Resim alanın 1200'de birinden küçük objeler atılmaktadır) sağlandıktan sonra resme biraz makyaj yapmak için  data(img>0) = 255; satırı eklenerek mavi nesneler üzerine makyaj yapılarak belirginleştirilmesi sağlanmıştır. Bu işlemlerin sonucunda elde edilen ekran görüntüsünün son hali şöyledir;

![7](https://user-images.githubusercontent.com/32637622/66401823-75d5a480-e9ec-11e9-999a-a7bf878b9d19.png)


***7. Makyajlama işlemi sonucu (dilation)***



## 2.3  Stop Butonu Eklenmesi Ve Algılanan Nesnelerin Gösterilmesi
Tüm bu işlemler yapılırken ve aşamalar birbiri üzerine eklenirken kolaylık sağlaması için kod çalışır durumdayken üzerine basıldığında videoyu ve aynı zamanda kodun işleyişini durduran ve daha sonra ‘Run’ komutu ile kaldığı yerden devam etmemiz sağlayan bir stop butonu eklenmiştir. Videonun arka planda çalışır halde kalmaması için "stop" düğmesinin kullanılması tavsiye edilmektedir. Aksi halde el ile video objesinin durdurulması gerekmektedir. Video objesi kullanım halindeyken ikinci kez çalıştırılması veya video objesinin silinmesi hataya neden olmaktadır. Bu durumda Matlab'ın yeniden başlatılması gerekebilir. Durdurulan kod yeniden çalıştırılmak istenirse stop düğmesiyle durdurulması durumunda kısayol olarak F5 ile yeniden çalıştırılabilir. 
Ayrıca ek bir figür penceresi açılarak videoda algılanan nesnelerin maksimum sayısı ve bu algılanan nesnelerin figüre penceresi üzerine kaydedilmesi sağlanmıştır. Tüm bu işlemlerin sonucu açılan ek figür penceresi ve stop butonu için gerekli olan kodlar ve çıktısı aşağıda gösterilmektedir;


![8](https://user-images.githubusercontent.com/32637622/66401832-7a9a5880-e9ec-11e9-929d-df189c48ac39.png)
![8 1](https://user-images.githubusercontent.com/32637622/66401837-7c641c00-e9ec-11e9-991f-57ff50351239.png)


***8. Stop butonu*** 



## 2.4 Nesne Algılama İçin Blok Diyagram

![9](https://user-images.githubusercontent.com/32637622/66402476-95b99800-e9ed-11e9-8d06-e39b496585c7.png)


***9. Blok diyagram***

## 2.5 Algılanan Nesne İçin Hesaplamalar

Algılanan mavi nesnenin özelliklerini bilmek ve nesnenin bu özelliklerinden oluşan değerlerinin hesaplanması projemizde önemli bir yer tutmaktadır. Değerlerin çıktı ekranında görüntülenmesi konusunda da anlatıldığı gibi referans noktasına olan uzaklık, çerçeve alanı, nesnenin orijine olan uzaklığı ve nesnenin koordinatları aşağıda yapılan işlemler sonucunda hesaplanmaktadır.
Burada yapılan işlemleri kısaca özetlemek gerekirse, öncelikle regionprops() fonksiyonu ile bağlı bileşenlerin ve bu bileşenlerin istenen özelliklerinin elde edilmesi sağlanmaktadır. 4 komşuluğuna göre bağlı bileşenlerin bulunması 8 komşuluğu ile aynı sonucu daha hızlı sağlamakta olduğundan 4 komşuluğuna göre bağlı bileşenlerin özellikleri çıkarılmıştır. Bunları sağlayan kod aşağıdadır.
 
![10](https://user-images.githubusercontent.com/32637622/66402484-981bf200-e9ed-11e9-9a00-4f43fc6b5b5a.png)


***10. Algılanan nesne için hesaplamalar***


 Daha sonra bulunan bu özelliklere göre her bir objenin alanını çevreleyen bir sınır çizilip, merkez noktası belirlenerek bu noktanın yanında cisimle ilgili bilgiler gösterilmektedir. Bu bilgiler cismin merkezinin koordinatları, hareketli cismin x ve y eksenlerinde sahip olduğu hız ve ayrıca cismin alanı bilgilerini içermektedir. Bu işlemlerin sonucu aşağıdaki gibidir.

![11](https://user-images.githubusercontent.com/32637622/66402490-99e5b580-e9ed-11e9-8b77-3db9f81af3ed.png)
![11 1](https://user-images.githubusercontent.com/32637622/66402503-9baf7900-e9ed-11e9-8c2b-ee23829d1f26.png)


***11. Koordinat, hız ve alan bilgisi hesaplama*** 



Tüm bu bilgiler sağlandıktan sonra videoda tek bir nesne algılandığı durumda bu nesnenin hız, konum ve alan bilgilerinin elde edilmesini ve ekrana yazılmasını sağlayan kod ve çıktısı aşağıdaki gibi olmaktadır;

![12](https://user-images.githubusercontent.com/32637622/66402510-9f430000-e9ed-11e9-805e-9f3a9b5d12a7.png)
![12 1](https://user-images.githubusercontent.com/32637622/66402518-a10cc380-e9ed-11e9-9d6f-19650653394d.png)


***12. Koordinat, hız ve alan bilgisi yazdırma***



Eğer videoda birden fazla mavi nesne algılanırsa aşağıdaki kod çalışır ve kaç tane nesne varsa hepsinin konumu, merkez koordinatları, hızı ve alan bilgileri kullanıcıya cismin yanında gösterilir.. 
 
![13](https://user-images.githubusercontent.com/32637622/66402527-a407b400-e9ed-11e9-813a-2a0345c652ae.png)
![13 1](https://user-images.githubusercontent.com/32637622/66402530-a66a0e00-e9ed-11e9-8ffc-0bf9c967504d.png)


 ***13. Çoklu nesne durumu***


Sahnede tek bir obje olması durumunda eğer obje bir engelin arkasına giriyorsa çalışan kod şu aşağıdadır. Burada objenin bilgileri var  ancak ekranda hiç obje yoksa cismin sabit hızla  ve aynı yönde gittiğini kabul edersek harket tahmini;
 
![14](https://user-images.githubusercontent.com/32637622/66402534-a8cc6800-e9ed-11e9-9edd-b9061724ee0c.png)


***14. Hareket tahmini***

Son olarak ise performans sağlamak için alınan verilerin bellekten silinmesi işlemi vardır.

![15](https://user-images.githubusercontent.com/32637622/66402543-ab2ec200-e9ed-11e9-94c4-d4cea3dfd62e.png)


***15. Bellek temizleme*** 


## 3.Sonuç
- Bu projede nesne takibi yapılırken ilk olarak kullanım kolaylığı açısından ve avantaj sağlamak için ayrı bir görüntü alma fonksiyonu yazılarak dışardan harici bir kamera  donanımı kullandığımızda da herhangi bir değer girmeden görüntü alma imkanı sağlanır. Daha sonra bu görüntü alındıktan sonra video işleme aşamalarına geçilmiştir. 
-Videonun ekran görüntüsü alındıktan sonra mavi renkleri ayıklamak için birkaç adım gereklidir. Öncelikle 3 renk katmanından (RGB) oluşan bu resmin mavi katmanını ayıklamak ve gri katmana göre farkına bakmak bize oldukça iyi bir tahmin verecektir. Resmin mavi katmanı data değişkeninin 3. boyutunda tutulmaktadır ve erişmek için data(:,:,3) yazılması yeterlidir. Resmin gri renkli hali için ise Matlab içinde bulunan rgb2gray() fonksiyonu kullanılabilir.
- Daha sonra bulunan mavi ve gri katmanlar birbirinden imsubtract() fonksiyonu ile çıkartılıp, bir fark değeri elde edilir. Bu resme “Median Filtresi” uygulanarak tuz-biber gürültüsü adı verilen karıncalanmaların giderilmesi sağlanabilir. Daha sonra videodaki nesneye makyaj ve kenar bulma işlemleri sırasıyla uygulanarak cismin tespiti işlemi ile devam edilir. Açılan ek bir figür penceresine bulunan tüm nesnelerin bilgilerinin kaydedilip kullanıcıya gösterilmesi işlemi ile sonlandırılır..
- Tüm bu işlemler sonrasında algılanan nesne için videodaki hareketine göre bilgilerinin alınması işlemi gelmektedir. Burada cisim algılandıktan sonra merkez noktası belirlenir ve sarı bir işaretçi konularak bu merkez videoda gösterilir. Daha sonra cismin X ve Y düzlemindeki konumları hesaplanır ve değerler ekrana yazdırılır. Eğer cisimler ya da cisim hareket halindeyse dx ve dy değişkenleri ile x ve y eksenlerindeki hızlarının değişimi de aynı şekilde ekrana yazdırılmaktadır.
- Daha sonra cismin alan hesaplamaları yapılarak belli bir alan değerinin altındaki cisimlerin obje olarak algılanmaması sağlanmaktadır. Ve yine alan hesaplamalarına bağlı olarak cismin ekranda herhangi bir engel arkasında kalması durumları için alan değişimlerinin ekarte edilmesi işlemi gerçekleştirilmiştir. Ayrıca videoya daha önce girmiş bir nesnenin bilgileri varsa ancak obje sonraki durum için ekranda değilse bu nesnenin sabit hızla ve aynı yönde gittiği varsayılarak hareketinin tespiti için de ayrıca algoritma geliştirilmiştir
- Ayrıca tüm bu işlemler yapılırken ve yapıldıktan sonra kullanım kolaylığı olması açısından videonun durdurulup tekrar çalışması için ‘’stop’’ butonu eklenmiştir. Videonun arka planda çalışır halde kalmaması için "stop" düğmesinin kullanılması tavsiye edilmektedir. Aksi halde el ile video objesinin durdurulması gerekmektedir. Video objesi kullanım halindeyken ikinci kez çalıştırılması veya video objesinin silinmesi hataya neden olmaktadır. Bu durumda Matlab'ın yeniden başlatılması gerekebilir. Durdurulan kod yeniden çalıştırılmak istenirse stop düğmesiyle durdurulması durumunda kısayol olarak ‘’run’’ ile yeniden çalıştırılabilir.






