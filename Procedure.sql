EXEC Register ('ferdyfauzan', 'ferdi123', 'ferdi123', 'Ferdy Fauzan', '087709847423', 'ferdif@gmail.com');
EXEC Register ('daffaraihandika', 'daffa123', 'daffa123', 'Daffa Raihandika', '087700727562', 'draihandika@gmail.com');
EXEC Register ('rakamhrdka', 'raka1234567', 'raka1234567', 'Raka Mahardika', '0877098423123', 'raka@gmail.com');
EXEC Register ('jakaa', 'jakaa12345', 'jakaa12345', 'jaka', '089762514235', 'jakacom');

SELECT * FROM "User" ORDER BY ID_USER;

-- prosedur untuk user register
set serveroutput on format wrapped;
create or replace PROCEDURE Register (username_in IN VARCHAR2, password_in IN VARCHAR2, retype_password IN VARCHAR2, full_name_in IN VARCHAR2, no_telp_in  VARCHAR2, email_in IN VARCHAR2)
IS
BEGIN
        IF (password_in = retype_password AND LENGTH(password_in) >= 8) THEN
            INSERT INTO "User"(username, password, full_name, no_telp,email, role)
                VAlUES(username_in, password_in, full_name_in, no_telp_in,email_in, 'Customer');
            
            dbms_output.put_line ('Register Success!!');
        ELSIF (password_in != retype_password) THEN
            dbms_output.put_line ('Register Failed');
            dbms_output.put_line ('Password Not Match!!');
        END IF;
        
        IF (LENGTH(password_in) < 8) THEN
            dbms_output.put_line ('Register Failed');
            dbms_output.put_line ('Password minimal 8 karakter!!');
        END IF;
        COMMIT;
END;

SELECT * FROM Product;

EXEC AddProduct('T-Shirt Metalica', 'Keren', 12000, 'M', 1, 5);
EXEC Register ('rezaananta', 'reza', 'reza', 'reza', '087709842342', 'reza@gmail.com');
EXEC Register ('rezaata', 'hahahaha', 'hahahaha', 'eja', '087709842342', 'reza');
EXEC Register ('berlianaaa', 'berliana123', 'berliana123', 'berliana raka', '089675863761', 'berlin@gmail.com');
EXEC Register ('egi', 'egi12345', 'egi12345', 'egi', '085870012345', 'egi@gmail.com');
EXEC Register ('raka', 'raka12345', 'raka12345', 'raka', '0076514567654', 'raka@gmail.com');
-- memanggil prosedur AddProduct
EXEC AddProduct('Black Regular Fit Hoodie', 'Sweter bertudung lengan panjang berbahan kain sweter yang lembut dengan saku kantong kanguru, tudung bertali serut lapis ganda dengan pembungkus depan, serta kontur garis pada manset dan keliman.', 300000, 'M', 3, 10);
EXEC AddProduct('Black T-Shirt Oversize', 'Bahan Double-faced menggabungkan tampilan clean dan tekstur lembut, Desain kerah yang stylish, Lengan half, drop shoulders, dan siluet wide fit.', 200000, 'L', 1, 15);
EXEC AddProduct('Green Relaxed Fit Zip-through Hoodie', 'Zip-through hoodie in sweatshirt fabric. Relaxed fit with a jersey-lined, drawstring hood, a zip down the front, diagonal, welt side pockets and ribbing at the cuffs and hem. Soft brushed inside.', 400000, 'XL', 3, 20);
EXEC AddProduct('Red Relaxed Fit Zip-through Hoodie', 'Zip-through hoodie in sweatshirt fabric. Relaxed fit with a jersey-lined, drawstring hood, a zip down the front, diagonal, welt side pockets and ribbing at the cuffs and hem. Soft brushed inside.', 300000, 'L', 4, 15);

-- Prosedur untuk menambahkan produk
set serveroutput on format wrapped;
create or replace PROCEDURE AddProduct (nama_barang_in VARCHAR2, deskripsi_in CLOB, harga_in INTEGER, ukuran_in VARCHAR2, id_kategori_in INTEGER, stok_in INTEGER)
IS
    flag NUMBER;
