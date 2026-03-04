-- Örnek Sorgular

-- 1. Kitap bilgilerini listele
SELECT * FROM Kitaplar;

-- 2. Belirli bir yazara ait kitapları listele
SELECT * FROM Kitaplar WHERE Yazar = 'Orhan Pamuk';

-- 3. Bir kitabın mevcut stok miktarını güncelle
UPDATE Kitaplar SET Stok = Stok - 1 WHERE Id = 1;

-- 4. Kitap ekle
INSERT INTO Kitaplar (Ad, Yazar, YayınEvi, YayınTarihi, Stok) VALUES ('Yeni Kitap', 'Yazar Adı', 'Yayın Evi', '2026-01-01', 10);

-- 5. Belirli bir tarihten sonra eklenen kitapları listele
SELECT * FROM Kitaplar WHERE YayınTarihi > '2025-01-01';

-- 6. Bir kitabı sil
DELETE FROM Kitaplar WHERE Id = 2;

-- 7. Tüm yazarları listele
SELECT DISTINCT Yazar FROM Kitaplar;

-- 8. En çok okunan 5 kitabı listele
SELECT Ad, COUNT(*) AS OkunmaSayısı FROM OkunanKitaplar GROUP BY Ad ORDER BY OkunmaSayısı DESC LIMIT 5;