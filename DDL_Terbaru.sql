CREATE TABLE address (
    id_address     INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL PRIMARY KEY,
    alamat_lengkap VARCHAR2(255) NOT NULL,
    provinsi       VARCHAR2(30) NOT NULL,
    kota           VARCHAR2(30) NOT NULL,
    kecamatan      VARCHAR2(30) NOT NULL,
    kode_pos       VARCHAR2(10) NOT NULL,
    id_user   INTEGER NOT NULL
);

ALTER TABLE address
    ADD CONSTRAINT address_user_fk FOREIGN KEY ( id_user )
        REFERENCES "User" ( id_user )
        ON DELETE CASCADE;

CREATE TABLE category (
    id_kategori   INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL PRIMARY KEY,
    nama_kategori VARCHAR2(30) NOT NULL
);

CREATE TABLE order_details (
    id_orderdetails                   INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL PRIMARY KEY,
    harga_total                       INTEGER NOT NULL,
    id_user                           INTEGER NOT NULL,  
    status                            VARCHAR2(20) NOT NULL,
    created_at                        TIMESTAMP WITH LOCAL TIME ZONE,
    modified_at                       TIMESTAMP WITH LOCAL TIME ZONE
);

ALTER TABLE order_details
    ADD CONSTRAINT Check_status_order CHECK (status =  'Expired' OR status = 'Canceled' OR status = 'Ordered');
    
ALTER TABLE order_details
  MODIFY status DEFAULT 'Ordered';    

ALTER TABLE order_details
  MODIFY id_paymentdetails INTEGER NULL;

CREATE UNIQUE INDEX order_details__idx ON
    order_details (
        id_user
    ASC );

CREATE UNIQUE INDEX order_details_idx ON
    order_details (
        id_paymentdetails
    ASC );

CREATE TABLE order_items (
    id_orderitem                  INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL PRIMARY KEY,
    quantity                      INTEGER NOT NULL,
    id_product            INTEGER NOT NULL,
    id_orderdetails               INTEGER NOT NULL,
    total_perproduk               INTEGER NOT NULL
);

ALTER TABLE order_items
  MODIFY id_orderdetails INTEGER NULL;
  
DROP INDEX order_items__idx;

CREATE UNIQUE INDEX order_items__idx ON
    order_items (
        id_product
    ASC );


CREATE TABLE payment_details (
    id_paymentdetails             INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL PRIMARY KEY,
    status                        VARCHAR2(10) NOT NULL,
    id_orderdetails               INTEGER NOT NULL,
    created_at                    TIMESTAMP WITH LOCAL TIME ZONE
);

ALTER TABLE payment_details
  MODIFY status VARCHAR2(15);

CREATE UNIQUE INDEX payment_details__idx ON
    payment_details (
        id_orderdetails
    ASC );

CREATE TABLE product (
    id_product           INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL PRIMARY KEY,
    nama_barang          VARCHAR2(50) NOT NULL,
    deskripsi            CLOB NOT NULL,
    harga                INTEGER NOT NULL,
    ukuran               VARCHAR2(4) NOT NULL,
    id_kategori          INTEGER NOT NULL,
    stok                 INTEGER NOT NULL 
);

ALTER TABLE Product
    ADD CONSTRAINT Cek_harga CHECK (harga > 0);   

ALTER TABLE Product
    ADD CONSTRAINT Cek_ukuran CHECK (ukuran = 'S' OR ukuran = 'M' OR ukuran = 'L' OR ukuran = 'XL');
    
ALTER TABLE Product
    ADD CONSTRAINT Cek_stok CHECK (stok >= 0);
    
CREATE TABLE "User" (
    id_user   INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL PRIMARY KEY,
    username  VARCHAR2(15) NOT NULL,
    password  VARCHAR2(32) NOT NULL,
    full_name VARCHAR2(100) NOT NULL,
    no_telp   VARCHAR2(15) NOT NULL,
    email     VARCHAR2(50) NOT NULL,
    role      VARCHAR2(10) NOT NULL,
    saldo     INTEGER NOT NULL
);

ALTER TABLE "User"
  MODIFY Saldo INTEGER DEFAULT 0;

  
ALTER TABLE "User"
    ADD CONSTRAINT Check_Saldo CHECK (saldo >= 0 );

CREATE UNIQUE INDEX username__idx ON
    "User" (
        username
    ASC );
    
CREATE UNIQUE INDEX email__idx ON
    "User" (
        email
    ASC );    

CREATE UNIQUE INDEX notelp__idx ON
    "User" (
        no_telp
    ASC );

ALTER TABLE order_details
    ADD CONSTRAINT order_details_user_fk FOREIGN KEY ( id_user )
        REFERENCES "User" ( id_user )
        ON DELETE CASCADE;

ALTER TABLE order_items
    ADD CONSTRAINT order_items_order_details_fk FOREIGN KEY ( id_orderdetails )
        REFERENCES order_details ( id_orderdetails )
        ON DELETE CASCADE;
    

ALTER TABLE order_items
    ADD CONSTRAINT order_items_product_fk FOREIGN KEY ( id_product )
        REFERENCES product ( id_product )
        ON DELETE CASCADE;

        
ALTER TABLE payment_details
    ADD CONSTRAINT payment_details_order_details_fk FOREIGN KEY ( id_orderdetails )
        REFERENCES order_details ( id_orderdetails )
        ON DELETE CASCADE;

ALTER TABLE product
    ADD CONSTRAINT product_category_fk FOREIGN KEY ( id_kategori )
        REFERENCES category ( id_kategori )
        ON DELETE CASCADE;
    
        
ALTER TABLE "User"
ADD CONSTRAINT email_format CHECK (REGEXP_LIKE (email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$')) ENABLE NOVALIDATE;

ALTER TABLE "User"
ADD CONSTRAINT phone_format CHECK (REGEXP_LIKE (no_telp, '^(\+62|62|0)8[1-9][0-9]{6,9}$')) ENABLE NOVALIDATE;