BEGIN
    flag := 0;
    FOR i IN (SELECT * FROM Product where nama_barang = nama_barang_in) LOOP
         FOR j IN (SELECT * FROM Product where ukuran = ukuran_in) LOOP
             IF i.nama_barang = j.nama_barang AND i.ukuran = j.ukuran THEN
                flag := 1; -- produk sudah ada
            END IF;
         END LOOP;
    END LOOP;
    
    IF (flag = 1) THEN
        dbms_output.put_line ('Gagal menambahkan produk');
        dbms_output.put_line ('Produk sudah ada!!');
    ELSIF (flag = 0) THEN
        INSERT INTO Product (nama_barang, deskripsi, harga, ukuran, id_kategori, stok)
                VALUES (nama_barang_in, deskripsi_in, harga_in, ukuran_in, id_kategori_in, stok_in);
        
        dbms_output.put_line ('Produk ' || nama_barang_in || ' berhasil ditambahkan');
    END IF;
    
    COMMIT;
END;

-- menjalankan prosedur deleteProduct
EXEC deleteProduct('Red Relaxed Fit Zip-through Hoodie', 'L');

-- prosedur untuk menghapus produk
set serveroutput on format wrapped;
create or replace PROCEDURE showProduct
IS
    c1 SYS_REFCURSOR;
BEGIN
    OPEN c1 FOR
    SELECT rownum AS "No", nama_barang, deskripsi, harga, ukuran, stok FROM Product;
    DBMS_SQL.RETURN_RESULT(c1);
    
    COMMIT;
END;

-- prosedur untuk menghapus produk
set serveroutput on format wrapped;
create or replace PROCEDURE deleteProduct (nama_barang_in VARCHAR2, ukuran_in VARCHAR2)
IS
    product_id NUMBER;
BEGIN
    product_id := GetProductId(nama_barang_in, ukuran_in);
    
    DELETE FROM product 
    WHERE id_product = product_id;
    dbms_output.put_line ('Produk ' || nama_barang_in || ' berhasil dihapus');
    
    COMMIT;
END;

-- memanggil function login
DECLARE    
    isSuccess NUMBER;
BEGIN    
   isSuccess := Login('ferdyfauzan', 'ferdi123');    
   dbms_output.put_line('Status login : ' || isSuccess);   
END;

-- function untuk user login
set serveroutput on format wrapped;
create or replace NONEDITIONABLE FUNCTION Login (username_in IN VARCHAR2, password_in IN VARCHAR2)
RETURN INTEGER
IS
BEGIN
    FOR i IN (SELECT * FROM "User" where username = username_in) LOOP
         FOR j IN (SELECT * FROM "User" where password = password_in) LOOP
             IF i.password = j.password AND i.username = j.username THEN
                return 0; --login success
            END IF;
         END LOOP;
         dbms_output.put_line ('Wrong Password!!');
        return 1; --invalid password
    END LOOP;
    dbms_output.put_line ('Username not registered!!');
    return 2; --username not registered
    
    COMMIT;
END;

-- menjalankan prosedur changePassword
EXEC changePassword('egi' ,'egi12345', 'egisatria123');
-- prosedur untuk mengganti password customer
set serveroutput on format wrapped;
create or replace PROCEDURE changePassword (
    username_in IN VARCHAR2, oldPassword IN VARCHAR2, newPassword IN VARCHAR2)
AS
BEGIN
    FOR i IN (SELECT * FROM "User" where password = oldPassword AND username = username_in) LOOP
        IF i.password = oldPassword THEN
            UPDATE "User" 
            SET password = newPassword
            WHERE password = oldPassword;
            dbms_output.put_line ('Password berhasil diubah!!');
            EXIT WHEN i.password = newPassword; --login success
        END IF;
    END LOOP;       
END;

SELECT * FROM Address;
SELECT * FROM "User"
    
SELECT * FROM order_items;

-- menjalankan prosedur order_details
EXEC CreateOrderDetails('daffaraihandika', 'daffa123');
EXEC CreateOrderDetails('alfhandre', 'andreaja');
EXEC CreateOrderDetails('ferdyfauzan', 'ferdi123');

-- prosedur untuk membuat order_details
set serveroutput on format wrapped;
create or replace PROCEDURE CreateOrderDetails (username_in IN VARCHAR2, password_in IN VARCHAR2)
IS
    user_id NUMBER;
BEGIN
    user_id := GetUserId(username_in, password_in);    
    INSERT INTO order_details(id_user,harga_total, created_at) 
        VALUES(user_id,0, current_date);
    
    COMMIT;
END;


