-- ------------------------------------------------------------------
-- 花漾时光 · 可选演示数据（用户 / 地址 / 订单 / 订单明细）
-- 作用：让管理端「数据统计」与「工作台」有真实曲线可看（营业额、订单、销量 Top10、新增用户）
-- 导入：mysql -uroot -p123456 --default-character-set=utf8mb4 < demo_orders_optional.sql
-- ------------------------------------------------------------------
USE `huayang_flower`;

DELETE FROM `order_detail`;
DELETE FROM `orders`;
DELETE FROM `address_book`;
DELETE FROM `user`;

INSERT INTO `user` (id,openid,name,phone,sex,id_number,create_time) VALUES (1,'oHuaYang_Demo_0001','林小满','13800138001','1','420106199203081234','2026-09-18 10:12:00');
INSERT INTO `user` (id,openid,name,phone,sex,id_number,create_time) VALUES (2,'oHuaYang_Demo_0002','周予安','13800138002','1','420106199507151234','2026-09-19 14:03:00');
INSERT INTO `user` (id,openid,name,phone,sex,id_number,create_time) VALUES (3,'oHuaYang_Demo_0003','苏晚晴','13800138003','0','420106199811203456','2026-09-20 09:41:00');
INSERT INTO `user` (id,openid,name,phone,sex,id_number,create_time) VALUES (4,'oHuaYang_Demo_0004','顾之南','13800138004','1','420106199401016789','2026-09-21 16:22:00');
INSERT INTO `user` (id,openid,name,phone,sex,id_number,create_time) VALUES (5,'oHuaYang_Demo_0005','许清和','13800138005','0','420106199612253456','2026-09-22 11:08:00');
INSERT INTO `user` (id,openid,name,phone,sex,id_number,create_time) VALUES (6,'oHuaYang_Demo_0006','郑一诺','13800138006','1','420106199905304567','2026-09-23 19:37:00');

INSERT INTO `address_book` (id,user_id,consignee,sex,phone,province_name,city_name,district_name,detail,label,is_default) VALUES (1,1,'林小满','1','13800138001','湖北省','武汉市','江汉区','花楼街88号 江汉人家 3栋 1201','家',1);
INSERT INTO `address_book` (id,user_id,consignee,sex,phone,province_name,city_name,district_name,detail,label,is_default) VALUES (2,1,'林小满','1','13800138001','湖北省','武汉市','武昌区','中南路12号 保利广场 A座 2202','家',1);
INSERT INTO `address_book` (id,user_id,consignee,sex,phone,province_name,city_name,district_name,detail,label,is_default) VALUES (3,2,'周予安','1','13800138002','湖北省','武汉市','洪山区','光谷步行街5号 万科城市花园 8-1-802','家',1);
INSERT INTO `address_book` (id,user_id,consignee,sex,phone,province_name,city_name,district_name,detail,label,is_default) VALUES (4,3,'苏晚晴','0','13800138003','湖北省','武汉市','江岸区','汉口江滩6号 融科天城 2栋 1601','家',1);
INSERT INTO `address_book` (id,user_id,consignee,sex,phone,province_name,city_name,district_name,detail,label,is_default) VALUES (5,4,'顾之南','1','13800138004','湖北省','武汉市','汉阳区','王家湾21号 龙阳时代 5栋 903','家',1);
INSERT INTO `address_book` (id,user_id,consignee,sex,phone,province_name,city_name,district_name,detail,label,is_default) VALUES (6,6,'郑一诺','1','13800138006','湖北省','武汉市','江汉区','青年路308号 泛海国际 SOHO城 1栋 3308','家',1);

