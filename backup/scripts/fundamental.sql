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
-- auto increment postgre memiliki tipe data serial number fitur ini yg akan automatis mengembalikan nilai yg selalu naik ketika dipanggil
-- dengan serial kita tidak perlu mengisi secara manual secara otomatis nilai primary key akan naik
create table admin (
	id serial not null,
	first_name varchar(100) not null,
	last_name varchar (100),
	primary key(id)
);
insert into "admin" (first_name, last_name)
values('Budi', 'aja'),
	('bambang', 'aja'),
	('tatang', 'aja');
select *
from "admin"
select currval('admin_id_seq');
-- sequence adalah fitur dimana kita bisa membuat auto incremement
-- saat menggunakan tipe data serial pada primary key secara otomatis postgres akan membuat sequence
create sequence test;
-- membuat sequence
select nextval('test');
-- memanggil sequance dan akan terus bertambah ketika di panggil
select currval('test');
-- mengecek sudah sampai sequence ke berapa
-- string function sama seperti number di postgre juga banyak menyediakan tipe data string
select id,
	lower(name),
	lower(description),
	length(name)
from products p;
-- date dan time function postgresql juga menyediakan banyak sekali function yg bisa kita gunakan untuk mengolah data tipe date and time
-- menambah kolom timestamp
select id,
	extract (
		year
		from created_at
	),
	extract(
		month
		from created_at
	)
from products p;
--flow control function ini mirip seperti if else di bahasa pemrograman tapi fitur ini tidak sekomplek bhs pemrograman 
select id,
	category
from products p;
select id,
	category,
	case
		category
		when 'Makanan' then 'Enak'
		when 'Minuman' then 'Seger'
		else 'Apa itu?'
	end as category_case
from products p;
select id,
	price
from products p;
select id,
	price,
	case
		when price <= 15000 then 'murah'
		when price >= 20000 then 'mahal'
		else 'mahal banget'
	end as apakah murah ?
from products p;
select id,
	name,
	description
from products p;
select id,
	name,
	case
		when description is null then 'kosong'
		else description
	end as description
from products p;
-- aggregate function misal kita ingin melihat harga paling mahal di tabel products atau harga termurah atau rata rata harga products dll
-- https://www.postgresql.org/docs/current/functions-aggregate.html
-- menghitung id
select count(id)
from products p;
-- mencari rata rata harga
select avg(price)
from products p;
-- mencari harga paling mahal
select max(price)
from products p;
-- mencari harga paling murah
select min(price)
from products p;
-- group by
--Kadang saat melakukan aggregate, kita ingin datanya di grouping berdasarkan kriteria tertentu
--Misal kita ingin melihat rata-rata harga product, tapi ingin per category
--Atau kita ingin melihat total semua product, tapi per category
--Hal ini bisa dilakukan di PostgreSQL dengan menggunakan GROUP BY clause
--GROUP BY clause ini hanya bisa digunakan jika kita menggunakan aggregate function
select category,
	count(id) as "Total product"
from products p
group by category;
select category,
	avg(price),
	min(price),
	max(price)
from products p
group by category;
-- Having Clause
--Kadang kita ingin melakukan filter terhadap data yang sudah kita grouping
--Misal kita ingin menampilkan rata-rata harga per kategori, tapi yang harganya diatas 10.000 misalnya
--Jika menggunakan WHERE di SELECT, hal ini tidak bisa dilakukan
--Untuk memfilter hasil aggregate function, kita harus menggunakan HAVING clause
select category,
	count(id)
from products p
group by category
having count(id) > 5;
select category,
	avg(price),
	min(price),
	max(price)
from products p
group by category
having avg(price) >= 15000;
--Constraint
--Di PostgreSQL, kita bisa menambahkan constraint untuk menjaga data di tabel tetap baik
--Constraint sangat bagus ditambahkan untuk menjaga terjadi validasi yang salah di program kita, sehingga data yang masuk ke database tetap akan terjaga
-- Unique Constraint
--Unique constraint adalah constraint yang memastikan bahwa data kita tetap unique
--Jika kita mencoba memasukkan data yang duplikat, maka PostgreSQL akan menolak data tersebut
create table customer (
	id serial not null,
	email varchar(100) not null,
	fist_name varchar(100) not null,
	last_name varchar(100) not null,
	primary key(id),
	constraint unique_email unique (email)
);
alter table customer
	rename fist_name to first_name;
