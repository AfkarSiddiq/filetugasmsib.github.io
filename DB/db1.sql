
-- buat database baru : dbpegawai
MariaDB [(none)]> create database dbpegawai;
Query OK, 1 row affected (0.004 sec)

-- masuk ke ruang database dbpegawai
MariaDB [(none)]> use dbpegawai
Database changed

-- tampilkan database yang sudah dibuat
MariaDB [dbpegawai]> show databases;
+--------------------+
| Database           |
+--------------------+
| dbpegawai          |
| information_schema |
| mysql              |
| performance_schema |
| phpmyadmin         |
| test               |
+--------------------+
6 rows in set (0.001 sec)

-- - tampilkan tabel2 yang sudah ada di dbpegawai
MariaDB [dbpegawai]> show tables;
Empty set (0.003 sec)

-- - buat tabel master divisi dengan field2:
--   1. id int primary key auto_increment
--   2. nama varchar(30) dengan contraint: wajib diisi dan tidak boleh sama
MariaDB [dbpegawai]> create table divisi(
    -> id int primary key auto_increment,
    -> nama varchar(30) not null UNIQUE
    -> );
Query OK, 0 rows affected (0.020 sec)


-- - buat tabel relasi pegawai field-field:
--   1. id int primary key auto_increment
--   2. nip char dengan constraint: wajib diisi, tidak boleh sama & 5 karakter
--   3. nama varchar dengan constraint: wajib diisi dan maksimal 30 karakter
--   4. gender enum('L','P') dengan constraint: wajib diisi
--   5. tmp_lahir varchar dengan constraint: wajib diisi dan maksimal 30 karakter
--   6. tgl_lahir date dengan constraint: wajib diisi
--   7. iddivisi int sebagai foreign key, tidak boleh kosong, merujuk ke tabel divisi ke field id
--   8. alamat text
MariaDB [dbpegawai]> create table pegawai(
    ->  id int auto_increment,
    ->  nip char(5) not null unique,
    ->  nama varchar(30) not null,
    ->  gender enum('L', 'P') not null,
    ->  tmp_lahir varchar(30) not null,
    ->  tgl_lahir date not null,
    ->  iddivisi int not null,
    ->  PRIMARY KEY(id),
    ->  FOREIGN KEY(iddivisi) REFERENCES divisi(id),
    ->  alamat text
    ->  );
Query OK, 0 rows affected (0.014 sec)


-- - lihat deskripsi tabel divisi dan pegawai yang sudah dibuat
MariaDB [dbpegawai]> DESC pegawai;
+-----------+---------------+------+-----+---------+----------------+
| Field     | Type          | Null | Key | Default | Extra          |
+-----------+---------------+------+-----+---------+----------------+
| id        | int(11)       | NO   | PRI | NULL    | auto_increment |
| nip       | char(5)       | NO   | UNI | NULL    |                |
| nama      | varchar(30)   | NO   |     | NULL    |                |
| gender    | enum('L','P') | NO   |     | NULL    |                |
| tmp_lahir | varchar(30)   | NO   |     | NULL    |                |
| tgl_lahir | date          | NO   |     | NULL    |                |
| iddivisi  | int(11)       | NO   | MUL | NULL    |                |
| alamat    | text          | YES  |     | NULL    |                |
+-----------+---------------+------+-----+---------+----------------+
8 rows in set (0.005 sec)


MariaDB [dbpegawai]> DESC divisi;
+-------+-------------+------+-----+---------+----------------+
| Field | Type        | Null | Key | Default | Extra          |
+-------+-------------+------+-----+---------+----------------+
| id    | int(11)     | NO   | PRI | NULL    | auto_increment |
| nama  | varchar(30) | NO   | UNI | NULL    |                |
+-------+-------------+------+-----+---------+----------------+
2 rows in set (0.005 sec)

-- - tampilkan tabel yang ada di dbpegawai
MariaDB [dbpegawai]> show tables;
+---------------------+
| Tables_in_dbpegawai |
+---------------------+
| divisi              |
| pegawai             |
+---------------------+
2 rows in set (0.001 sec)


-- - input data divisi => SDM, Keuangan, Marketing, IT
MariaDB [dbpegawai]> INSERT INTO divisi VALUES
    -> ('','SDM');
    -> ('','Keuangan'),
    -> ('', 'Marketing'),
    -> ('', 'IT');
Query OK, 4 rows affected, 4 warnings (0.004 sec)
Records: 4  Duplicates: 0  Warnings: 4

-- - input 20 orang pegawai ( 1 divisi 5 orang, untuk gender dirandom)
MariaDB [dbpegawai]> INSERT INTO pegawai VALUES
 ('', 10021, 'Uci', 'P', 'Jepang', '1999-05-18', 1, 'Jl. Hutabarat'),
 ('', 10022, 'Uca', 'P', 'Jawa', '2000-05-19', 1, 'Jl. Diponegoro'),
 ('', 10023, 'Ucok', 'L', 'Jakarta', '1989-05-18', 1, 'Jl. Kota Baru'),
 ('', 10024, 'Ujang', 'L', 'Depok', '2001-07-09', 1, 'Jl. Kota Lama'),
 ('', 10025, 'Ucup', 'L', 'San Francisco', '2003-04-12', 1, 'Jl. Kampung Baru'),
 ('', 20021, 'Aqua', 'L', 'Osaka', '1999-03-13', 2, 'Jl. Himawari'),
 ('', 20022, 'Ruby', 'P', 'Osaka', '1999-03-13', 2, 'Jl. Himawari'),
 ('', 20023, 'Matthew', 'L', 'Autralia', '2000-07-23', 2, 'Jl. Stronghead'),
 ('', 20024, 'Zhi Hao', 'L', 'Beijing', '1997-05-12', 2, 'Jl. ZhongZheng'),
 ('', 20025, 'Viradaa', 'P', 'Pattani', '2002-06-19', 2, 'Jl. Ban A Ho'),
 ('', 30021, 'Gyuvin', 'L', 'Soul', '2001-02-19', 3, 'Jl. Hongdae'),
 ('', 30022, 'Yunjin', 'P', 'Los Angeles', '1998-02-19', 3, 'Jl. Sami'),
 ('', 30023, 'Sandy', 'P', 'Texas', '2000-11-17', 3, 'Jl. Carolyn'),
 ('', 30024, 'Ma Ji Xiang', 'L', 'Beijing', '2006-12-17', 3, 'Jl. Headache'),
 ('', 30025, 'Dita Anatasya', 'P', 'Medan', '2002-08-17', 3, 'Jl. Gagak Hitam'),
 ('', 40021, 'Putri Maulida', 'P', 'Aceh Utara', '2002-05-12', 4, 'Jl. Simpang Empat'),
 ('', 40022, 'Afkar Siddiq', 'L', 'Medan', '2002-07-28', 4, 'Jl. Pante Gajah'),
 ('', 40023, 'Syifa Azhima', 'P', 'Bireuen', '2002-08-04', 4, 'Jl. Samalanga'),
 ('', 40024, 'Firman Dwi', 'L', 'Simeulu', '2002-08-10', 4, 'Jl. Melur'),
 ('', 40025, 'Anas Naufal', 'L', 'Takengon', '2002-05-28', 4, 'Jl. Genye');