INSERT INTO `orders` VALUES (1,'20260924100137',5,1,1,'2026-09-18 11:20:00','2026-09-18 11:22:00',1,1,144.00,'生日惊喜，请帮忙系粉色丝带','13800138001','湖北省武汉市江汉区花楼街88号 江汉人家 3栋 1201','林小满','林小满',NULL,NULL,NULL,'2026-09-18 12:20:00',1,'2026-09-18 12:20:00',12,24,1);
INSERT INTO `orders` VALUES (2,'20260924100274',5,2,3,'2026-09-18 15:47:00','2026-09-18 15:49:00',1,1,420.90,'','13800138002','湖北省武汉市洪山区光谷步行街5号 万科城市花园 8-1-802','周予安','周予安',NULL,NULL,NULL,'2026-09-18 16:47:00',1,'2026-09-18 16:47:00',2,4,1);
INSERT INTO `orders` VALUES (3,'20260924100411',5,3,4,'2026-09-19 10:35:00','2026-09-19 10:37:00',1,1,219.00,'母亲节补送，手写贺卡：妈妈辛苦了','13800138003','湖北省武汉市江岸区汉口江滩6号 融科天城 2栋 1601','苏晚晴','苏晚晴',NULL,NULL,NULL,'2026-09-19 11:35:00',1,'2026-09-19 11:35:00',1,2,1);
INSERT INTO `orders` VALUES (4,'20260924100548',5,1,1,'2026-09-19 18:02:00','2026-09-19 18:04:00',1,1,300.00,'','13800138001','湖北省武汉市江汉区花楼街88号 江汉人家 3栋 1201','林小满','林小满',NULL,NULL,NULL,'2026-09-19 19:02:00',1,'2026-09-19 19:02:00',1,2,1);
INSERT INTO `orders` VALUES (5,'20260924100685',5,4,5,'2026-09-20 09:15:00','2026-09-20 09:17:00',1,1,689.00,'公司开业，8:30 前送到','13800138004','湖北省武汉市汉阳区王家湾21号 龙阳时代 5栋 903','顾之南','顾之南',NULL,NULL,NULL,'2026-09-20 10:15:00',1,'2026-09-20 10:15:00',1,2,1);
INSERT INTO `orders` VALUES (6,'20260924100822',5,5,6,'2026-09-20 20:11:00','2026-09-20 20:13:00',1,1,269.00,'','13800138005','湖北省武汉市江汉区青年路308号 泛海国际 SOHO城 1栋 3308','许清和','郑一诺',NULL,NULL,NULL,'2026-09-20 21:11:00',1,'2026-09-20 21:11:00',4,8,1);
INSERT INTO `orders` VALUES (7,'20260924100959',5,2,3,'2026-09-21 13:26:00','2026-09-21 13:28:00',1,1,469.00,'中秋送礼，需要礼袋','13800138002','湖北省武汉市洪山区光谷步行街5号 万科城市花园 8-1-802','周予安','周予安',NULL,NULL,NULL,'2026-09-21 14:26:00',1,'2026-09-21 14:26:00',1,2,1);
INSERT INTO `orders` VALUES (8,'20260924101096',5,6,6,'2026-09-21 19:58:00','2026-09-21 20:00:00',1,1,1100.00,'求婚用，务必新鲜','13800138006','湖北省武汉市江汉区青年路308号 泛海国际 SOHO城 1栋 3308','郑一诺','郑一诺',NULL,NULL,NULL,'2026-09-21 20:58:00',1,'2026-09-21 20:58:00',1,2,1);
INSERT INTO `orders` VALUES (9,'20260924101233',5,1,2,'2026-09-22 10:44:00','2026-09-22 10:46:00',1,1,297.00,'','13800138001','湖北省武汉市武昌区中南路12号 保利广场 A座 2202','林小满','林小满',NULL,NULL,NULL,'2026-09-22 11:44:00',1,'2026-09-22 11:44:00',3,6,1);
INSERT INTO `orders` VALUES (10,'20260924101370',5,3,4,'2026-09-22 16:30:00','2026-09-22 16:32:00',1,1,359.00,'探望病人，不要浓香的花','13800138003','湖北省武汉市江岸区汉口江滩6号 融科天城 2栋 1601','苏晚晴','苏晚晴',NULL,NULL,NULL,'2026-09-22 17:30:00',1,'2026-09-22 17:30:00',1,2,1);
INSERT INTO `orders` VALUES (11,'20260924101507',5,5,6,'2026-09-23 11:12:00','2026-09-23 11:14:00',1,1,559.00,'教师节班委一起送的','13800138005','湖北省武汉市江汉区青年路308号 泛海国际 SOHO城 1栋 3308','许清和','郑一诺',NULL,NULL,NULL,'2026-09-23 12:12:00',1,'2026-09-23 12:12:00',13,26,1);
INSERT INTO `orders` VALUES (12,'20260924101644',4,2,3,'2026-09-23 20:05:00','2026-09-23 20:07:00',1,1,800.00,'情人节提前预定，当天配送','13800138002','湖北省武汉市洪山区光谷步行街5号 万科城市花园 8-1-802','周予安','周予安',NULL,NULL,NULL,'2026-09-23 21:05:00',1,NULL,1,2,1);
INSERT INTO `orders` VALUES (13,'20260924101781',5,4,5,'2026-09-24 09:30:00','2026-09-24 09:32:00',1,1,400.00,'','13800138004','湖北省武汉市汉阳区王家湾21号 龙阳时代 5栋 903','顾之南','顾之南',NULL,NULL,NULL,'2026-09-24 10:30:00',1,'2026-09-24 10:30:00',1,2,1);
INSERT INTO `orders` VALUES (14,'20260924101918',2,6,6,'2026-09-24 10:05:00',NULL,1,0,400.00,'尽快送达','13800138006','湖北省武汉市江汉区青年路308号 泛海国际 SOHO城 1栋 3308','郑一诺','郑一诺',NULL,NULL,NULL,'2026-09-24 11:05:00',1,NULL,2,4,1);