-- memanggil prosedur order_per_produk
EXEC order_per_produk('Black Regular Fit Hoodie', 'M', 3, 'ferdyfauzan', 'ferdi123');
EXEC order_per_produk('Black Regular Fit Hoodie', 'M', 3, 'alfhandre', 'andreaja');
EXEC order_per_produk('Black T-Shirt Oversize', 'L', 2, 'daffaraihandika', 'daffa123');
-- prosedur untuk memesan per produk
set serveroutput on format wrapped;
create or replace PROCEDURE order_per_produk (product_name_in IN VARCHAR2, size_in IN VARCHAR2,quantity_in NUMBER, username_in IN VARCHAR2, password_in IN VARCHAR2)
IS
    product_id NUMBER;
    price NUMBER;
    order_details_id NUMBER;
BEGIN
    product_id := GetProductId(product_name_in,size_in);
    SELECT harga INTO price 
    FROM product WHERE id_product = product_id;
    price := price * quantity_in;    
    
    order_details_id := GetOrderDetailsId(username_in, password_in);
    INSERT INTO order_items (id_orderdetails, id_product, quantity, total_perproduk)
        VALUES (order_details_id, product_id, quantity_in, price);
    
    COMMIT;
END;

-- menjalankan prosedur SumOrderProduct
EXEC SumOrderProduct('daffaraihandika', 'daffa123');
EXEC SumOrderProduct('alfhandre', 'andreaja');

-- membuat prosedur untuk melakukan akumulasi dari order_items ke order_details
set serveroutput on format wrapped;
create or replace PROCEDURE SumOrderProduct (username_in IN VARCHAR2, password_in IN VARCHAR2)
IS
    order_details_id NUMBER;
    total_harga NUMBER;
BEGIN
    order_details_id := GetOrderDetailsId(username_in, password_in);
    SELECT SUM(total_perproduk) INTO total_harga
    FROM order_items
    WHERE id_orderdetails = order_details_id;
    
    UPDATE order_details
    SET harga_total = total_harga, modified_at = CURRENT_DATE
    WHERE id_orderdetails = order_details_id;
    
    COMMIT;
END;

-- menjalankan prosedur topUpSaldo
EXEC topUpSaldo('daffaraihandika', 'daffa123', 500000);
EXEC topUpSaldo('alfhandre', 'andreaja', 1000000);
EXEC topUpSaldo('egi', 'egi12345', 1000000);
-- membuat prosedur untuk top up saldo customer
set serveroutput on format wrapped;
create or replace PROCEDURE topUpSaldo (username_in IN VARCHAR2, password_in IN VARCHAR2, saldo_in IN NUMBER)
IS
    user_id NUMBER;
    saldo_awal NUMBER;
BEGIN
    user_id := GetUserId(username_in, password_in);
    SELECT saldo INTO saldo_awal
    FROM "User" WHERE id_user = user_id;
    saldo_awal := saldo_awal + saldo_in;
    
    UPDATE "User"
    SET saldo = saldo_awal
    WHERE id_user = user_id;
    
    COMMIT;
END;

-- menjalankan prosedur addStokProduct
EXEC addStokProduct(5, 'Black Regular Fit Hoodie', 'M');
EXEC addStokProduct(10, 'Red Relaxed Fit Zip-through Hoodie', 'L');

set serveroutput on format wrapped;
create or replace PROCEDURE addStokProduct (stok_in IN NUMBER, nama_barang_in IN VARCHAR2, ukuran_in IN VARCHAR2)
IS
    product_id NUMBER;
    stok_awal NUMBER;
BEGIN
    product_id := GetProductId(nama_barang_in, ukuran_in);
    SELECT stok INTO stok_awal
    FROM product WHERE id_product = product_id;
    stok_awal := stok_awal + stok_in;
    
    UPDATE product
    SET stok = stok_awal
    WHERE id_product = product_id;
    dbms_output.put_line ('stok berhasil ditambahkan');
    
    COMMIT;
END;

EXEC addAddress ('daffaraihandika', 'daffa123', 'Komplek Serra Valley DeLima', 'Jawa Barat', 'Bandung', 'Ciwaruga', '40559');
EXEC addAddress ('alfhandre', 'andreaja', 'Jl. Soma No. 70', 'Jawa Barat', 'Bandung', 'Antapani', '40240');

CREATE OR REPLACE PROCEDURE addAddress(
    username_in IN  VARCHAR2,
    password_in IN VARCHAR2,
    alamat_lengkap_in IN VARCHAR2,
    provinsi_in IN VARCHAR2,
    kota_in IN VARCHAR2,
    kecamatan_in IN VARCHAR2,
    kode_pos_in IN VARCHAR2)