insert into customer (email, first_name, last_name)
values ('rezaramdanp@gmail.com', 'Reza', 'Permana') -- karena emailnya menggunakan unique constrain maka akan terjadi error
insert into customer (email, first_name, last_name)
values ('rezaramdanp@gmail.com', 'Tatang', 'Budi')
insert into customer (email, first_name, last_name)
values ('udin@gmail.com', 'Udin', 'Budi')
select *
from customer;
-- menghapus unique constraint
alter table customer drop constraint unique_email;
-- menambah unique constraint
alter table customer
add constraint unique_email unique(email);
-- Check Constraint 
--Check constraint adalah constraint yang bisa kita tambahkan kondisi pengecekannya
--Ini cocok untuk mengecek data sebelum dimasukkan ke dalam database
--Misal kita ingin memastikan bahwa harga harus diatas 1000 misal
--Maka kita bisa menggunakan check constraint
select *
from products p;
-- karena sudah ada tabel product maka kita tinggal menambahkan nya mengunakann alter table
alter table products
add constraint price_check check(price >= 1000);
alter table products
add constraint quantity_check check(quantity > 0);
--contoh gagal 
insert into products (id, name, price, quantity, category)
values ('XXX1', 'Contoh Gagal', 10, 0 'Minuman');
--contoh berhasil
insert into products (id, name, price, quantity, category)
values ('XXX1', 'Thai Tea', 5000, 100, 'Minuman');
--menghapus constraint check
alter table products drop constraint price_check;
--index
--Secara default, PostgreSQL akan menyimpan data di dalam disk seperti tabel biasanya
--Hal ini menyebabkan, ketika kita mencari data, maka PostgreSQL akan melakukan pencarian dari baris pertama sampai terakhir, yang artinya semakin banyak datanya, maka akan semakin lambat proses pencarian datanya
--Kita bisa ubah cara PostgreSQL menyimpan data pada kolom, agar mudah dicari, yaitu menggunakan Index
--Saat kita membuat index, PostgreSQL akan menyimpan data dalam struktur data B-Tree : https://en.wikipedia.org/wiki/B-tree 
--Tidak hanya akan mempermudah kita saat melakukan pencarian, index juga akan mempermudah kita ketika melakukan pengurutan menggunakan ORDER BY
-- cara kerja index
--Kita bisa membuat lebih dari satu index di table, dan setiap kita membuat index, kita bisa membuat index untuk beberapa kolom sekaligus
--Misal kita membuat index
--(col1, col2, col3)
--Artinya kita punya kemampuan untuk mencari lebih menggunakan index untuk kombinasi query di (col1), (col1, col2) dan (col1, col2, col3)
-- efek samping menggunakan index
--Index mungkin akan mempercepat untuk proses pencarian dan query data
--Namun, saat kita membuat index, artinya PostgreSQL akan melakukan proses update data di index tiap kali kita menambah, mengubah atau menghapus data di table
--Artinya Index membuat proses pencarian dan query lebih cepat, tapi memperlambat proses manipulasi data (insert, update dan delete)
--Oleh karena itu, kita harus bijak saat membuat index
-- Tidak perlu index
--Saat kita membuat PRIMARY KEY dan UNIQUE constraint, kita tidak perlu menambahkan lagi index
--Hal ini dikarenakan PostgreSQL secara otomatis akan menambahkan index pada kolom PRIMARY KEY dan UNIQUE constraint
-- membuat table sellers dengan metode index
create table selers (
	id serial not null,
	name varchar(100) not null,
	email varchar(100) not null,
	primary key (id),
	constraint email_unique unique(email)
);
-- merename nama tabel
alter table selers
	rename to sellers;
-- memasukan data
insert into sellers (name, email)
values ('Reza', 'reza@gmail.com');
insert into sellers (name, email)
values ('tatang', 'tatang@gmail.com'),
	('budi', 'budi@gmail.com'),
('ase[', 'asep@gmail.com');
select *
from sellers;
update sellers
set name = 'asep'
where id = 4;
-- menambah index
create index sellers_id_name_index on sellers(id, name);
create index sellers_email_name_index on sellers(email, name);
create index sellers_name_index on sellers (name);
-- menghapus index 
drop index nama_index;
select *
from sellers
where id = 1;
select *
from sellers
where id = 1
	or name = 'budi';
select *
from sellers
where email = 'asep@gmail.com'
	or name = 'budi';