INSERT INTO `order_detail` VALUES (1,'红玫瑰','http://localhost:8081/imgs/flowers/rose-red.png',1,46,NULL,'包装:雾面纸礼装',9,108.00);
INSERT INTO `order_detail` VALUES (2,'尤加利叶','http://localhost:8081/imgs/flowers/eucalyptus.png',1,61,NULL,'包装:雾面纸礼装',3,24.00);
INSERT INTO `order_detail` VALUES (3,'33朵经典红玫瑰','http://localhost:8081/imgs/flowers/bouquet-33-red.png',2,NULL,3,NULL,1,399.00);
INSERT INTO `order_detail` VALUES (4,'新鲜草莓盒','http://localhost:8081/imgs/flowers/strawberry-box.png',2,69,NULL,'包装:雾面纸礼装',1,19.90);
INSERT INTO `order_detail` VALUES (5,'感恩母爱康乃馨花束','http://localhost:8081/imgs/flowers/bouquet-carnation-mom.png',3,NULL,19,NULL,1,218.00);
INSERT INTO `order_detail` VALUES (6,'挚爱红玫瑰礼盒','http://localhost:8081/imgs/flowers/bouquet-box-love.png',4,NULL,7,NULL,1,299.00);
INSERT INTO `order_detail` VALUES (7,'开业大吉双层花篮','http://localhost:8081/imgs/flowers/basket-opening-double.png',5,NULL,11,NULL,1,688.00);
INSERT INTO `order_detail` VALUES (8,'向阳而生向日葵花束','http://localhost:8081/imgs/flowers/bouquet-sunflower.png',6,NULL,17,NULL,1,199.00);
INSERT INTO `order_detail` VALUES (9,'大朵向日葵','http://localhost:8081/imgs/flowers/sunflower-big.png',6,51,NULL,'包装:雾面纸礼装',3,66.00);
INSERT INTO `order_detail` VALUES (10,'中秋团圆花篮','http://localhost:8081/imgs/flowers/basket-midautumn.png',7,NULL,13,NULL,1,468.00);
INSERT INTO `order_detail` VALUES (11,'99朵经典红玫瑰花束','http://localhost:8081/imgs/flowers/bouquet-99-red.png',8,NULL,5,NULL,1,1099.00);
INSERT INTO `order_detail` VALUES (12,'车厘子满天星花束','http://localhost:8081/imgs/flowers/bouquet-cherry-gypsophila.png',9,NULL,2,NULL,1,258.00);
INSERT INTO `order_detail` VALUES (13,'白百合','http://localhost:8081/imgs/flowers/lily-white.png',9,56,NULL,'包装:雾面纸礼装',2,36.00);
INSERT INTO `order_detail` VALUES (14,'优雅花篮','http://localhost:8081/imgs/flowers/basket-elegant.png',10,NULL,9,NULL,1,358.00);
INSERT INTO `order_detail` VALUES (15,'感恩母爱康乃馨花束','http://localhost:8081/imgs/flowers/bouquet-carnation-mom.png',11,NULL,19,NULL,2,436.00);
INSERT INTO `order_detail` VALUES (16,'粉色康乃馨','http://localhost:8081/imgs/flowers/carnation-pink.png',11,53,NULL,'包装:雾面纸礼装',11,110.00);
INSERT INTO `order_detail` VALUES (17,'情人节限定·永恒之约','http://localhost:8081/imgs/flowers/bouquet-valentine-52.png',12,NULL,15,NULL,1,799.00);
INSERT INTO `order_detail` VALUES (18,'33朵经典红玫瑰','http://localhost:8081/imgs/flowers/bouquet-33-red.png',13,NULL,3,NULL,1,399.00);
INSERT INTO `order_detail` VALUES (19,'向阳而生向日葵花束','http://localhost:8081/imgs/flowers/bouquet-sunflower.png',14,NULL,17,NULL,2,398.00);