Query OK, 20 rows affected, 20 warnings (0.008 sec)
Records: 20  Duplicates: 0  Warnings: 20

-- - tampilkan seluruh data divisi
MariaDB [dbpegawai]> select * from divisi order by id;
+----+-----------+
| id | nama      |
+----+-----------+
|  1 | SDM       |
|  2 | Keuangan  |
|  3 | Marketing |
|  4 | IT        |
+----+-----------+
4 rows in set (0.003 sec)

-- - tampilkan seluruh data pegawai
MariaDB [dbpegawai]> SELECT *
 FROM pegawai;
+----+-------+---------------+--------+---------------+------------+----------+-------------------+
| id | nip   | nama          | gender | tmp_lahir     | tgl_lahir  | iddivisi | alamat            |
+----+-------+---------------+--------+---------------+------------+----------+-------------------+
|  1 | 10021 | Uci           | P      | Jepang        | 1999-05-18 |        1 | Jl. Hutabarat     |
|  2 | 10022 | Uca           | P      | Jawa          | 2000-05-19 |        1 | Jl. Diponegoro    |
|  3 | 10023 | Ucok          | L      | Jakarta       | 1989-05-18 |        1 | Jl. Kota Baru     |
|  4 | 10024 | Ujang         | L      | Depok         | 2001-07-09 |        1 | Jl. Kota Lama     |
|  5 | 10025 | Ucup          | L      | San Francisco | 2003-04-12 |        1 | Jl. Kampung Baru  |
|  6 | 20021 | Aqua          | L      | Osaka         | 1999-03-13 |        2 | Jl. Himawari      |
|  7 | 20022 | Ruby          | P      | Osaka         | 1999-03-13 |        2 | Jl. Himawari      |
|  8 | 20023 | Matthew       | L      | Autralia      | 2000-07-23 |        2 | Jl. Stronghead    |
|  9 | 20024 | Zhi Hao       | L      | Beijing       | 1997-05-12 |        2 | Jl. ZhongZheng    |
| 10 | 20025 | Viradaa       | P      | Pattani       | 2002-06-19 |        2 | Jl. Ban A Ho      |
| 11 | 30021 | Gyuvin        | L      | Soul          | 2001-02-19 |        3 | Jl. Hongdae       |
| 12 | 30022 | Yunjin        | P      | Los Angeles   | 1998-02-19 |        3 | Jl. Sami          |
| 13 | 30023 | Sandy         | P      | Texas         | 2000-11-17 |        3 | Jl. Carolyn       |
| 14 | 30024 | Ma Ji Xiang   | L      | Beijing       | 2006-12-17 |        3 | Jl. Headache      |
| 15 | 30025 | Dita Anatasya | P      | Medan         | 2002-08-17 |        3 | Jl. Gagak Hitam   |
| 16 | 40021 | Putri Maulida | P      | Aceh Utara    | 2002-05-12 |        4 | Jl. Simpang Empat |
| 17 | 40022 | Afkar Siddiq  | L      | Medan         | 2002-07-28 |        4 | Jl. Pante Gajah   |
| 18 | 40023 | Syifa Azhima  | P      | Bireuen       | 2002-08-04 |        4 | Jl. Samalanga     |
| 19 | 40024 | Firman Dwi    | L      | Simeulu       | 2002-08-10 |        4 | Jl. Melur         |
| 20 | 40025 | Anas Naufal   | L      | Takengon      | 2002-05-28 |        4 | Jl. Genye         |
+----+-------+---------------+--------+---------------+------------+----------+-------------------+
20 rows in set (0.000 sec)

-- - ubah 5 data pegawai (dengan ketentuan ubah 3 kolom(bebas))
MariaDB [dbpegawai]> UPDATE pegawai
    -> SET nama = 'Kung Lao', tmp_lahir = 'Banda Aceh', alamat = 'Jl. Majingjong'
    -> WHERE id = 9;
Query OK, 1 row affected (0.004 sec)
Rows matched: 1  Changed: 1  Warnings: 0

MariaDB [dbpegawai]> UPDATE pegawai
    -> SET nama = 'Kung Lao', tmp_lahir = 'Banda Aceh', alamat = 'Jl. Majingjong'
    -> WHERE id = 9;
Query OK, 1 row affected (0.004 sec)
Rows matched: 1  Changed: 1  Warnings: 0

MariaDB [dbpegawai]> UPDATE pegawai
    -> SET nama = 'Kibutsuji', tmp_lahir='Tokyo', alamat = 'Jl. Toppoki'
    -> WHERE id = 17;
Query OK, 1 row affected (0.004 sec)
Rows matched: 1  Changed: 1  Warnings: 0

MariaDB [dbpegawai]> UPDATE pegawai
    -> SET gender='P', tmp_lahir='Soul', alamat = 'Jl. Gagak'
    -> WHERE id = 14;
Query OK, 1 row affected (0.004 sec)
Rows matched: 1  Changed: 1  Warnings: 0

MariaDB [dbpegawai]> UPDATE pegawai
    -> SET nama = 'Muzan', tgl_lahir='2000-09-10', alamat = 'Jl. jalan'
    -> WHERE id = 12;
Query OK, 1 row affected (0.004 sec)
Rows matched: 1  Changed: 1  Warnings: 0

MariaDB [dbpegawai]> SELECT *
    -> FROM pegawai;
+----+-------+---------------+--------+---------------+------------+----------+-------------------+
| id | nip   | nama          | gender | tmp_lahir     | tgl_lahir  | iddivisi | alamat            |
+----+-------+---------------+--------+---------------+------------+----------+-------------------+
|  1 | 10021 | Uci           | P      | Jepang        | 1999-05-18 |        1 | Jl. Hutabarat     |
|  2 | 10022 | Uca           | P      | Jawa          | 2000-05-19 |        1 | Jl. Diponegoro    |
|  3 | 10023 | Ucok          | L      | Jakarta       | 1989-05-18 |        1 | Jl. Kota Baru     |
|  4 | 10024 | Ujang         | L      | Depok         | 2001-07-09 |        1 | Jl. Kota Lama     |
|  5 | 10025 | Ucup          | L      | San Francisco | 2003-04-12 |        1 | Jl. Kampung Baru  |
|  6 | 20021 | Aqua          | L      | Osaka         | 1999-03-13 |        2 | Jl. Himawari      |
|  7 | 20022 | Ruby          | P      | Osaka         | 1999-03-13 |        2 | Jl. Himawari      |
|  8 | 20023 | Matthew       | L      | Autralia      | 2000-07-23 |        2 | Jl. Stronghead    |
|  9 | 20024 | Kung Lao      | L      | Banda Aceh    | 1997-05-12 |        2 | Jl. Majingjong    |
| 10 | 20025 | Viradaa       | P      | Pattani       | 2002-06-19 |        2 | Jl. Ban A Ho      |
| 11 | 30021 | Gyuryo        | L      | Land of Dawn  | 2001-02-19 |        3 | Jl. Top Lane      |
| 12 | 30022 | Muzan         | P      | Los Angeles   | 2000-09-10 |        3 | Jl. jalan         |
| 13 | 30023 | Sandy         | P      | Texas         | 2000-11-17 |        3 | Jl. Carolyn       |
| 14 | 30024 | Ma Ji Xiang   | P      | Soul          | 2006-12-17 |        3 | Jl. Gagak         |
| 15 | 30025 | Dita Anatasya | P      | Medan         | 2002-08-17 |        3 | Jl. Gagak Hitam   |
| 16 | 40021 | Putri Maulida | P      | Aceh Utara    | 2002-05-12 |        4 | Jl. Simpang Empat |
| 17 | 40022 | Kibutsuji     | L      | Tokyo         | 2002-07-28 |        4 | Jl. Toppoki       |
| 18 | 40023 | Syifa Azhima  | P      | Bireuen       | 2002-08-04 |        4 | Jl. Samalanga     |
| 19 | 40024 | Firman Dwi    | L      | Simeulu       | 2002-08-10 |        4 | Jl. Melur         |
| 20 | 40025 | Anas Naufal   | L      | Takengon      | 2002-05-28 |        4 | Jl. Genye         |
+----+-------+---------------+--------+---------------+------------+----------+-------------------+
20 rows in set (0.001 sec)

