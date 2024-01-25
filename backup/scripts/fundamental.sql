-- membuat tabel
create table barang (
	kode int not null,
	name varchar(255) not null,
	harga int not null default 0,
	jumlah int not null default 0,
	waktu timestamp not null default current_timestamp -- current timestamp itu waktu masa kini
);
ALTER TABLE barang
ADD COLUMN deskripsi text;
alter table barang
	rename code to kode;
alter table barang drop column deskripsi;
--truncate barang menghapus semua data
truncate barang;
-- drop table barang maka akan menghapus tabel barang
drop table products;
create table products (
	id varchar(10) not null,
	name varchar(100) not null,
	description text,
	price int not null,
	quantity int not null default 0,
	created_at timestamp not null default current_timestamp
);
-- mengisi data tabel menggunakan insert
insert into products (id, name, price, quantity)
values ('P0001', 'Baso', 15000, 1)
insert into products (id, name, description, price, quantity)
values(
		'P0009',
		'Bakso a',
		'Baso Di tambah mie ayam',
		25000,
		4
	) -- kita juga bisa mengisi data sekaligus lebih dari satu
	-- mengisi data tabel menggunakan insert
insert into products (id, name, price, quantity)
values ('P0004', 'Batagor', 7000, 100),
	('P0003', 'Mie Ayam', 10000, 100) -- mengambil data menggunakan perintah select
select *
from products;
-- memfilter kolom dengan menyebutkan nama kolomnya saja
select id,
	name,
	price,
	quantity
from products;
--menambahkan primary key dan primary key boleh lebih dari satu tapi bagusnya cuman 1 agar mudah di maintain kecuali ada kasus many to many
alter table products
add primary key (id);
-- where clause kita bisa melakukan pencarian data misalkan kita ingin mengambil data yg id nya P0001
select id,
	name,
	price,
	quantity
from products
where id = 'P0001';
-- membuat kolom yg akan dimasukan ke table products menggunakan alter table
create type product_category as enum ('Makanan', 'Minuman', 'Lain-Lain');
-- menambah kolom baru yaitu category
alter table products
add column category product_category;
-- update data untuk mengubah data tabel yg sudah di insert, saat kita menggunakan update
-- kita harus menggunakan where clause dan hati hati mengupdate data di table karena bisa bisa kita mengupdate seluruh data tabel
update products
set category = 'Makanan'
where id = 'P0001';
-- kita juga bisa mengubah beberapa kolom sekaligus contoh
update products
set category = 'Makanan',
	description = 'Baso Asam Pedas Manis'
where id = 'P0001';
-- selain itu update juga bisa menggunakan aritmatika dengan cara price lama +-*/ maka hasinya akan di anuin contoh
update products
set price = price + 2000
where id = 'P0004';
select *
from products;
-- delete adalah untuk menghapus data di tabel sama seperti update kita harus menggunakan where clause 
-- kita perlu memberi tahu data tabel yg mana yg mau di hapus dan ini juga harus hati hati
delete from products
where id = 'P0009'
select *
from products;
-- postgres memiliki fitur alias ini sangat berguna ketika kita menggunakan inner join alias menambah nama kedua sementara dari kolom 
-- dan kita bisa lebih dari satu kata tapi dengan syarat menggunakan petik dua " kita juga bisa menambah nama dari tabel nya tersebut contoh 
select p.id as "Kode Barang",
	p.price as "Harga Barang",
	p.description as deskripsi
from products as p;
-- where operator sama dengan (=):
--Digunakan untuk membandingkan apakah nilai suatu kolom sama dengan nilai tertentu.
select *
from products
where quantity = '100';
--
--Tidak sama dengan (<> atau !=):
--Digunakan untuk memeriksa apakah nilai suatu kolom tidak sama dengan nilai tertentu.
select *
from products
where quantity != '100';
--
--Lebih besar dari (>):
--Digunakan untuk menemukan data di mana nilai suatu kolom lebih besar dari nilai tertentu.
select *
from products
where price > 15000;
--
--Lebih kecil dari (<):
--Digunakan untuk menemukan data di mana nilai suatu kolom lebih kecil dari nilai tertentu.
select *
from products
where price > 15000;
--Lebih besar atau sama dengan (>=):
--Digunakan untuk menemukan data di mana nilai suatu kolom lebih besar atau sama dengan nilai tertentu.
select *
from products
where price >= 15000;
--Lebih kecil atau sama dengan (<=):
--Digunakan untuk menemukan data di mana nilai suatu kolom lebih kecil atau sama dengan nilai tertentu.
select *
from products
where price <= 15000;
--Operator AND:
--    Digunakan untuk menggabungkan dua atau lebih kondisi dan memastikan bahwa semua kondisi tersebut harus terpenuhi agar data diambil.
--    Contoh:
SELECT *
FROM products p
WHERE price >= 15000
	AND name = 'Baso';
