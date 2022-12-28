-- customer register
EXEC Register ('reihan', 'reihan123', 'reihan123', 'Reihan Anugrah', '089675863411', 'reihan@gmail.com');
EXEC Register ('ujang', 'reihan123', 'reihan123', 'Reihan Anugrah', '089675863411', 'reihan@gmail.com');
EXEC Register ('edincheko', 'chekoaja', 'chekoaja', 'Cheko', '089675863231', 'cheko@gmail.com');

-- memanggil function login
DECLARE    
    isSuccess NUMBER;
BEGIN    
   isSuccess := Login('reihan', 'reihan123');    
   dbms_output.put_line('Status login : ' || isSuccess);   
END;

-- menjalankan prosedur changePassword
EXEC changePassword('reihan' ,'reihan123', 'reihan321');

-- menambahkan produk
EXEC AddProduct('Black Regular Fit Hoodie', 'Sweter bertudung lengan panjang berbahan kain sweter yang lembut dengan saku kantong kanguru, tudung bertali serut lapis ganda dengan pembungkus depan, serta kontur garis pada manset dan keliman.', 300000, 'M', 3, 25);
EXEC AddProduct('Brown Celana Chino Reguler Fit', 'Celana chino regular-fit yang autentik. Desain serbaguna yang cocok untuk outfit apa pun. 100% katun autentik yang menciptakan karakter seiring pemakaian. Celana chino klasik yang cocok untuk gaya kasual.', 275000, 'M', 5, 25);
EXEC AddProduct('Black Celana Ankle Relax', 'Sangat lentur dengan permukaan brushed yang lembut. Dengan proses garment-dye sehingga terlihat kasual. Desain pinggang relax yang nyaman. Celana santai yang cocok untuk dipakai indoor maupun outdoor.', 350000, 'S', 5, 35);

-- manghapus produk
EXEC deleteProduct('Black Celana Ankle Relax', 'S');

-- menjalankan prosedur addStokProduct
EXEC addStokProduct(5, 'Black Regular Fit Hoodie', 'M');
EXEC addStokProduct(10, 'Red Relaxed Fit Zip-through Hoodie', 'L');

-- menampilkan semua produk yg dijual
EXEC showProduct;

-- mencari product dengan kategori
EXEC searchProductFromCategory('Celana Panjang');

-- mencari produk
EXEC showProductDetails('Beige Celana Ankle Relax');

-- memesan barang 
    -- membuat order details
    EXEC CreateOrderDetails('reihan', 'reihan321');
    EXEC CreateOrderDetails('edincheko', 'chekoaja');
    
    -- memesan barang per produk
    EXEC order_per_produk('Brown Celana Chino Reguler Fit', 'L', 1, 'reihan', 'reihan321');
    EXEC order_per_produk('Black T-Shirt Oversize', 'L', 2, 'reihan', 'reihan321');
    EXEC order_per_produk('Brown Celana Chino Reguler Fit', 'S', 1, 'rakamhrdka', 'raka3214');

    -- mengakumulasikan semua pesanan
    EXEC SumOrderProduct('reihan', 'reihan321');
    
    -- menambahkan alamat pengiriman
    EXEC addAddress ('reihan', 'reihan321', 'Bandung Timur Cijambe', 'Jawa Barat', 'Bandung', 'Cijambe', '40231');

-- melakukan topUpSaldo
EXEC topUpSaldo('reihan', 'reihan321', 3000000);

-- melakukan pembayaran
    -- mengubah status pembayaran menjadi belum lunas
    EXEC paymentStatus('reihan', 'reihan321');
    
    -- membayar tagihan pesanan
    EXEC payOrder('reihan', 'reihan321');
    
-- membatalkan pesanan
EXEC cancelOrder('reihan', 'reihan321');

EXEC createInvoice('reihan', 'reihan321');