AS
    user_id INTEGER;
BEGIN
    user_id := GetUserId(username_in, password_in);
    INSERT INTO Address (alamat_lengkap, provinsi, kota, kecamatan, kode_pos, id_user)
         VALUES (alamat_lengkap_in, provinsi_in, kota_in, kecamatan_in, kode_pos_in, user_id);
END;

SELECT * FROM payment_details;

-- menjalankan prosedur paymentStatus
EXEC paymentStatus('alfhandre', 'andreaja');
EXEC paymentStatus('daffaraihandika', 'daffa123');

set serveroutput on format wrapped;
create or replace PROCEDURE paymentStatus (username_in IN VARCHAR2, password_in IN VARCHAR2)
IS
    order_details_id NUMBER;
BEGIN
    order_details_id := GetOrderDetailsId(username_in, password_in);
    
    INSERT INTO payment_details(status, id_orderdetails, created_at)
        VALUES('Belum Lunas', order_details_id, current_date);
    COMMIT;
END;

select * from order_details;
-- menjalankan prosedur payOrder
EXEC payOrder('alfhandre', 'andreaja');
EXEC payOrder('daffaraihandika', 'daffa123');
set serveroutput on format wrapped;
create or replace PROCEDURE payOrder (username_in IN VARCHAR2, password_in IN VARCHAR2)
IS
    order_details_id NUMBER;
    user_id NUMBER;
    total_tagihan NUMBER;
    saldo_user NUMBER;
    current_saldo NUMBER;
BEGIN
    order_details_id := GetOrderDetailsId(username_in, password_in);
    user_id := GetUserId(username_in, password_in);
    
    SELECT harga_total INTO total_tagihan 
    FROM order_details WHERE id_orderdetails = order_details_id;
    
    SELECT saldo INTO saldo_user 
    FROM "User" WHERE id_user = user_id;
    
    current_saldo := saldo_user - total_tagihan;
    IF (saldo_user < total_tagihan) THEN
        dbms_output.put_line ('Saldo anda kurang!!');
        ELSIF (saldo_user = current_saldo + total_tagihan) THEN
            
            UPDATE payment_details
            SET status = 'Lunas'
            WHERE id_orderdetails = order_details_id;
            
            UPDATE "User"
            SET saldo = current_saldo
            WHERE id_user = user_id;
            
            UPDATE "User"
            SET saldo = saldo + total_tagihan
            WHERE role = 'Admin';
            
    END IF;
    
    COMMIT;
END;

-- menjalankan prosedur cancelOrder
EXEC cancelOrder('daffa');
EXEC cancelOrder('ferdyfauzan', 'ferdi123');
EXEC cancelOrder('alfhandre', 'andreaja');

set serveroutput on format wrapped;
create or replace PROCEDURE cancelOrder (username_in IN VARCHAR2, password_in IN VARCHAR2)
IS
    order_details_id NUMBER;
    status_in VARCHAR2(20);
BEGIN
    order_details_id := GetOrderDetailsId(username_in, password_in);
    SELECT status INTO status_in FROM PAYMENT_DETAILS
    WHERE id_orderdetails = order_details_id;
    
    IF (status_in = 'Belum Lunas') THEN
        UPDATE order_details
        SET status = 'Canceled',
        harga_total = 0
        WHERE id_orderdetails = order_details_id;
    ELSIF (status_in = 'Lunas') THEN
        dbms_output.put_line ('Pesanan tidak bisa di cancel karena sudah diproses!!');
    END IF;
    COMMIT;
END;

-- menjalankan prosedur showProductDetails
EXEC showProductDetails('Black Regular Fit Hoodie');
-- prosedur untuk menampilkan details dari produk yang dicari
set serveroutput on format wrapped;
create or replace PROCEDURE showProductDetails (
    nama_barang_in IN VARCHAR2)
AS
    c1 SYS_REFCURSOR;
BEGIN
    OPEN c1 FOR
    SELECT rownum AS "No", nama_barang, id_kategori, deskripsi, harga, ukuran, stok FROM Product
    WHERE nama_barang = nama_barang_in;
    DBMS_SQL.RETURN_RESULT(c1);
    
END;

SELECT nama_barang FROM product WHERE id_kategori = 3;
EXEC searchProductFromCategory('Hoodie');
-- prosedur mencari kategori
set serveroutput on format wrapped;
create or replace PROCEDURE searchProductFromCategory (kategori_in IN VARCHAR2)
AS
    category_id NUMBER;
    nama_barang_in VARCHAR2(50);
    c1 SYS_REFCURSOR;