--    Ini berarti "ambil semua data dari product di mana memenuhi kondisi1 dan juga memenuhi kondisi2."
--Operator OR:
--    Digunakan untuk menggabungkan dua atau lebih kondisi dan memastikan bahwa setidaknya satu dari kondisi tersebut harus terpenuhi agar data diambil.
--    Contoh:
SELECT *
FROM products p
WHERE price >= 15000
	OR name = 'Baso';
--        Ini berarti "ambil semua data dari products di mana memenuhi kondisi1 atau memenuhi kondisi2."
--Contoh penggunaan kombinasi AND dan OR:
SELECT *
FROM products p
WHERE (
		price >= 15000
		AND "name" = 'Baso'
	)
	OR quantity > 10;
--Ini berarti "ambil semua data dari products di mana memenuhi (kondisi1 dan kondisi2) atau memenuhi kondisi3."
insert into products (id, name, price, quantity, category)
values ('P0006', 'Es Teh Panas', 20000, 1000, 'Minuman'),
	(
		'P0007',
		'Es Kepala Muda',
		20000,
		1000,
		'Minuman'
	),
	('P0008', 'Es Teler', 20000, 1000, 'Minuman');
select *
from products p;
--Like Operator adalah opertor yg bisa kita gunakan untuk mencari data tapi like itu sangat lambat jika datanya sangat banyak
--Operasi like case sensitive huruf besar dan kecil berpengaruh jika tidak ingin case sensitive kita bisa menggunakan ILIKE
-- string dengan awalan huruf B
select *
from products
where name ilike 'B%';
-- menggunakan ilike menjadi tidak case sensitive
select *
from products
where name ilike 'b%';
-- string dengan akhiran huruf m
select *
from products
where name ilike '%m';
-- string berisi Es
select *
from products
where name ilike '%es%';
-- NUll Operator untuk mencari data yg berisi null, kita tidak bisa menggunakan operator perbandingan ada operator khusus untuk mencari null
-- is null artinya mencari yg null dan is not null artinya mencari data yg tidak null
select *
from products p
where description is null;
select *
from products p
where description is not null;
-- Between operator kadang kita ingin mencari data dengan jarak tertentu contohnya harganya antara 15000 sampai 20000 untuk melakukan ini kita bisa menggunakan operator between
-- agar lebih mudah dan sederhana kita bisa menggunakan operator between untuk kebalikannya kita bisa menggunakan not between
select *
from products p
where price between 15000 and 20000;
select *
from products p
where price not between 15000 and 20000;
-- In operator adalah untuk melakukan pencarian sebuah kolom dengan beberapa nilai misal kita ingin mencari mencari product minuman atau makanan
-- kita bisa menggunakan operator in untuk kebalikan nya kita bisa menggunakan not in
select *
from products p
where category in ('Makanan');
select *
from products p
where category not in ('Makanan');
-- order by clause digunakan untuk mengurutkan data berdasarkan kolom yg di pilih, dan jenis urutan (ASC, DESC)
-- kita juga bisa mengurutkan tidak hanya terhadap 1 kolom tapi beberapa kolom
select *
from products p
order by price asc,
	id desc;
-- limit clause adalah membatasi data yg diambil dalam sql select selain membatasi jumlah data kita juga bisa mengskip sejumlah data yg ingin kita lihat
-- limit biasanya digunakan saat melakukan paging di aplikasi kita dengan kondisi offset
select *
from products p
where price > 5000
order by price asc;
select *
from products p
where price > 5000
order by price asc,
	id desc
limit 2;
select *
from products p
where price > 5000
order by price asc,
	id desc
limit 2 offset 2;
-- select distinct data adalah fitur yg bisa menghilang data yg duplikat (bukan menghapus) contoh
select category
from products p;
select distinct category
from products p;
-- numeric funtion kita bisa memanipulasi data angka secara garis besar fitur ini dibagi menjadi 2 arithmetic dan mathematical
-- arithmetic
select 10 + 10 as hasil;
select id,
	price / 1000 as price_in_k
from products p;
-- mathematical
select pi();
select power(10, 2);
select sin(10),
	cos(10),
	tan(10);
select *
from t_products tp;
select *
from t_order to2;
select tor.id,
	tor.barang_id as kode_barang,
	tor.quantity,
	tp.name,
	tp.description
from t_order tor
	inner join t_products tp on tor.barang_id = tp.id;
select tor.id,
	tor.barang_id as kode_barang,
	tor.quantity,
	tp.name,
	tp.description
from t_order tor
	RIGHT join t_products tp on tor.barang_id = tp.id;