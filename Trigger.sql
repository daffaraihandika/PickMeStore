-- Membuat Trigger dengan Prosedur Exception RAISE_APPLICATION_ERROR
create or replace TRIGGER trg_update_stok
AFTER INSERT OR DELETE OR UPDATE ON order_items
FOR EACH ROW
DECLARE
    tmp_stok NUMERIC;
    tmp_status VARCHAR2(15);
BEGIN
    IF INSERTING THEN
        SELECT stok INTO tmp_stok FROM Product WHERE id_product = :new.id_product; -- menampung nilai stok dari tabel produk pada variabel tmp_stok
        IF (:new.quantity <= tmp_stok) THEN -- kondisi ketika stok produk >= jumlah pesanan
            UPDATE Product SET stok = (tmp_stok - :new.quantity) WHERE id_product = :new.id_product; -- mengurangi nilai stok pada tabel produk sebanyak jumlah pesanan
        ELSE
            RAISE_APPLICATION_ERROR(-20000, 'Stok tidak mencukupi'); -- exeception handling ketika memesan melebihi jumlah stok
        END IF;
    ELSIF UPDATING THEN
        SELECT stok INTO tmp_stok FROM Product WHERE id_product = :new.id_product; -- menampung nilai stok dari tabel produk pada variabel tmp_stok
        IF (:new.quantity = 0) THEN
            UPDATE product SET stok = stok + :new.quantity;
        ELSIF (:new.quantity <= tmp_stok + :old.quantity) THEN -- kondisi ketika jumlah <= stok produk + jumlah pesanan yg lama
            UPDATE product SET stok = ((tmp_stok + :old.quantity) - :new.quantity) WHERE id_product = :old.id_product; -- mengupdate nilai stok pada tabel produk dengan (nilai stok + jumlah pesanan lama) - jumlah pesanan terbaru
        ELSE
            RAISE_APPLICATION_ERROR(-20000, 'Stok tidak mencukupi'); -- exeception handling ketika melakukan update pesanan melebihi jumlah stok
        END IF;
    ELSIF DELETING THEN -- ketika menghapus pesanan
        UPDATE product SET stok = (stok + :old.quantity) WHERE id_product = :old.id_product; -- mengupdate nilai stok pada tabel produk dengan menambahkan kembali jumlah pesanan
    END IF;
END;

select * from order_details;
select * from order_items;

CREATE OR REPLACE NONEDITIONABLE TRIGGER trg_cancelled_order
AFTER UPDATE ON Order_Details
FOR EACH ROW
BEGIN
     IF :new.status = 'Canceled' OR :new.status = 'Expired' THEN
         DELETE FROM order_items WHERE id_orderdetails = :new.id_orderdetails;
         DELETE FROM payment_details WHERE id_orderdetails = :new.id_orderdetails;
     END IF;
END;

create or replace NONEDITIONABLE TRIGGER trg_transaksi_lunas
AFTER UPDATE ON payment_details
FOR EACH ROW
BEGIN
     IF :new.status = 'Lunas' THEN
            UPDATE order_items
            SET total_perproduk = 0,
                quantity = 0
            WHERE id_orderdetails = :new.id_orderdetails;
     END IF;
END;

DROP TRIGGER trg_transaksi_lunas;

CREATE OR REPLACE NONEDITIONABLE TRIGGER trg_expired_payment
AFTER UPDATE ON payment_details
FOR EACH ROW
BEGIN
    IF extract(day from (sysdate - :old.created_at)) >= 2 AND :new.status = 'Belum Lunas' THEN
        UPDATE order_details SET status = 'Expired' WHERE :old.id_orderdetails = :new.id_orderdetails;
    END IF;
END;

DROP TRIGGER cancelled_order; 

CREATE USER daffaraihandika4 IDENTIFIED BY daffa170203;
GRANT ALL PRIVILEGES TO daffaraihandika4;

