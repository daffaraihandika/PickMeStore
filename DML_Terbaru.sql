SELECT * FROM "User" ORDER BY id_user;
SELECT * FROM address ORDER BY id_address;
select * from category;
SELECT * FROM Product;
SELECT * FROM order_items ORDER BY id_orderitem;
SELECT * FROM Order_Details ORDER BY id_orderdetails;
SELECT * FROM payment_details ORDER BY id_paymentdetails;

DELETE FROM payment_details;

DELETE from product where id_product > 28;

UPDATE "User"
SET saldo = 0
WHERE role = 'Admin';

DELETE FROM payment_details WHERE id_paymentdetails = 24;

select * 
from "User"
where rownum = 1;

-- delete product
DELETE FROM Product WHERE id_product = 2;

-- delete address
DELETE FROM Address WHERE id_address = 2;

-- delete user
DELETE FROM "User" WHERE username = 'rakamhrdkaa';

-- update alamat
UPDATE address
SET alamat_lengkap = 'Jl Soma no 6'
WHERE id_address = 2;

-- update user
UPDATE "User"
SET saldo = 250000
WHERE username = 'admin'

-- update product
UPDATE product
SET stok = 15
WHERE id_product = 2;

-- update order detail (mengubah harga total)
UPDATE order_details
SET harga_total = 324000
WHERE id_orderdetails = 1

-- insert order detail
INSERT INTO Order_Details (harga_total, id_user, id_paymentdetails, created_at, modified_at)
    VALUES(24000, 2, null, CURRENT_DATE, NULL);

-- update order items (menambahkan id_orderdetails)
UPDATE order_items
SET id_orderdetails = 1

-- melakukan order barang (insert order items)
INSERT INTO order_items (quantity, id_product, id_orderdetails, total_perproduk)
VALUES (2, 2, NULL, 12000)

INSERT INTO order_items (quantity, id_product, id_orderdetails, total_perproduk)
VALUES (2, 2, NULL, 12000)

INSERT INTO order_items (quantity, id_product, id_orderdetails, total_perproduk)
VALUES (1, 1, NULL, 300000)

INSERT INTO order_items (quantity, id_product, id_orderdetails, total_perproduk)
VALUES (2, 2, NULL, 24000);

delete from "User" Where password = 'raka123';

-- insert data user
INSERT INTO "User" (username, password, full_name, no_telp, email, role)
    VALUES('admin', 'admin321', 'Pick Me Store', '087700727987', 'pickmestore@gmail.com', 'Admin');
    
INSERT INTO "User" (username, password, full_name, no_telp, email, role,saldo)
    VALUES('Burhanudinwer', 'burhan123', 'Burhanudin al malik', '089765431278', 'burhan@gmail.com', 'Customer',10000);
    
INSERT INTO "User" (username, password, full_name, no_telp, email, role)
    VALUES('alfhandre', 'andreaja', 'Andre Lutfiansyah', '087700720823', 'andre@gmail.com', 'Customer');    
    
-- insert data address
INSERT INTO Address (alamat_lengkap, provinsi, kota, kecamatan, kode_pos, id_user)
    VALUES('Jl Soma', 'Jawa Barat', 'Bandung', 'Antapani','402405', 7);   

-- insert data category    
INSERT INTO Category (nama_kategori)
    VALUES('T-Shirt');

INSERT INTO Category (nama_kategori)
    VALUES('Kemeja');
    
INSERT INTO Category (nama_kategori)
    VALUES('Hoodie');    

INSERT INTO Category (nama_kategori)
    VALUES('Sweater');
    
INSERT INTO Category (nama_kategori)
    VALUES('Celana Panjang');
    
INSERT INTO Category (nama_kategori)
    VALUES('Celana Pendek');    
    
-- insert data product
INSERT INTO Product (nama_barang, deskripsi, harga, ukuran ,id_kategori, stok)
    VALUES('Black T-Shirt Oversize', 'Bahan Double-faced menggabungkan tampilan clean dan tekstur lembut, Desain kerah yang stylish, Lengan half, drop shoulders, dan siluet wide fit.', 200000, 'L', 1, 11);
    
-- insert payment_details
INSERT INTO Payment_Details (provider, status, id_orderdetails, created_at, modified_at)
    VALUES('BRI', 'nganjuk', 1, CURRENT_DATE, NULL);
    
-- update ganti password
UPDATE "User" 
SET password = 'daffa12345'
WHERE id_user = 1;
