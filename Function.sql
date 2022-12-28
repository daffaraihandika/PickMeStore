CREATE OR REPLACE FUNCTION GetUserId (
    username_in IN VARCHAR2,
    password_in IN VARCHAR2)
RETURN NUMBER
IS
    isLogin NUMBER;
    user_id NUMBER;
BEGIN
    isLogin := Login(username_in, password_in);
    IF isLogin = 0 THEN
        SELECT id_user INTO user_id FROM "User"
        WHERE username = username_in;
    END IF;
RETURN user_id;
END;

CREATE OR REPLACE FUNCTION GetProductId (
    product_name_in IN VARCHAR2,
    size_in IN VARCHAR2)
RETURN NUMBER
IS
    product_id NUMBER;
BEGIN
    SELECT id_product INTO product_id 
         FROM Product WHERE nama_barang = product_name_in
         AND ukuran = size_in;
RETURN product_id;
END;

CREATE OR REPLACE FUNCTION GetOrderDetailsId (
    username_in IN VARCHAR2,
    password_in IN VARCHAR2)
RETURN NUMBER
IS
    isUser NUMBER;
    order_detail_id NUMBER;
BEGIN
    isUser := GetUserId(username_in, password_in);
    SELECT id_orderdetails INTO order_detail_id
    FROM order_details WHERE id_user = isUser;
RETURN order_detail_id;
END;    

CREATE OR REPLACE FUNCTION GetCategoryId (
    nama_kategori_in IN VARCHAR2)
RETURN NUMBER
IS
    category_id NUMBER;
BEGIN
    SELECT id_kategori INTO category_id
    FROM category WHERE nama_kategori = nama_kategori_in;
RETURN category_id;
END;    

CREATE OR REPLACE FUNCTION GetAddressId (
    alamat_in IN VARCHAR2)
RETURN NUMBER
IS
    address_id NUMBER;
BEGIN
    SELECT id_address INTO address_id
    FROM address WHERE alamat_lengkap = alamat_in;
RETURN address_id;
END;   