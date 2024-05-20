# MariaDB SQL cheat sheet

INNER join

I am writing an SQL script to update a table in MariaDB. I have 2 tables. A products table, and an products file table. There is a one to many relationship between a product and a product file. Currently, most products have a pdf file "xyz.pdf". I would like to have all products to have that file "xyz.pdf". No product should have duplicates of that file.

```SQL
INSERT INTO products_files_copy1 ( products_id, file, file_title, sort_order ) ( SELECT products_id, "87646%20Brixon%20Product%20Info%20Package.pdf", "Product Info", 1 FROM `products` )
ON DUPLICATE KEY UPDATE file = "87646%20Brixon%20Product%20Info%20Package.pdf";
```
