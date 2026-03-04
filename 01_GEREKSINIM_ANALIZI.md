# KÜTÜPHANE YÖNETİM SİSTEMİ - VERİTABANI TASARIMI

## 1. GEREKSİNİM ANALİZİ

### 1.1 Sistem Amacı
Kütüphane yönetim sistemi, bir kütüphanenin temel işlemlerini otomatikleştirmek ve yönetmek amacıyla tasarlanmıştır:

- Kitap envanterini merkezi olarak yönetmek
- Üyelerin bilgilerini ve ödünç işlemlerini takip etmek
- Kitapları kategorize etmek ve aranabilir hale getirmek
- Gecikmiş iadeler için ceza sistemi uygulamak
- Kütüphane personelinin işlemlerini kaydetmek
- Raporlama ve istatistik çıkarmak

### 1.2 Proje Kapsamı

Bu sistem aşağıdaki işlemleri yönetecektir:
- Üye kayıt/güncelleme/silme
- Kitap ödünç alma ve iade
- Kitap arama (yazar, kategori, başlık, ISBN)
- Gecikme cezası hesaplama
- Personel yönetimi
- Kitap envanteri takibi

### 1.3 Kullanıcı Tipleri

1. **Üyeler (Members)**
   - Kütüphaneye kayıtlı bireyler
   - Kitap ödünç alıp iade edebilirler
   - Kişisel bilgilerini güncelleyebilirler

2. **Personel (Staff)**
   - Kütüphane çalışanları
   - Ödünç/iade işlemlerini gerçekleştirirler
   - Kitap ve üye bilgilerini yönetirler

3. **Yönetici (Admin)**
   - Sistem yönetimi
   - Raporlama ve istatistik
   - Personel yönetimi

### 1.4 Temel İşlemler

| İşlem | Açıklama |
|-------|----------|
| Üye Kayıt | Yeni üye kütüphaneye kaydedilir |
| Kitap Ödünç | Üye kitap ödünç alır (max 5 kitap) |
| Kitap İade | Üye ödünç aldığı kitabı iade eder |
| Ceza Hesaplama | Geç iade için otomatik ceza hesaplanır |
| Kitap Arama | Üyeler çeşitli kriterlere göre kitap arar |
| Rapor Oluşturma | Sistem raporları otomatik oluşturur |

### 1.5 Sistem Kısıtlamaları

- Bir üye en fazla 5 kitap ödünç alabilir
- Ödünç süresi 14 gündür
- Gecikme cezası günde 2 TL'dir
- Borcu olan üyeler yeni kitap ödünç alamaz
- İade tarihi boş olan ödünçler "Aktif" durumdadır

---

## 2. VERİTABANI TASARIMI

### 2.1 Varlık Tanımı (Entity Definition)

Sistemimizde 7 ana varlık bulunmaktadır:

#### **1. ÜYELERİ (Members)**
Kütüphaneye kayıtlı tüm üyeleri temsil eder.

| Öznitelik | Veri Tipi | Açıklama |
|-----------|-----------|----------|
| UyeID | INT (PK) | Üyenin benzersiz kimliği |
| Ad | VARCHAR(50) | Üyenin adı |
| Soyad | VARCHAR(50) | Üyenin soyadı |
| Email | VARCHAR(100) | Üyenin e-mail adresi (Benzersiz) |
| Telefon | VARCHAR(15) | Üyenin telefon numarası |
| KayitTarihi | DATE | Üyenin kayıt tarihi |
| DogumTarihi | DATE | Üyenin doğum tarihi |
| Adres | VARCHAR(200) | Üyenin adresi |
| Durum | VARCHAR(10) | Aktif/Pasif |

#### **2. YAZARLAR (Authors)**
Kitapların yazarlarını temsil eder.

| Öznitelik | Veri Tipi | Açıklama |
|-----------|-----------|----------|
| YazarID | INT (PK) | Yazarın benzersiz kimliği |
| Ad | VARCHAR(50) | Yazarın adı |
| Soyad | VARCHAR(50) | Yazarın soyadı |
| DogumTarihi | DATE | Yazarın doğum tarihi (Opsiyonel) |
| Ulkesi | VARCHAR(50) | Yazarın ülkesi |
| Biyografi | TEXT | Yazarın biyografisi |

#### **3. KATEGORİLER (Categories)**
Kitapların kategorilerini temsil eder.

| Öznitelik | Veri Tipi | Açıklama |
|-----------|-----------|----------|
| KategoriID | INT (PK) | Kategori benzersiz kimliği |
| KategoriAdi | VARCHAR(50) | Kategori adı (Benzersiz) |
| Aciklama | VARCHAR(200) | Kategori açıklaması |

#### **4. KİTAPLAR (Books)**
Kütüphanedeki kitapları temsil eder.

| Öznitelik | Veri Tipi | Açıklama |
|-----------|-----------|----------|
| KitapID | INT (PK) | Kitabın benzersiz kimliği |
| Baslik | VARCHAR(100) | Kitabın başlığı |
| ISBNNo | VARCHAR(15) | Kitabın ISBN numarası (Benzersiz) |
| YayinYili | INT | Kitabın yayın yılı |
| SayfaSayisi | INT | Kitabın sayfa sayısı |
| KopySayisi | INT | Toplam kopya sayısı |
| MevcutKopySayisi | INT | Kütüphanede mevcut kopya sayısı |
| YazarID | INT (FK) | Yazarın kimliği |
| KategoriID | INT (FK) | Kategorinin kimliği |
| EklenmeTarihi | DATE | Kitabın sisteme eklenme tarihi |