BEGIN
    category_id := GetCategoryId(kategori_in);
    OPEN c1 FOR
    SELECT rownum AS "No", nama_barang, deskripsi, harga, ukuran, stok 
    FROM product 
    WHERE id_kategori = category_id;
    DBMS_SQL.RETURN_RESULT(c1);
END;

-- menjalankan prosedur createInvoice
EXEC createInvoice('alfhandre', 'andreaja');

-- membuat prosedur untuk membuat invoice
set serveroutput on format wrapped;
create or replace PROCEDURE createInvoice (username_in IN VARCHAR2, password_in IN VARCHAR2)
AS
    product_id NUMBER;
    user_id NUMBER;
    full_name_in VARCHAR2(100);
    no_telp_in VARCHAR2(50);
    email_in VARCHAR2(100);
    alamat_lengkap_in VARCHAR2(100);
    provinsi_in VARCHAR2(20);
    kota_in VARCHAR2(20);
    kecamatan_in VARCHAR(25);
    kode_pos_in VARCHAR(10);
BEGIN
    user_id := GetUserId(username_in, password_in);
    SELECT full_name, no_telp, email INTO full_name_in, no_telp_in, email_in FROM "User"
    WHERE id_user = user_id;

    SELECT alamat_lengkap, provinsi, kota, kecamatan, kode_pos INTO alamat_lengkap_in, provinsi_in, kota_in, kecamatan_in, kode_pos_in
    FROM address
    WHERE id_user = user_id AND rownum = 1;


    dbms_output.put_line ('INVOICE');
    dbms_output.put_line ('-------');
    dbms_output.put_line ('');
    dbms_output.put_line ('Customer Id : ' || user_id);
    dbms_output.put_line ('Customer Username : ' || username_in);
    dbms_output.put_line ('Customer Name : ' || full_name_in);
    dbms_output.put_line ('Customer Phone : ' || no_telp_in);
    dbms_output.put_line ('Customer Email : ' || email_in);
    dbms_output.put_line ('Customer Address : ' || alamat_lengkap_in || ',' || provinsi_in || ',' || kota_in || ',' || kecamatan_in || ',' || kode_pos_in);
    dbms_output.put_line ('');

    createDetailPesanan(username_in, password_in);

END;


-- prosedur detailPesanan 
EXEC createDetailPesanan('daffaraihandika', 'daffa123');
EXEC createDetailPesanan ('rakamhrdka', 'raka3214');

set serveroutput on format wrapped;
create or replace PROCEDURE createDetailPesanan (username_in IN VARCHAR2, password_in IN VARCHAR2)
AS
    order_details_id NUMBER;
    product_id NUMBER;
    quantity_in NUMBER;
    subtotal NUMBER;
    status_in VARCHAR2(20);
    created_at_in TIMESTAMP WITH LOCAL TIME ZONE;
    total_price NUMBER;
BEGIN
    order_details_id := GetOrderDetailsId(username_in, password_in);
    SELECT id_product, quantity, total_perproduk INTO product_id, quantity_in, subtotal FROM order_items
    WHERE id_orderdetails = order_details_id;
    
    SELECT status, created_at INTO status_in, created_at_in FROM payment_details
    WHERE id_orderdetails = order_details_id;
    
    SELECT harga_total INTO total_price FROM order_details
    WHERE id_orderdetails = order_details_id;

        
    IF (status_in = 'Belum Lunas') THEN
        dbms_output.put_line ('Details Order');
        dbms_output.put_line ('-------');
        dbms_output.put_line ('');
        dbms_output.put_line ('Product Id : ' || product_id);
        dbms_output.put_line ('Quantity : ' || quantity_in);
        dbms_output.put_line ('Subtotal : ' || subtotal);
        dbms_output.put_line ('Total Price : ' || total_price);
        dbms_output.put_line ('Status : ' || status_in );
        dbms_output.put_line ('Date : ' || created_at_in);    
    ELSIF (status_in = 'Lunas') THEN
        dbms_output.put_line ('Details Order');
        dbms_output.put_line ('-------');
        dbms_output.put_line ('');
        dbms_output.put_line ('Product Id : ' || product_id);
        dbms_output.put_line ('Total Price : ' || total_price);
        dbms_output.put_line ('Status : ' || status_in );
        dbms_output.put_line ('Date : ' || created_at_in);      
    END IF;

END;