-- - hapus 2 pegawai pegawai terakhir
MariaDB [dbpegawai]> DELETE
    -> FROM pegawai
    -> WHERE nama ='Anas Naufal';
Query OK, 1 row affected (0.004 sec)

MariaDB [dbpegawai]> DELETE
    -> FROM pegawai
    -> WHERE nama ='Firman Dwi';
Query OK, 1 row affected (0.003 sec)

MariaDB [dbpegawai]> select * from pegawai;
+----+-------+---------------+--------+---------------+------------+----------+-------------------+
| id | nip   | nama          | gender | tmp_lahir     | tgl_lahir  | iddivisi | alamat            |
+----+-------+---------------+--------+---------------+------------+----------+-------------------+
|  1 | 10021 | Uci           | P      | Jepang        | 1999-05-18 |        1 | Jl. Hutabarat     |
|  2 | 10022 | Uca           | P      | Jawa          | 2000-05-19 |        1 | Jl. Diponegoro    |
|  3 | 10023 | Ucok          | L      | Jakarta       | 1989-05-18 |        1 | Jl. Kota Baru     |
|  4 | 10024 | Ujang         | L      | Depok         | 2001-07-09 |        1 | Jl. Kota Lama     |
|  5 | 10025 | Ucup          | L      | San Francisco | 2003-04-12 |        1 | Jl. Kampung Baru  |
|  6 | 20021 | Aqua          | L      | Osaka         | 1999-03-13 |        2 | Jl. Himawari      |
|  7 | 20022 | Ruby          | P      | Osaka         | 1999-03-13 |        2 | Jl. Himawari      |
|  8 | 20023 | Matthew       | L      | Autralia      | 2000-07-23 |        2 | Jl. Stronghead    |
|  9 | 20024 | Kung Lao      | L      | Banda Aceh    | 1997-05-12 |        2 | Jl. Majingjong    |
| 10 | 20025 | Viradaa       | P      | Pattani       | 2002-06-19 |        2 | Jl. Ban A Ho      |
| 11 | 30021 | Gyuryo        | L      | Land of Dawn  | 2001-02-19 |        3 | Jl. Top Lane      |
| 12 | 30022 | Muzan         | P      | Los Angeles   | 2000-09-10 |        3 | Jl. jalan         |
| 13 | 30023 | Sandy         | P      | Texas         | 2000-11-17 |        3 | Jl. Carolyn       |
| 14 | 30024 | Ma Ji Xiang   | P      | Soul          | 2006-12-17 |        3 | Jl. Gagak         |
| 15 | 30025 | Dita Anatasya | P      | Medan         | 2002-08-17 |        3 | Jl. Gagak Hitam   |
| 16 | 40021 | Putri Maulida | P      | Aceh Utara    | 2002-05-12 |        4 | Jl. Simpang Empat |
| 17 | 40022 | Kibutsuji     | L      | Tokyo         | 2002-07-28 |        4 | Jl. Toppoki       |
| 18 | 40023 | Syifa Azhima  | P      | Bireuen       | 2002-08-04 |        4 | Jl. Samalanga     |
+----+-------+---------------+--------+---------------+------------+----------+-------------------+
18 rows in set (0.000 sec)

-- - gunakan alter tabel untuk menambahkan kolom baru berat_badan setelah kolom gender,
--   lalu input berat badan semua pegawai secara acak

MariaDB [dbpegawai]> ALTER TABLE pegawai
    -> ADD berat_badan FLOAT AFTER gender;
