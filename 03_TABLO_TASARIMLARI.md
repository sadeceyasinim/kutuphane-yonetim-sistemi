# Detaylı Tablo Tasarımları ve İlişkileri

## 1. Kitaplar Tablosu  
- **kitap_id** (PK): Int, Otomatik artan, Her kitabın benzersiz kimliği  
- **kitap_ad**: Varchar(255), Kitap adı  
- **yazar_id** (FK): Int, Yazar kimliği  
- **yayinevi_id** (FK): Int, Yayın evi kimliği  
- **tarih**: Date, Yayın tarihi  

### İlişkiler:  
 - Her kitap bir yazar ve bir yayinevi ile ilişkilidir.


## 2. Yazarlar Tablosu  
- **yazar_id** (PK): Int, Otomatik artan, Her yazarın benzersiz kimliği  
- **yazar_ad**: Varchar(255), Yazarın adı  
- **yazar_soyad**: Varchar(255), Yazarın soyadı  

### İlişkiler:  
 - Bir yazar birden fazla kitabın yazarı olabilir.


## 3. Yayın Evleri Tablosu  
- **yayinevi_id** (PK): Int, Otomatik artan, Her yayın evinin benzersiz kimliği  
- **yayinevi_ad**: Varchar(255), Yayın evinin adı  

### İlişkiler:  
 - Bir yayın evi birden fazla kitabın yayıncısı olabilir.


## 4. Üyeler Tablosu  
- **uyeler_id** (PK): Int, Otomatik artan, Her üyenin benzersiz kimliği  
- **uye_ad**: Varchar(255), Üyenin adı  
- **uye_soyad**: Varchar(255), Üyenin soyadı  
- **email**: Varchar(255), Üyenin e-posta adresi  

### İlişkiler:  
 - Her üye, birden fazla kitap ödünç alabilir.


## 5. Ödünç Alma Tablosu  
- **odunc_id** (PK): Int, Otomatik artan, Her ödünç alma işleminin benzersiz kimliği  
- **kitap_id** (FK): Int, Ödünç alınan kitabın kimliği  
- **uye_id** (FK): Int, Ödünüç alan üyenin kimliği  
- **odunc_tarihi**: Date, Ödünç alma tarihi  
- **iade_tarihi**: Date, İade tarihi  

### İlişkiler:  
 - Her ödünç alma işlemi bir kitap ve bir üye ile ilişkilidir.  


## Genel İlişkilendirme  
- Kitaplar, Yazarlar ve Yayın Evleri: Bir kitap, bir yazar ve bir yayinevi ile ilgilidir.
- Üyeler ve Ödünç Alma: Bir üye, birden fazla kitabı ödünç alabilir ve her ödünç alma işlemi bir kitaba ve bir üyeye aittir.