#### **5. PERSONEL (Staff)**
Kütüphane çalışanlarını temsil eder.

| Öznitelik | Veri Tipi | Açıklama |
|-----------|-----------|----------|
| PersonelID | INT (PK) | Personelin benzersiz kimliği |
| Ad | VARCHAR(50) | Personelin adı |
| Soyad | VARCHAR(50) | Personelin soyadı |
| Unvan | VARCHAR(50) | Personelin unvanı |
| BaslangicTarihi | DATE | İşe başlama tarihi |
| Email | VARCHAR(100) | Personelin e-mail adresi (Benzersiz) |
| Telefon | VARCHAR(15) | Personelin telefon numarası |
| Durum | VARCHAR(10) | Aktif/Pasif |

#### **6. ÖDÜNÇ İŞLEMLERİ (Loans)**
Üyelerin kitap ödünç işlemlerini temsil eder.

| Öznitelik | Veri Tipi | Açıklama |
|-----------|-----------|----------|
| OduncID | INT (PK) | Ödünç işleminin benzersiz kimliği |
| UyeID | INT (FK) | Ödünç alan üyenin kimliği |
| KitapID | INT (FK) | Ödünç alınan kitabın kimliği |
| OduncTarihi | DATE | Kitabın ödünç alınma tarihi |
| PlanlanmisIadeTarihi | DATE | Planlanmış iade tarihi (14 gün sonra) |
| GercekIadeTarihi | DATE | Gerçek iade tarihi (Opsiyonel) |
| PersonelID | INT (FK) | İşlemi yapan personelin kimliği |
| Durum | VARCHAR(15) | Aktif/Tamamlandı |

#### **7. CEZALAR (Fines)**
Gecikmiş iadeler için cezaları temsil eder.

| Öznitelik | Veri Tipi | Açıklama |
|-----------|-----------|----------|
| CezaID | INT (PK) | Cezanın benzersiz kimliği |
| OduncID | INT (FK) | İlgili ödünç işleminin kimliği |
| CezaMiktari | DECIMAL(8,2) | Cezanın tutarı (TL) |
| CezaTarihi | DATE | Cezanın hesaplandığı tarih |
| OdemeTarihi | DATE | Cezanın ödenme tarihi (Opsiyonel) |
| Durum | VARCHAR(10) | Ödenmedi/Ödendi |

---

## 3. İLİŞKİLER (Relationships)

### 3.1 İlişki Tanımları

1. **Yazarlar → Kitaplar (1:N)**
   - Bir yazar birçok kitap yazabilir
   - Bir kitabın bir yazarı vardır
   - İlişki Türü: One-to-Many

2. **Kategoriler → Kitaplar (1:N)**
   - Bir kategori birçok kitabı içerebilir
   - Bir kitabın bir kategorisi vardır
   - İlişki Türü: One-to-Many

3. **Üyeler → Ödünç İşlemleri (1:N)**
   - Bir üye birçok kitap ödünç alabilir
   - Bir ödünç işleminin bir üyesi vardır
   - İlişki Türü: One-to-Many

4. **Kitaplar → Ödünç İşlemleri (1:N)**
   - Bir kitap birçok defa ödünç alınabilir
   - Bir ödünç işleminin bir kitabı vardır
   - İlişki Türü: One-to-Many

5. **Personel → Ödünç İşlemleri (1:N)**
   - Bir personel birçok ödünç işlemi yapabilir
   - Bir ödünç işleminin bir personeli vardır
   - İlişki Türü: One-to-Many

6. **Ödünç İşlemleri → Cezalar (1:N)**
   - Bir ödünç işleminin birden fazla cezası olabilir
   - Bir cezanın bir ödünç işlemi vardır
   - İlişki Türü: One-to-Many

---

## 4. NORMALIZASYON

Tüm tablolar **3. Normal Form (3NF)** kurallarına uygun olarak tasarlanmıştır:

- **1NF**: Tüm özniteliklerin atomik (bölünemez) olması sağlanmıştır
- **2NF**: Kısmi bağımlılıklar ortadan kaldırılmıştır
- **3NF**: Geçişli bağımlılıklar ortadan kaldırılmıştır

---

## 5. ANAHTARLAR VE KISITLAMALAR

### 5.1 Birincil Anahtarlar (Primary Keys)
- Her tabloda bir birincil anahtar tanımlanmıştır
- Birincil anahtarlar otomatik artan (AUTOINCREMENT) özelliğine sahiptir

### 5.2 Yabancı Anahtarlar (Foreign Keys)
- Tablolar arasındaki ilişkiler yabancı anahtarlar ile sağlanmıştır
- İlişkisel integriti korunmaktadır

### 5.3 Diğer Kısıtlamalar
- **UNIQUE**: Email ve ISBN alanları benzersiz olmalıdır
- **NOT NULL**: Zorunlu alanlar tanımlanmıştır
- **CHECK**: Durum alanları sınırlı değerlere sahiptir
- **DEFAULT**: Tarih alanları otomatik olarak bugünün tarihi ile doldurulur

---

## 6. TEKNIK ÖZELLİKLER

- **Veritabanı Türü**: İlişkisel (Relational Database)
- **Normalizasyon Düzeyi**: 3. Normal Form (3NF)
- **Toplam Tablo Sayısı**: 7
- **Toplam İlişki Sayısı**: 6
- **Toplam Öznitelik Sayısı**: 47