Query OK, 0 rows affected (0.014 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [dbpegawai]> UPDATE pegawai
    -> SET berat_badan = (40 + RAND() * (20-5+5));
Query OK, 18 rows affected (0.003 sec)
Rows matched: 18  Changed: 18  Warnings: 0

MariaDB [dbpegawai]> select * from pegawai;
+----+-------+---------------+--------+-------------+---------------+------------+----------+-------------------+
| id | nip   | nama          | gender | berat_badan | tmp_lahir     | tgl_lahir  | iddivisi | alamat            |
+----+-------+---------------+--------+-------------+---------------+------------+----------+-------------------+
|  1 | 10021 | Uci           | P      |     52.0761 | Jepang        | 1999-05-18 |        1 | Jl. Hutabarat     |
|  2 | 10022 | Uca           | P      |     55.3693 | Jawa          | 2000-05-19 |        1 | Jl. Diponegoro    |
|  3 | 10023 | Ucok          | L      |     40.6181 | Jakarta       | 1989-05-18 |        1 | Jl. Kota Baru     |
|  4 | 10024 | Ujang         | L      |     56.9827 | Depok         | 2001-07-09 |        1 | Jl. Kota Lama     |
|  5 | 10025 | Ucup          | L      |      43.059 | San Francisco | 2003-04-12 |        1 | Jl. Kampung Baru  |
|  6 | 20021 | Aqua          | L      |     44.3469 | Osaka         | 1999-03-13 |        2 | Jl. Himawari      |
|  7 | 20022 | Ruby          | P      |     52.5577 | Osaka         | 1999-03-13 |        2 | Jl. Himawari      |
|  8 | 20023 | Matthew       | L      |     49.7476 | Autralia      | 2000-07-23 |        2 | Jl. Stronghead    |
|  9 | 20024 | Kung Lao      | L      |     51.0649 | Banda Aceh    | 1997-05-12 |        2 | Jl. Majingjong    |
| 10 | 20025 | Viradaa       | P      |     46.0816 | Pattani       | 2002-06-19 |        2 | Jl. Ban A Ho      |
| 11 | 30021 | Gyuryo        | L      |     57.2133 | Land of Dawn  | 2001-02-19 |        3 | Jl. Top Lane      |
| 12 | 30022 | Muzan         | P      |     47.8216 | Los Angeles   | 2000-09-10 |        3 | Jl. jalan         |
| 13 | 30023 | Sandy         | P      |     47.4682 | Texas         | 2000-11-17 |        3 | Jl. Carolyn       |
| 14 | 30024 | Ma Ji Xiang   | P      |     53.8764 | Soul          | 2006-12-17 |        3 | Jl. Gagak         |
| 15 | 30025 | Dita Anatasya | P      |     46.9773 | Medan         | 2002-08-17 |        3 | Jl. Gagak Hitam   |
| 16 | 40021 | Putri Maulida | P      |     53.2573 | Aceh Utara    | 2002-05-12 |        4 | Jl. Simpang Empat |
| 17 | 40022 | Kibutsuji     | L      |     45.3544 | Tokyo         | 2002-07-28 |        4 | Jl. Toppoki       |
| 18 | 40023 | Syifa Azhima  | P      |     47.0004 | Bireuen       | 2002-08-04 |        4 | Jl. Samalanga     |
+----+-------+---------------+--------+-------------+---------------+------------+----------+-------------------+
18 rows in set (0.001 sec)

-- gunakan alter tabel untuk menambahkan kolom baru umur setelah kolom berat_badan, 
--   lalu input umur semua pegawai secara acak

MariaDB [dbpegawai]> ALTER TABLE pegawai
    -> ADD umur INT AFTER berat_badan;
Query OK, 0 rows affected (0.007 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [dbpegawai]> UPDATE pegawai
    -> SET umur = (YEAR(NOW())-YEAR(tgl_lahir));
Query OK, 18 rows affected (0.004 sec)
Rows matched: 18  Changed: 18  Warnings: 0

MariaDB [dbpegawai]> select * from pegawai;
+----+-------+---------------+--------+-------------+------+---------------+------------+----------+-------------------+
| id | nip   | nama          | gender | berat_badan | umur | tmp_lahir     | tgl_lahir  | iddivisi | alamat            |
+----+-------+---------------+--------+-------------+------+---------------+------------+----------+-------------------+
|  1 | 10021 | Uci           | P      |     52.0761 |   24 | Jepang        | 1999-05-18 |        1 | Jl. Hutabarat     |
|  2 | 10022 | Uca           | P      |     55.3693 |   23 | Jawa          | 2000-05-19 |        1 | Jl. Diponegoro    |
|  3 | 10023 | Ucok          | L      |     40.6181 |   34 | Jakarta       | 1989-05-18 |        1 | Jl. Kota Baru     |
|  4 | 10024 | Ujang         | L      |     56.9827 |   22 | Depok         | 2001-07-09 |        1 | Jl. Kota Lama     |
|  5 | 10025 | Ucup          | L      |      43.059 |   20 | San Francisco | 2003-04-12 |        1 | Jl. Kampung Baru  |
|  6 | 20021 | Aqua          | L      |     44.3469 |   24 | Osaka         | 1999-03-13 |        2 | Jl. Himawari      |
|  7 | 20022 | Ruby          | P      |     52.5577 |   24 | Osaka         | 1999-03-13 |        2 | Jl. Himawari      |
|  8 | 20023 | Matthew       | L      |     49.7476 |   23 | Autralia      | 2000-07-23 |        2 | Jl. Stronghead    |
|  9 | 20024 | Kung Lao      | L      |     51.0649 |   26 | Banda Aceh    | 1997-05-12 |        2 | Jl. Majingjong    |
| 10 | 20025 | Viradaa       | P      |     46.0816 |   21 | Pattani       | 2002-06-19 |        2 | Jl. Ban A Ho      |
| 11 | 30021 | Gyuryo        | L      |     57.2133 |   22 | Land of Dawn  | 2001-02-19 |        3 | Jl. Top Lane      |
| 12 | 30022 | Muzan         | P      |     47.8216 |   23 | Los Angeles   | 2000-09-10 |        3 | Jl. jalan         |
| 13 | 30023 | Sandy         | P      |     47.4682 |   23 | Texas         | 2000-11-17 |        3 | Jl. Carolyn       |
| 14 | 30024 | Ma Ji Xiang   | P      |     53.8764 |   17 | Soul          | 2006-12-17 |        3 | Jl. Gagak         |
| 15 | 30025 | Dita Anatasya | P      |     46.9773 |   21 | Medan         | 2002-08-17 |        3 | Jl. Gagak Hitam   |
| 16 | 40021 | Putri Maulida | P      |     53.2573 |   21 | Aceh Utara    | 2002-05-12 |        4 | Jl. Simpang Empat |
| 17 | 40022 | Kibutsuji     | L      |     45.3544 |   21 | Tokyo         | 2002-07-28 |        4 | Jl. Toppoki       |
| 18 | 40023 | Syifa Azhima  | P      |     47.0004 |   21 | Bireuen       | 2002-08-04 |        4 | Jl. Samalanga     |
+----+-------+---------------+--------+-------------+------+---------------+------------+----------+-------------------+
18 rows in set (0.001 sec)

-- - gunakan alter tabel untuk menambahkan kolom gaji di akhir kolom, 
--   lalu input gaji semua pegawai secara acak

MariaDB [dbpegawai]> ALTER TABLE pegawai
    -> ADD gaji int (8);
Query OK, 0 rows affected (0.006 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [dbpegawai]> UPDATE pegawai
    -> SET gaji = (3000000 + RAND() * (8000000 -3000000+3000000));
Query OK, 18 rows affected (0.004 sec)
Rows matched: 18  Changed: 18  Warnings: 0

-- - tampilkan seluruh data staff

MariaDB [dbpegawai]> select * from pegawai;
+----+-------+---------------+--------+-------------+------+---------------+------------+----------+-------------------+----------+
| id | nip   | nama          | gender | berat_badan | umur | tmp_lahir     | tgl_lahir  | iddivisi | alamat            | gaji     |
+----+-------+---------------+--------+-------------+------+---------------+------------+----------+-------------------+----------+
|  1 | 10021 | Uci           | P      |     52.0761 |   24 | Jepang        | 1999-05-18 |        1 | Jl. Hutabarat     |  3351853 |
|  2 | 10022 | Uca           | P      |     55.3693 |   23 | Jawa          | 2000-05-19 |        1 | Jl. Diponegoro    |  7576510 |
|  3 | 10023 | Ucok          | L      |     40.6181 |   34 | Jakarta       | 1989-05-18 |        1 | Jl. Kota Baru     |  8826991 |
|  4 | 10024 | Ujang         | L      |     56.9827 |   22 | Depok         | 2001-07-09 |        1 | Jl. Kota Lama     | 10405426 |
|  5 | 10025 | Ucup          | L      |      43.059 |   20 | San Francisco | 2003-04-12 |        1 | Jl. Kampung Baru  |  6546156 |
|  6 | 20021 | Aqua          | L      |     44.3469 |   24 | Osaka         | 1999-03-13 |        2 | Jl. Himawari      |  6514503 |
|  7 | 20022 | Ruby          | P      |     52.5577 |   24 | Osaka         | 1999-03-13 |        2 | Jl. Himawari      |  9934047 |
|  8 | 20023 | Matthew       | L      |     49.7476 |   23 | Autralia      | 2000-07-23 |        2 | Jl. Stronghead    |  3126726 |
|  9 | 20024 | Kung Lao      | L      |     51.0649 |   26 | Banda Aceh    | 1997-05-12 |        2 | Jl. Majingjong    |  6831488 |
| 10 | 20025 | Viradaa       | P      |     46.0816 |   21 | Pattani       | 2002-06-19 |        2 | Jl. Ban A Ho      |  5777262 |
| 11 | 30021 | Gyuryo        | L      |     57.2133 |   22 | Land of Dawn  | 2001-02-19 |        3 | Jl. Top Lane      |  5391848 |
| 12 | 30022 | Muzan         | P      |     47.8216 |   23 | Los Angeles   | 2000-09-10 |        3 | Jl. jalan         |  6627455 |
| 13 | 30023 | Sandy         | P      |     47.4682 |   23 | Texas         | 2000-11-17 |        3 | Jl. Carolyn       |  5961731 |
| 14 | 30024 | Ma Ji Xiang   | P      |     53.8764 |   17 | Soul          | 2006-12-17 |        3 | Jl. Gagak         |  6926289 |
| 15 | 30025 | Dita Anatasya | P      |     46.9773 |   21 | Medan         | 2002-08-17 |        3 | Jl. Gagak Hitam   |  5746255 |
| 16 | 40021 | Putri Maulida | P      |     53.2573 |   21 | Aceh Utara    | 2002-05-12 |        4 | Jl. Simpang Empat |  4952405 |
| 17 | 40022 | Kibutsuji     | L      |     45.3544 |   21 | Tokyo         | 2002-07-28 |        4 | Jl. Toppoki       |  4523262 |
| 18 | 40023 | Syifa Azhima  | P      |     47.0004 |   21 | Bireuen       | 2002-08-04 |        4 | Jl. Samalanga     |  4759096 |
+----+-------+---------------+--------+-------------+------+---------------+------------+----------+-------------------+----------+
18 rows in set (0.000 sec)

-- - tampilkan kolom2 tertentu di tabel staff (bebas, contoh: nip,nama,gender,umur)
MariaDB [dbpegawai]> SELECT nama, iddivisi, umur
    -> FROM pegawai;
+---------------+----------+------+
| nama          | iddivisi | umur |
+---------------+----------+------+
| Uci           |        1 |   24 |
| Uca           |        1 |   23 |
| Ucok          |        1 |   34 |
| Ujang         |        1 |   22 |
| Ucup          |        1 |   20 |
| Aqua          |        2 |   24 |
| Ruby          |        2 |   24 |
| Matthew       |        2 |   23 |
| Kung Lao      |        2 |   26 |
| Viradaa       |        2 |   21 |
| Gyuryo        |        3 |   22 |
| Muzan         |        3 |   23 |
| Sandy         |        3 |   23 |
| Ma Ji Xiang   |        3 |   17 |
| Dita Anatasya |        3 |   21 |
| Putri Maulida |        4 |   21 |
| Kibutsuji     |        4 |   21 |
| Syifa Azhima  |        4 |   21 |
+---------------+----------+------+
18 rows in set (0.001 sec)




-- - tampilkan baris2 tertentu di tabel staff (bebas, contoh: menampilkan yang gendernya laki2 saja)

MariaDB [dbpegawai]> SELECT nama
    -> FROM pegawai
    -> WHERE gender = 'L';
+-----------+
| nama      |
+-----------+
| Ucok      |
| Ujang     |
| Ucup      |
| Aqua      |
| Matthew   |
| Kung Lao  |
| Gyuryo    |
| Kibutsuji |
+-----------+
8 rows in set (0.000 sec)

-- - tampilkan kolom2 dan baris2 tertentu di tabel staff (bebas)

MariaDB [dbpegawai]> SELECT nama, gender, umur
    -> FROM pegawai
    -> WHERE gender = 'L';
+-----------+--------+------+
| nama      | gender | umur |
+-----------+--------+------+
| Ucok      | L      |   34 |
| Ujang     | L      |   22 |
| Ucup      | L      |   20 |
| Aqua      | L      |   24 |
| Matthew   | L      |   23 |
| Kung Lao  | L      |   26 |
| Gyuryo    | L      |   22 |
| Kibutsuji | L      |   21 |
+-----------+--------+------+
8 rows in set (0.001 sec)


-- - tampilkan data pegawai yang umurnya di atas 30 tahun dan lahirnya di kota jakarta
MariaDB [dbpegawai]> SELECT *
    -> FROM pegawai
    -> WHERE (umur > 30 AND tmp_lahir = 'Jakarta');
+----+-------+------+--------+-------------+------+-----------+------------+----------+---------------+---------+
| id | nip   | nama | gender | berat_badan | umur | tmp_lahir | tgl_lahir  | iddivisi | alamat        | gaji    |
+----+-------+------+--------+-------------+------+-----------+------------+----------+---------------+---------+
|  3 | 10023 | Ucok | L      |     40.6181 |   34 | Jakarta   | 1989-05-18 |        1 | Jl. Kota Baru | 8826991 |
+----+-------+------+--------+-------------+------+-----------+------------+----------+---------------+---------+
1 row in set (0.000 sec)

-- - tampilkan data pegawai dengan klausa key (nip)

MariaDB [dbpegawai]> SELECT *
    -> FROM pegawai
    -> WHERE nip = 40023;
+----+-------+--------------+--------+-------------+------+-----------+------------+----------+---------------+---------+
| id | nip   | nama         | gender | berat_badan | umur | tmp_lahir | tgl_lahir  | iddivisi | alamat        | gaji    |
+----+-------+--------------+--------+-------------+------+-----------+------------+----------+---------------+---------+
| 18 | 40023 | Syifa Azhima | P      |     47.0004 |   21 | Bireuen   | 2002-08-04 |        4 | Jl. Samalanga | 4759096 |
+----+-------+--------------+--------+-------------+------+-----------+------------+----------+---------------+---------+
1 row in set (0.000 sec)

-- - tampilkan data pegawai dengan klausa non key (gender)

MariaDB [dbpegawai]> SELECT *
    -> FROM pegawai
    -> WHERE gender = 'P';
+----+-------+---------------+--------+-------------+------+-------------+------------+----------+-------------------+---------+
| id | nip   | nama          | gender | berat_badan | umur | tmp_lahir   | tgl_lahir  | iddivisi | alamat            | gaji    |
+----+-------+---------------+--------+-------------+------+-------------+------------+----------+-------------------+---------+
|  1 | 10021 | Uci           | P      |     52.0761 |   24 | Jepang      | 1999-05-18 |        1 | Jl. Hutabarat     | 3351853 |
|  2 | 10022 | Uca           | P      |     55.3693 |   23 | Jawa        | 2000-05-19 |        1 | Jl. Diponegoro    | 7576510 |
|  7 | 20022 | Ruby          | P      |     52.5577 |   24 | Osaka       | 1999-03-13 |        2 | Jl. Himawari      | 9934047 |
| 10 | 20025 | Viradaa       | P      |     46.0816 |   21 | Pattani     | 2002-06-19 |        2 | Jl. Ban A Ho      | 5777262 |
| 12 | 30022 | Muzan         | P      |     47.8216 |   23 | Los Angeles | 2000-09-10 |        3 | Jl. jalan         | 6627455 |
| 13 | 30023 | Sandy         | P      |     47.4682 |   23 | Texas       | 2000-11-17 |        3 | Jl. Carolyn       | 5961731 |
| 14 | 30024 | Ma Ji Xiang   | P      |     53.8764 |   17 | Soul        | 2006-12-17 |        3 | Jl. Gagak         | 6926289 |
| 15 | 30025 | Dita Anatasya | P      |     46.9773 |   21 | Medan       | 2002-08-17 |        3 | Jl. Gagak Hitam   | 5746255 |
| 16 | 40021 | Putri Maulida | P      |     53.2573 |   21 | Aceh Utara  | 2002-05-12 |        4 | Jl. Simpang Empat | 4952405 |
| 18 | 40023 | Syifa Azhima  | P      |     47.0004 |   21 | Bireuen     | 2002-08-04 |        4 | Jl. Samalanga     | 4759096 |
+----+-------+---------------+--------+-------------+------+-------------+------------+----------+-------------------+---------+
10 rows in set (0.000 sec)

-- - tampilkan data pegawai dengan klausa in (menyebutkan beberapa nip)

MariaDB [dbpegawai]> SELECT *
    -> FROM pegawai
    -> WHERE nip IN (10021, 40023, 20023, 30021, 40021);
+----+-------+---------------+--------+-------------+------+--------------+------------+----------+-------------------+---------+
| id | nip   | nama          | gender | berat_badan | umur | tmp_lahir    | tgl_lahir  | iddivisi | alamat            | gaji    |
+----+-------+---------------+--------+-------------+------+--------------+------------+----------+-------------------+---------+
|  1 | 10021 | Uci           | P      |     52.0761 |   24 | Jepang       | 1999-05-18 |        1 | Jl. Hutabarat     | 3351853 |
|  8 | 20023 | Matthew       | L      |     49.7476 |   23 | Autralia     | 2000-07-23 |        2 | Jl. Stronghead    | 3126726 |
| 11 | 30021 | Gyuryo        | L      |     57.2133 |   22 | Land of Dawn | 2001-02-19 |        3 | Jl. Top Lane      | 5391848 |
| 16 | 40021 | Putri Maulida | P      |     53.2573 |   21 | Aceh Utara   | 2002-05-12 |        4 | Jl. Simpang Empat | 4952405 |
| 18 | 40023 | Syifa Azhima  | P      |     47.0004 |   21 | Bireuen      | 2002-08-04 |        4 | Jl. Samalanga     | 4759096 |
+----+-------+---------------+--------+-------------+------+--------------+------------+----------+-------------------+---------+
5 rows in set (0.001 sec)

-- - tampilkan data pegawai dengan klausa not in (menyebutkan beberapa tempat lahir)

MariaDB [dbpegawai]> SELECT *
    -> FROM pegawai
    -> WHERE tmp_lahir NOT IN ('Jepang', 'Australia', 'Pattani', 'Los Angeles', 'Soul');
+----+-------+---------------+--------+-------------+------+---------------+------------+----------+-------------------+----------+
| id | nip   | nama          | gender | berat_badan | umur | tmp_lahir     | tgl_lahir  | iddivisi | alamat            | gaji     |
+----+-------+---------------+--------+-------------+------+---------------+------------+----------+-------------------+----------+
|  2 | 10022 | Uca           | P      |     55.3693 |   23 | Jawa          | 2000-05-19 |        1 | Jl. Diponegoro    |  7576510 |
|  3 | 10023 | Ucok          | L      |     40.6181 |   34 | Jakarta       | 1989-05-18 |        1 | Jl. Kota Baru     |  8826991 |
|  4 | 10024 | Ujang         | L      |     56.9827 |   22 | Depok         | 2001-07-09 |        1 | Jl. Kota Lama     | 10405426 |
|  5 | 10025 | Ucup          | L      |      43.059 |   20 | San Francisco | 2003-04-12 |        1 | Jl. Kampung Baru  |  6546156 |
|  6 | 20021 | Aqua          | L      |     44.3469 |   24 | Osaka         | 1999-03-13 |        2 | Jl. Himawari      |  6514503 |
|  7 | 20022 | Ruby          | P      |     52.5577 |   24 | Osaka         | 1999-03-13 |        2 | Jl. Himawari      |  9934047 |
|  8 | 20023 | Matthew       | L      |     49.7476 |   23 | Autralia      | 2000-07-23 |        2 | Jl. Stronghead    |  3126726 |
|  9 | 20024 | Kung Lao      | L      |     51.0649 |   26 | Banda Aceh    | 1997-05-12 |        2 | Jl. Majingjong    |  6831488 |
| 11 | 30021 | Gyuryo        | L      |     57.2133 |   22 | Land of Dawn  | 2001-02-19 |        3 | Jl. Top Lane      |  5391848 |
| 13 | 30023 | Sandy         | P      |     47.4682 |   23 | Texas         | 2000-11-17 |        3 | Jl. Carolyn       |  5961731 |
| 15 | 30025 | Dita Anatasya | P      |     46.9773 |   21 | Medan         | 2002-08-17 |        3 | Jl. Gagak Hitam   |  5746255 |
| 16 | 40021 | Putri Maulida | P      |     53.2573 |   21 | Aceh Utara    | 2002-05-12 |        4 | Jl. Simpang Empat |  4952405 |
| 17 | 40022 | Kibutsuji     | L      |     45.3544 |   21 | Tokyo         | 2002-07-28 |        4 | Jl. Toppoki       |  4523262 |
| 18 | 40023 | Syifa Azhima  | P      |     47.0004 |   21 | Bireuen       | 2002-08-04 |        4 | Jl. Samalanga     |  4759096 |
+----+-------+---------------+--------+-------------+------+---------------+------------+----------+-------------------+----------+
14 rows in set (0.001 sec)

-- - tampilkan data pegawai berdasarkan nama secara ascending

MariaDB [dbpegawai]> SELECT *
    -> FROM  pegawai
    -> ORDER BY nama ASC;
+----+-------+---------------+--------+-------------+------+---------------+------------+----------+-------------------+----------+
| id | nip   | nama          | gender | berat_badan | umur | tmp_lahir     | tgl_lahir  | iddivisi | alamat            | gaji     |
+----+-------+---------------+--------+-------------+------+---------------+------------+----------+-------------------+----------+
|  6 | 20021 | Aqua          | L      |     44.3469 |   24 | Osaka         | 1999-03-13 |        2 | Jl. Himawari      |  6514503 |
| 15 | 30025 | Dita Anatasya | P      |     46.9773 |   21 | Medan         | 2002-08-17 |        3 | Jl. Gagak Hitam   |  5746255 |
| 11 | 30021 | Gyuryo        | L      |     57.2133 |   22 | Land of Dawn  | 2001-02-19 |        3 | Jl. Top Lane      |  5391848 |
| 17 | 40022 | Kibutsuji     | L      |     45.3544 |   21 | Tokyo         | 2002-07-28 |        4 | Jl. Toppoki       |  4523262 |
|  9 | 20024 | Kung Lao      | L      |     51.0649 |   26 | Banda Aceh    | 1997-05-12 |        2 | Jl. Majingjong    |  6831488 |
| 14 | 30024 | Ma Ji Xiang   | P      |     53.8764 |   17 | Soul          | 2006-12-17 |        3 | Jl. Gagak         |  6926289 |
|  8 | 20023 | Matthew       | L      |     49.7476 |   23 | Autralia      | 2000-07-23 |        2 | Jl. Stronghead    |  3126726 |
| 12 | 30022 | Muzan         | P      |     47.8216 |   23 | Los Angeles   | 2000-09-10 |        3 | Jl. jalan         |  6627455 |
| 16 | 40021 | Putri Maulida | P      |     53.2573 |   21 | Aceh Utara    | 2002-05-12 |        4 | Jl. Simpang Empat |  4952405 |
|  7 | 20022 | Ruby          | P      |     52.5577 |   24 | Osaka         | 1999-03-13 |        2 | Jl. Himawari      |  9934047 |
| 13 | 30023 | Sandy         | P      |     47.4682 |   23 | Texas         | 2000-11-17 |        3 | Jl. Carolyn       |  5961731 |
| 18 | 40023 | Syifa Azhima  | P      |     47.0004 |   21 | Bireuen       | 2002-08-04 |        4 | Jl. Samalanga     |  4759096 |
|  2 | 10022 | Uca           | P      |     55.3693 |   23 | Jawa          | 2000-05-19 |        1 | Jl. Diponegoro    |  7576510 |
|  1 | 10021 | Uci           | P      |     52.0761 |   24 | Jepang        | 1999-05-18 |        1 | Jl. Hutabarat     |  3351853 |
|  3 | 10023 | Ucok          | L      |     40.6181 |   34 | Jakarta       | 1989-05-18 |        1 | Jl. Kota Baru     |  8826991 |
|  5 | 10025 | Ucup          | L      |      43.059 |   20 | San Francisco | 2003-04-12 |        1 | Jl. Kampung Baru  |  6546156 |
|  4 | 10024 | Ujang         | L      |     56.9827 |   22 | Depok         | 2001-07-09 |        1 | Jl. Kota Lama     | 10405426 |
| 10 | 20025 | Viradaa       | P      |     46.0816 |   21 | Pattani       | 2002-06-19 |        2 | Jl. Ban A Ho      |  5777262 |
+----+-------+---------------+--------+-------------+------+---------------+------------+----------+-------------------+----------+
18 rows in set (0.002 sec)

-- - tampilkan data pegawai dari yang berat badan paling gemuk ke paling kurus

MariaDB [dbpegawai]> SELECT *
    -> FROM pegawai
    -> ORDER BY berat_badan DESC;
+----+-------+---------------+--------+-------------+------+---------------+------------+----------+-------------------+----------+
| id | nip   | nama          | gender | berat_badan | umur | tmp_lahir     | tgl_lahir  | iddivisi | alamat            | gaji     |
+----+-------+---------------+--------+-------------+------+---------------+------------+----------+-------------------+----------+
| 11 | 30021 | Gyuryo        | L      |     57.2133 |   22 | Land of Dawn  | 2001-02-19 |        3 | Jl. Top Lane      |  5391848 |
|  4 | 10024 | Ujang         | L      |     56.9827 |   22 | Depok         | 2001-07-09 |        1 | Jl. Kota Lama     | 10405426 |
|  2 | 10022 | Uca           | P      |     55.3693 |   23 | Jawa          | 2000-05-19 |        1 | Jl. Diponegoro    |  7576510 |
| 14 | 30024 | Ma Ji Xiang   | P      |     53.8764 |   17 | Soul          | 2006-12-17 |        3 | Jl. Gagak         |  6926289 |
| 16 | 40021 | Putri Maulida | P      |     53.2573 |   21 | Aceh Utara    | 2002-05-12 |        4 | Jl. Simpang Empat |  4952405 |
|  7 | 20022 | Ruby          | P      |     52.5577 |   24 | Osaka         | 1999-03-13 |        2 | Jl. Himawari      |  9934047 |
|  1 | 10021 | Uci           | P      |     52.0761 |   24 | Jepang        | 1999-05-18 |        1 | Jl. Hutabarat     |  3351853 |
|  9 | 20024 | Kung Lao      | L      |     51.0649 |   26 | Banda Aceh    | 1997-05-12 |        2 | Jl. Majingjong    |  6831488 |
|  8 | 20023 | Matthew       | L      |     49.7476 |   23 | Autralia      | 2000-07-23 |        2 | Jl. Stronghead    |  3126726 |
| 12 | 30022 | Muzan         | P      |     47.8216 |   23 | Los Angeles   | 2000-09-10 |        3 | Jl. jalan         |  6627455 |
| 13 | 30023 | Sandy         | P      |     47.4682 |   23 | Texas         | 2000-11-17 |        3 | Jl. Carolyn       |  5961731 |
| 18 | 40023 | Syifa Azhima  | P      |     47.0004 |   21 | Bireuen       | 2002-08-04 |        4 | Jl. Samalanga     |  4759096 |
| 15 | 30025 | Dita Anatasya | P      |     46.9773 |   21 | Medan         | 2002-08-17 |        3 | Jl. Gagak Hitam   |  5746255 |
| 10 | 20025 | Viradaa       | P      |     46.0816 |   21 | Pattani       | 2002-06-19 |        2 | Jl. Ban A Ho      |  5777262 |
| 17 | 40022 | Kibutsuji     | L      |     45.3544 |   21 | Tokyo         | 2002-07-28 |        4 | Jl. Toppoki       |  4523262 |
|  6 | 20021 | Aqua          | L      |     44.3469 |   24 | Osaka         | 1999-03-13 |        2 | Jl. Himawari      |  6514503 |
|  5 | 10025 | Ucup          | L      |      43.059 |   20 | San Francisco | 2003-04-12 |        1 | Jl. Kampung Baru  |  6546156 |
|  3 | 10023 | Ucok          | L      |     40.6181 |   34 | Jakarta       | 1989-05-18 |        1 | Jl. Kota Baru     |  8826991 |
+----+-------+---------------+--------+-------------+------+---------------+------------+----------+-------------------+----------+
18 rows in set (0.001 sec)

-- - tampilkan data 5 pegawai teratas gunakan klausa limit

MariaDB [dbpegawai]> SELECT *
    -> FROM pegawai
    -> LIMIT 5;
+----+-------+-------+--------+-------------+------+---------------+------------+----------+------------------+----------+
| id | nip   | nama  | gender | berat_badan | umur | tmp_lahir     | tgl_lahir  | iddivisi | alamat           | gaji     |
+----+-------+-------+--------+-------------+------+---------------+------------+----------+------------------+----------+
|  1 | 10021 | Uci   | P      |     52.0761 |   24 | Jepang        | 1999-05-18 |        1 | Jl. Hutabarat    |  3351853 |
|  2 | 10022 | Uca   | P      |     55.3693 |   23 | Jawa          | 2000-05-19 |        1 | Jl. Diponegoro   |  7576510 |
|  3 | 10023 | Ucok  | L      |     40.6181 |   34 | Jakarta       | 1989-05-18 |        1 | Jl. Kota Baru    |  8826991 |
|  4 | 10024 | Ujang | L      |     56.9827 |   22 | Depok         | 2001-07-09 |        1 | Jl. Kota Lama    | 10405426 |
|  5 | 10025 | Ucup  | L      |      43.059 |   20 | San Francisco | 2003-04-12 |        1 | Jl. Kampung Baru |  6546156 |
+----+-------+-------+--------+-------------+------+---------------+------------+----------+------------------+----------+
5 rows in set (0.000 sec)

-- - tampilkan data 5 pegawai terbawah gunakan klausa limit offset

MariaDB [dbpegawai]> SELECT *
    -> FROM pegawai
    -> LIMIT 5 OFFSET 13;
+----+-------+---------------+--------+-------------+------+------------+------------+----------+-------------------+---------+
| id | nip   | nama          | gender | berat_badan | umur | tmp_lahir  | tgl_lahir  | iddivisi | alamat            | gaji    |
+----+-------+---------------+--------+-------------+------+------------+------------+----------+-------------------+---------+
| 14 | 30024 | Ma Ji Xiang   | P      |     53.8764 |   17 | Soul       | 2006-12-17 |        3 | Jl. Gagak         | 6926289 |
| 15 | 30025 | Dita Anatasya | P      |     46.9773 |   21 | Medan      | 2002-08-17 |        3 | Jl. Gagak Hitam   | 5746255 |
| 16 | 40021 | Putri Maulida | P      |     53.2573 |   21 | Aceh Utara | 2002-05-12 |        4 | Jl. Simpang Empat | 4952405 |
| 17 | 40022 | Kibutsuji     | L      |     45.3544 |   21 | Tokyo      | 2002-07-28 |        4 | Jl. Toppoki       | 4523262 |
| 18 | 40023 | Syifa Azhima  | P      |     47.0004 |   21 | Bireuen    | 2002-08-04 |        4 | Jl. Samalanga     | 4759096 |
+----+-------+---------------+--------+-------------+------+------------+------------+----------+-------------------+---------+
5 rows in set (0.000 sec)

-- - tampilkan jumlah pegawai gunakan fungsi aggregrat count

MariaDB [dbpegawai]> SELECT COUNT(*)
    -> AS jumlah_pegawai
    -> FROM pegawai;
+----------------+
| jumlah_pegawai |
+----------------+
|             18 |
+----------------+
1 row in set (0.001 sec)

-- - tampilkan data rata2 umur pegawai gunakan fungsi aggregrat avg

MariaDB [dbpegawai]> SELECT AVG(umur)
    -> AS rata_rata_umur
    -> FROM pegawai;
+----------------+
| rata_rata_umur |
+----------------+
|        22.7778 |
+----------------+
1 row in set (0.002 sec)

-- - tampilkan jumlah data pegawai yang laki2 gunakan fungsi aggregrat count

MariaDB [dbpegawai]> SELECT COUNT(*)
    -> AS Jumlah_laki_laki
    -> FROM pegawai
    -> WHERE gender = 'L';
+------------------+
| Jumlah_laki_laki |
+------------------+
|                8 |
+------------------+
1 row in set (0.001 sec)

-- - tampilkan jumlah data pegawai yang perempuan gunakan fungsi aggregrat count

MariaDB [dbpegawai]> SELECT COUNT(*)
    -> AS Jumlah_perempuan
    -> FROM pegawai
    -> WHERE gender = 'P';
+------------------+
| Jumlah_perempuan |
+------------------+
|               10 |
+------------------+
1 row in set (0.000 sec)

-- - tampilkan total berat badan seluruh pegawai gunakan fungsi aggregrat sum

MariaDB [dbpegawai]> SELECT SUM(berat_badan)
    -> AS total_BB
    -> FROM pegawai;
+-------------------+
| total_BB          |
+-------------------+
| 890.8726119995117 |
+-------------------+
1 row in set (0.004 sec)

-- - tampilkan nip,nama pegawai, umur yg paling tua gunakan fungsi aggregrat max (kombinasi dengan sub query)

MariaDB [dbpegawai]> SELECT nip, nama, umur
    -> FROM pegawai
    -> WHERE umur = (SELECT MAX(umur) FROM pegawai);
+-------+------+------+
| nip   | nama | umur |
+-------+------+------+
| 10023 | Ucok |   34 |
+-------+------+------+
1 row in set (0.001 sec)

-- - tampilkan nip,nama pegawai, berat_badan yg paling kurus gunakan fungsi aggregrat min (kombinasi dengan sub query)

MariaDB [dbpegawai]> SELECT nip, nama, umur
    -> FROM pegawai
    -> WHERE umur = (SELECT MIN(umur) FROM pegawai);
+-------+-------------+------+
| nip   | nama        | umur |
+-------+-------------+------+
| 30024 | Ma Ji Xiang |   17 |
+-------+-------------+------+
1 row in set (0.000 sec)

-- - tampilkan nip,nama pegawai, gaji, kolom baru keterangan dengan klausa case:
--   Gaji < 4 , keterangan Gaji Kecil
--   Gaji 4jt s/d 7 jt, keterangan Gaji Sedang
--   Gaji > 7 jt, keterangan Gaji Besar

MariaDB [dbpegawai]> SELECT nip, nama, gaji,
    -> CASE
    -> WHEN gaji < 4000000 THEN 'Gaji Kecil'
    -> WHEN gaji = 4000000 or gaji <= 7000000 THEN 'Gaji Sedang'
    -> ELSE 'Gaji Besar' END AS keterangan
    -> FROM pegawai;
+-------+---------------+----------+-------------+
| nip   | nama          | gaji     | keterangan  |
+-------+---------------+----------+-------------+
| 10021 | Uci           |  3351853 | Gaji Kecil  |
| 10022 | Uca           |  7576510 | Gaji Besar  |
| 10023 | Ucok          |  8826991 | Gaji Besar  |
| 10024 | Ujang         | 10405426 | Gaji Besar  |
| 10025 | Ucup          |  6546156 | Gaji Sedang |
| 20021 | Aqua          |  6514503 | Gaji Sedang |
| 20022 | Ruby          |  9934047 | Gaji Besar  |
| 20023 | Matthew       |  3126726 | Gaji Kecil  |
| 20024 | Kung Lao      |  6831488 | Gaji Sedang |
| 20025 | Viradaa       |  5777262 | Gaji Sedang |
| 30021 | Gyuryo        |  5391848 | Gaji Sedang |
| 30022 | Muzan         |  6627455 | Gaji Sedang |
| 30023 | Sandy         |  5961731 | Gaji Sedang |
| 30024 | Ma Ji Xiang   |  6926289 | Gaji Sedang |
| 30025 | Dita Anatasya |  5746255 | Gaji Sedang |
| 40021 | Putri Maulida |  4952405 | Gaji Sedang |
| 40022 | Kibutsuji     |  4523262 | Gaji Sedang |
| 40023 | Syifa Azhima  |  4759096 | Gaji Sedang |
+-------+---------------+----------+-------------+
18 rows in set (0.003 sec)

-- - tampilkan data jumlah pegawai berdasarkan gender(gunakan group by)

MariaDB [dbpegawai]> SELECT gender, COUNT(*) as Jumlah
    -> FROM pegawai
    -> GROUP BY gender;
+--------+--------+
| gender | Jumlah |
+--------+--------+
| L      |      8 |
| P      |     10 |
+--------+--------+
2 rows in set (0.000 sec)

-- - tampilkan data jumlah pegawai berdasarkan gender, yg jumlah minimal 10 orang (gunakan group by dan having)

MariaDB [dbpegawai]> SELECT gender, COUNT(gender) as Jumlah
    -> FROM pegawai
    -> GROUP BY gender
    -> HAVING COUNT(gender) >= 10;
+--------+--------+
| gender | Jumlah |
+--------+--------+
| P      |     10 |
+--------+--------+
1 row in set (0.003 sec)


--Created by M. Afkar Siddiq