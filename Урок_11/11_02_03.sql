
-- 3. Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.


kartseves@ubuntu:~$ mongo
MongoDB shell version v3.6.8
connecting to: mongodb://127.0.0.1:27017
Implicit session: session { "id" : UUID("8090e3da-4473-4bf3-bfe6-2dbad9189edf") }
MongoDB server version: 3.6.8
Server has startup warnings: 
2021-01-02T23:16:52.909-0800 I STORAGE  [initandlisten] 
2021-01-02T23:16:52.909-0800 I STORAGE  [initandlisten] ** WARNING: Using the XFS filesystem is strongly recommended with the WiredTiger storage engine
2021-01-02T23:16:52.909-0800 I STORAGE  [initandlisten] **          See http://dochub.mongodb.org/core/prodnotes-filesystem
2021-01-02T23:16:54.484-0800 I CONTROL  [initandlisten] 
2021-01-02T23:16:54.484-0800 I CONTROL  [initandlisten] ** WARNING: Access control is not enabled for the database.
2021-01-02T23:16:54.484-0800 I CONTROL  [initandlisten] **          Read and write access to data and configuration is unrestricted.
2021-01-02T23:16:54.484-0800 I CONTROL  [initandlisten] 
>
> use shop
switched to db shop
>
> db.createCollection('catalogs')
{ "ok" : 1 }
> db.catalogs.insert({name: 'Процессоры'})
WriteResult({ "nInserted" : 1 })
> db.catalogs.insert({name: 'Материнские платы'})
WriteResult({ "nInserted" : 1 })
> db.catalogs.insert({name: 'Видеокарты'})
WriteResult({ "nInserted" : 1 })
>
> db.catalogs.find()
{ "_id" : ObjectId("5ff1709d4f11b7b9bcd51268"), "name" : "Процессоры" }
{ "_id" : ObjectId("5ff170b34f11b7b9bcd51269"), "name" : "Материнские платы" }
{ "_id" : ObjectId("5ff170de4f11b7b9bcd5126a"), "name" : "Видеокарты" }
>
> db.createCollection('products')
{ "ok" : 1 }
> db.products.insert(
... {
... name: 'Intel Core i3-8100',
... description: 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.',
... price: 7890.00,
... catalog_id: new ObjectId("5ff1709d4f11b7b9bcd51268")
... }
... );
WriteResult({ "nInserted" : 1 })
> db.products.insert(
... {
... name: 'Gigabyte H310M S2H',
... description: 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX',
... price: 4790.00,
... catalog_id: new ObjectId("5ff170b34f11b7b9bcd51269")
... }
... );
WriteResult({ "nInserted" : 1 })
>
> db.products.find()
{ "_id" : ObjectId("5ff171e74f11b7b9bcd5126b"), "name" : "Intel Core i3-8100", "description" : "Процессор для настольных персональных компьютеров, основанных на платформе Intel.", "price" : 7890, "catalog_id" : ObjectId("5fdbd3cf9d4bc8003a351e4b") }
{ "_id" : ObjectId("5ff173b64f11b7b9bcd5126c"), "name" : "Gigabyte H310M S2H", "description" : "Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX", "price" : 4790, "catalog_id" : ObjectId("5ff170b34f11b7b9bcd51269") }
> 