select *
from sellers
where name = 'tatang';
-- full-text search
-- masalah dengan like operator
--Kadang kita ingin mencari sebuah kata dalam tabel, dan biasanya kita akan menggunakan LIKE operator
--Operasi yang dilakukan LIKE operator adalah dengan cara mencari seluruh data di tabel dari baris pertama sampai terakhir, hal ini membuat operasi LIKE sangat lambat
--Menambah index di tabel juga tidak akan membantu, karen LIKE operator tidak menggunakan index
--PostgreSQL menyediakan fitur Full Text Search jika ada kasus kita ingin melakukan hal ini
--Full-Text Search memungkinkan kita bisa mencari sebagian kata di kolom dengan tipe data String
--Ini sangat cocok ketika pada kasus kita memang membutuhkan pencarian yang tidak hanya sekedar operasi = (equals, sama dengan)
--https://www.postgresql.org/docs/current/textsearch-intro.html 
--Di PostgreSQL, Full-Text Search menggunakan function to_tsvector(text) dan to_tsquery(query)
--Bahkan kita bisa menggunakan function tersebut tanpa membuat index, namun performanya akan sama saja dengan LIKE, lambat karena harus di cek satu-satu
--Operator Full-Text Search menggunakan @@, bukan = 
select *
from products p;
select *
from products p
where "name" ilike '%mie%';
select *
from products p
where to_tsvector(name) @@ to_tsquery('mie');
-- mengecek bahasa apa saja yg di dukung
select cfgname
from pg_ts_config;
-- membuat dua indeks untuk pencarian teks penuh pada kolom name dan description di tabel products.
-- to_tsvector('indonesian', name) mengubah nilai kolom name menjadi representasi vektor teks dengan konfigurasi bahasa Indonesia.
-- USING gin menunjukkan penggunaan GIN (Generalized Inverted Index) untuk indeksasi, yang cocok untuk full-text search.
create index products_name_search on products using gin (to_tsvector('indonesian', name));
create index products_description_search on products using gin (to_tsvector('indonesian', description));
-- melakukan pencarian full-text pada kolom name di tabel products.
-- to_tsquery('mie') mengubah kata kunci 'mie' menjadi bentuk yang dapat digunakan untuk pencarian full-text.
select *
from products p
where name @@ to_tsquery('mie');
-- melakukan pencarian full-text pada kolom description di tabel products.
-- Sama seperti sebelumnya, to_tsquery('mie') digunakan untuk membuat kata kunci pencarian.
select *
from products p
where description @@ to_tsquery('mie');
-- tipe data tsvector
--Kita juga bisa secara otomatis membuat kolom dengan tipe data TSVECTOR
--Secara otomatis kolom tersebut berisi text yang memiliki index Full-Text Search
-- query operator
--to_tsquery() mendukung banyak operator
select *
from products p
where name @@ to_tsquery('mie');
--& untuk AND
select *
from products p
where name @@ to_tsquery('mie & ayam');
--| untuk OR
select *
from products p
where name @@ to_tsquery('mie | baso');
--! untuk NOT
select *
from products p
where name @@ to_tsquery('!baso');
--“” untuk semua data
select *
from products p
where name @@ to_tsquery('''es teh''');
update products
set name = 'Baso'
where id = 'P0002';
--Table Relationship
--Dalam Relational DBMS, salah satu fitur andalan nya adalah table relationship. Yaitu relasi antar tabel
--Kita bisa melakukan relasi dari satu tabel ke tabel lain.
--Dalam kehidupan nyata pun pasti kita akan sering membuat relasi antar tabel
--Misal, saat kita membuat aplikasi penjualan, di laporan penjualan pasti ada data barang. Jika di tabel artinya tabel penjualan akan berelasi dengan tabel barang
--Misal dalam aplikasi kampus, tabel mahasiswa akan berelasi dengan tabel mata kuliah, dan tabel dosen
--Dan lain-lain
--Foreign Key
--Saat membuat relasi tabel, biasanya kita akan membuat sebuah kolom sebagai referensi ke tabel lainnya
--Misal saat kita membuat tabel penjualan, di dalam tabel penjualan, kita akan menambahkan kolom id_produk sebagai referensi ke tabel produk, yang berisi primary key di tabel produk
--Kolom referensi ini di PostgreSQL dinamakan Foreign Key
--Kita bisa menambah satu satu lebih foreign key ke dalam sebuah tabel
--Membuat foreign key sama seperti membuat kolom biasanya, hanya saja kita perlu memberi tahu PostgreSQL bahwa itu adalah foreign key ke tabel lain