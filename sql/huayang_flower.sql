-- ------------------------------------------------------------------
-- 花漾时光 · 鲜花商城（flower take-out）
-- 数据库：huayang_flower   字符集：utf8mb3 / utf8_bin
-- 说明：表结构与「鲜花／花束」业务一一对应
--       dish        = 单品鲜花（单支花材、配草、绿植、配果）
--       dish_flavor = 鲜花的规格选项（包装 / 附赠 / 贺卡）
--       setmeal     = 花束、花礼（盒子款、花篮款、节日花礼等）
--       setmeal_dish= 花束配方（一束花由哪些单支鲜花拼成、各多少枝）
-- 导入：mysql -uroot -p < huayang_flower.sql
-- ------------------------------------------------------------------
CREATE DATABASE  IF NOT EXISTS `huayang_flower` ;
USE `huayang_flower`;

DROP TABLE IF EXISTS `address_book`;
CREATE TABLE `address_book` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `consignee` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '收货人',
  `sex` varchar(2) COLLATE utf8_bin DEFAULT NULL COMMENT '性别',
  `phone` varchar(11) COLLATE utf8_bin NOT NULL COMMENT '手机号',
  `province_code` varchar(12) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '省级区划编号',
  `province_name` varchar(32) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '省级名称',
  `city_code` varchar(12) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '市级区划编号',
  `city_name` varchar(32) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '市级名称',
  `district_code` varchar(12) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '区级区划编号',
  `district_name` varchar(32) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '区级名称',
  `detail` varchar(200) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '详细地址',
  `label` varchar(100) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '标签',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '默认 0 否 1是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='地址簿';

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` int DEFAULT NULL COMMENT '类型   1 鲜花分类 2 花束分类',
  `name` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '分类名称',
  `sort` int NOT NULL DEFAULT '0' COMMENT '顺序',
  `status` int DEFAULT NULL COMMENT '分类状态 0:禁用，1:启用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint DEFAULT NULL COMMENT '创建人',
  `update_user` bigint DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_category_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='鲜花及花束分类';

INSERT INTO `category` VALUES (11,1,'单支玫瑰',20,1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `category` VALUES (12,1,'单支向日葵',19,1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `category` VALUES (13,1,'单支康乃馨',18,1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `category` VALUES (14,1,'单支百合',17,1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `category` VALUES (15,1,'单支郁金香',16,1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `category` VALUES (16,1,'配花配草',15,1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `category` VALUES (17,1,'永生花与绿植',14,1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `category` VALUES (18,1,'配果配材',13,1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `category` VALUES (21,2,'水果花束',12,1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `category` VALUES (22,2,'33朵经典',11,1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `category` VALUES (23,2,'99朵经典',10,1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `category` VALUES (24,2,'盒子款',9,1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `category` VALUES (25,2,'花篮款',8,1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `category` VALUES (26,2,'开业花礼',7,1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `category` VALUES (27,2,'中秋花礼',6,1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `category` VALUES (28,2,'情人节限定',5,1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `category` VALUES (29,2,'向日葵花束',4,1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `category` VALUES (30,2,'康乃馨花束',3,1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);

DROP TABLE IF EXISTS `dish`;
CREATE TABLE `dish` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '鲜花名称',
  `category_id` bigint NOT NULL COMMENT '鲜花分类id',
  `price` decimal(10,2) DEFAULT NULL COMMENT '鲜花价格',
  `image` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '图片',
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '描述信息',
  `status` int DEFAULT '1' COMMENT '0 停售 1 起售',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint DEFAULT NULL COMMENT '创建人',
  `update_user` bigint DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_dish_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='鲜花';

INSERT INTO `dish` VALUES (46,'红玫瑰',11,12.00,'http://localhost:8081/imgs/flowers/rose-red.png','花语：热烈的爱。昆明直发A级红玫瑰，枝长50cm，当日鲜切',1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `dish` VALUES (47,'香槟玫瑰',11,15.00,'http://localhost:8081/imgs/flowers/rose-champagne.png','花语：我只钟情你一个。柔和香槟色，表白与纪念日首选',1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `dish` VALUES (48,'白玫瑰',11,12.00,'http://localhost:8081/imgs/flowers/rose-white.png','花语：纯洁与尊敬。花型饱满，适合婚礼与答谢',1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `dish` VALUES (49,'戴安娜粉玫瑰',11,15.00,'http://localhost:8081/imgs/flowers/rose-diana.png','花语：优雅与感激。浅粉花瓣层层绽放，少女感十足',1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `dish` VALUES (50,'碎冰蓝玫瑰',11,18.00,'http://localhost:8081/imgs/flowers/rose-iceblue.png','花语：神秘与浪漫。食用级染色工艺，蓝白渐层',1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `dish` VALUES (51,'大朵向日葵',12,22.00,'http://localhost:8081/imgs/flowers/sunflower-big.png','花语：沉默的爱与忠诚。花盘直径12cm以上，当日新鲜采摘',1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `dish` VALUES (52,'迷你向日葵',12,16.00,'http://localhost:8081/imgs/flowers/sunflower-mini.png','花语：阳光与希望。小朵向日葵，花束搭配更灵动',1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `dish` VALUES (53,'粉色康乃馨',13,10.00,'http://localhost:8081/imgs/flowers/carnation-pink.png','花语：感恩与母爱。母亲节、教师节热门花材',1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `dish` VALUES (54,'红色康乃馨',13,10.00,'http://localhost:8081/imgs/flowers/carnation-red.png','花语：热情与思念。花瓣厚实，花期可长达半个月',1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `dish` VALUES (55,'白色康乃馨',13,12.00,'http://localhost:8081/imgs/flowers/carnation-white.png','花语：纯洁的爱。适合搭配百合与满天星',1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `dish` VALUES (56,'白百合',14,18.00,'http://localhost:8081/imgs/flowers/lily-white.png','花语：百年好合。香气清雅，2-3头/枝',1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `dish` VALUES (57,'粉色百合',14,20.00,'http://localhost:8081/imgs/flowers/lily-pink.png','花语：高雅与祝福。粉白渐层，适合探望与答谢',1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `dish` VALUES (58,'红色郁金香',15,15.00,'http://localhost:8081/imgs/flowers/tulip-red.png','花语：热烈的爱意。荷兰进口种球，空运直达',1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `dish` VALUES (59,'粉色郁金香',15,15.00,'http://localhost:8081/imgs/flowers/tulip-pink.png','花语：幸福与爱惜。杯型花苞，优雅耐看',1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `dish` VALUES (60,'白色郁金香',15,16.00,'http://localhost:8081/imgs/flowers/tulip-white.png','花语：纯洁的告白。极简风花束的经典花材',1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `dish` VALUES (61,'尤加利叶',16,8.00,'http://localhost:8081/imgs/flowers/eucalyptus.png','花语：回忆与陪伴。圆叶尤加利，自然系花束的灵魂配草',1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `dish` VALUES (62,'满天星',16,12.00,'http://localhost:8081/imgs/flowers/gypsophila.png','花语：真心与思念。白色小碎花，蓬松耐放',1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `dish` VALUES (63,'银叶菊',16,8.00,'http://localhost:8081/imgs/flowers/dusty-miller.png','花语：温暖与守护。银白色叶片，提升花束质感',1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `dish` VALUES (64,'进口绣球',16,45.00,'http://localhost:8081/imgs/flowers/hydrangea.png','花语：希望与团圆。进口大花球，直径约20cm',1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `dish` VALUES (65,'永生玫瑰玻璃罩',17,128.00,'http://localhost:8081/imgs/flowers/preserved-rose-glass.png','厄瓜多尔永生玫瑰，玻璃罩＋暖光灯串，可存放3年以上',1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `dish` VALUES (66,'永生花车挂',17,88.00,'http://localhost:8081/imgs/flowers/preserved-car-pendant.png','永生满天星＋玫瑰车挂，车内点缀，香味持久',1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `dish` VALUES (67,'多肉组合盆栽',17,45.00,'http://localhost:8081/imgs/flowers/succulent-pot.png','5款多肉组合，陶瓷盆＋椰土，办公桌好养绿植',1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `dish` VALUES (68,'小雏菊盆栽',17,38.00,'http://localhost:8081/imgs/flowers/daisy-pot.png','进口小雏菊盆栽，花期长达2个月',1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `dish` VALUES (69,'新鲜草莓盒',18,19.90,'http://localhost:8081/imgs/flowers/strawberry-box.png','当日采摘新鲜草莓，可搭配花束食用或组成果篮',1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `dish` VALUES (70,'车厘子礼盒',18,39.90,'http://localhost:8081/imgs/flowers/cherry-box.png','3J智利车厘子礼盒，水果花束常用搭配',1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `dish` VALUES (71,'费列罗巧克力',18,29.90,'http://localhost:8081/imgs/flowers/ferrero.png','费列罗榛果巧克力3粒装，花礼甜点搭配',1,'2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);

DROP TABLE IF EXISTS `dish_flavor`;
CREATE TABLE `dish_flavor` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dish_id` bigint NOT NULL COMMENT '鲜花',
  `name` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '规格名称',
  `value` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '规格数据list',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='鲜花规格关系表';

INSERT INTO `dish_flavor` VALUES (1,46,'包装','[\"无包装\",\"牛皮纸简装\",\"雾面纸礼装\",\"礼盒装\"]');
INSERT INTO `dish_flavor` VALUES (2,46,'附赠','[\"保鲜剂\",\"小花瓶\",\"不需要\"]');
INSERT INTO `dish_flavor` VALUES (3,46,'贺卡','[\"需要贺卡\",\"不需要贺卡\"]');
INSERT INTO `dish_flavor` VALUES (4,47,'包装','[\"无包装\",\"牛皮纸简装\",\"雾面纸礼装\",\"礼盒装\"]');
INSERT INTO `dish_flavor` VALUES (5,47,'附赠','[\"保鲜剂\",\"小花瓶\",\"不需要\"]');
INSERT INTO `dish_flavor` VALUES (6,47,'贺卡','[\"需要贺卡\",\"不需要贺卡\"]');
INSERT INTO `dish_flavor` VALUES (7,48,'包装','[\"无包装\",\"牛皮纸简装\",\"雾面纸礼装\",\"礼盒装\"]');
INSERT INTO `dish_flavor` VALUES (8,48,'附赠','[\"保鲜剂\",\"小花瓶\",\"不需要\"]');
INSERT INTO `dish_flavor` VALUES (9,48,'贺卡','[\"需要贺卡\",\"不需要贺卡\"]');
INSERT INTO `dish_flavor` VALUES (10,49,'包装','[\"无包装\",\"牛皮纸简装\",\"雾面纸礼装\",\"礼盒装\"]');
INSERT INTO `dish_flavor` VALUES (11,49,'附赠','[\"保鲜剂\",\"小花瓶\",\"不需要\"]');
INSERT INTO `dish_flavor` VALUES (12,49,'贺卡','[\"需要贺卡\",\"不需要贺卡\"]');
INSERT INTO `dish_flavor` VALUES (13,50,'包装','[\"无包装\",\"牛皮纸简装\",\"雾面纸礼装\",\"礼盒装\"]');
INSERT INTO `dish_flavor` VALUES (14,50,'附赠','[\"保鲜剂\",\"小花瓶\",\"不需要\"]');
INSERT INTO `dish_flavor` VALUES (15,50,'贺卡','[\"需要贺卡\",\"不需要贺卡\"]');
INSERT INTO `dish_flavor` VALUES (16,51,'包装','[\"无包装\",\"牛皮纸简装\",\"雾面纸礼装\",\"礼盒装\"]');
INSERT INTO `dish_flavor` VALUES (17,52,'包装','[\"无包装\",\"牛皮纸简装\",\"雾面纸礼装\",\"礼盒装\"]');
INSERT INTO `dish_flavor` VALUES (18,53,'包装','[\"无包装\",\"牛皮纸简装\",\"雾面纸礼装\",\"礼盒装\"]');
INSERT INTO `dish_flavor` VALUES (19,53,'贺卡','[\"需要贺卡（免费手写）\",\"不需要贺卡\"]');
INSERT INTO `dish_flavor` VALUES (20,54,'包装','[\"无包装\",\"牛皮纸简装\",\"雾面纸礼装\",\"礼盒装\"]');
INSERT INTO `dish_flavor` VALUES (21,54,'贺卡','[\"需要贺卡（免费手写）\",\"不需要贺卡\"]');
INSERT INTO `dish_flavor` VALUES (22,55,'包装','[\"无包装\",\"牛皮纸简装\",\"雾面纸礼装\",\"礼盒装\"]');
INSERT INTO `dish_flavor` VALUES (23,55,'贺卡','[\"需要贺卡（免费手写）\",\"不需要贺卡\"]');
INSERT INTO `dish_flavor` VALUES (24,56,'包装','[\"无包装\",\"牛皮纸简装\",\"雾面纸礼装\",\"礼盒装\"]');
INSERT INTO `dish_flavor` VALUES (25,57,'包装','[\"无包装\",\"牛皮纸简装\",\"雾面纸礼装\",\"礼盒装\"]');
INSERT INTO `dish_flavor` VALUES (26,58,'包装','[\"无包装\",\"牛皮纸简装\",\"雾面纸礼装\",\"礼盒装\"]');
INSERT INTO `dish_flavor` VALUES (27,59,'包装','[\"无包装\",\"牛皮纸简装\",\"雾面纸礼装\",\"礼盒装\"]');
INSERT INTO `dish_flavor` VALUES (28,60,'包装','[\"无包装\",\"牛皮纸简装\",\"雾面纸礼装\",\"礼盒装\"]');
INSERT INTO `dish_flavor` VALUES (29,69,'包装','[\"无包装\",\"牛皮纸简装\",\"雾面纸礼装\",\"礼盒装\"]');
INSERT INTO `dish_flavor` VALUES (30,70,'包装','[\"无包装\",\"牛皮纸简装\",\"雾面纸礼装\",\"礼盒装\"]');
INSERT INTO `dish_flavor` VALUES (31,71,'包装','[\"无包装\",\"牛皮纸简装\",\"雾面纸礼装\",\"礼盒装\"]');

DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `username` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '用户名',
  `password` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '密码',
  `phone` varchar(11) COLLATE utf8_bin NOT NULL COMMENT '手机号',
  `sex` varchar(2) COLLATE utf8_bin NOT NULL COMMENT '性别',
  `id_number` varchar(18) COLLATE utf8_bin NOT NULL COMMENT '身份证号',
  `status` int NOT NULL DEFAULT '1' COMMENT '状态 0:禁用，1:启用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint DEFAULT NULL COMMENT '创建人',
  `update_user` bigint DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='员工信息';

INSERT INTO `employee` VALUES (1,'管理员','admin','e10adc3949ba59abbe56e057f20f883e','13812312312','1','110101199001010047',1,'2022-02-15 15:51:20','2022-02-17 09:16:20',10,1);
-- 说明：登录密码为 123456（存的是 MD5，与 EmployeeServiceImpl 的登录校验一致）

DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '名字',
  `image` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '图片',
  `order_id` bigint NOT NULL COMMENT '订单id',
  `dish_id` bigint DEFAULT NULL COMMENT '鲜花id',
  `setmeal_id` bigint DEFAULT NULL COMMENT '花束id',
  `dish_flavor` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '规格',
  `number` int NOT NULL DEFAULT '1' COMMENT '数量',
  `amount` decimal(10,2) NOT NULL COMMENT '金额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='订单明细表';

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `number` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '订单号',
  `status` int NOT NULL DEFAULT '1' COMMENT '订单状态 1待付款 2待接单 3已接单 4派送中 5已完成 6已取消 7退款',
  `user_id` bigint NOT NULL COMMENT '下单用户',
  `address_book_id` bigint NOT NULL COMMENT '地址id',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `checkout_time` datetime DEFAULT NULL COMMENT '结账时间',
  `pay_method` int NOT NULL DEFAULT '1' COMMENT '支付方式 1微信,2支付宝',
  `pay_status` tinyint NOT NULL DEFAULT '0' COMMENT '支付状态 0未支付 1已支付 2退款',
  `amount` decimal(10,2) NOT NULL COMMENT '实收金额',
  `remark` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `phone` varchar(11) COLLATE utf8_bin DEFAULT NULL COMMENT '手机号',
  `address` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '地址',
  `user_name` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '用户名称',
  `consignee` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '收货人',
  `cancel_reason` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '订单取消原因',
  `rejection_reason` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '订单拒绝原因',
  `cancel_time` datetime DEFAULT NULL COMMENT '订单取消时间',
  `estimated_delivery_time` datetime DEFAULT NULL COMMENT '预计送达时间',
  `delivery_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '配送状态  1立即送出  0选择具体时间',
  `delivery_time` datetime DEFAULT NULL COMMENT '送达时间',
  `pack_amount` int DEFAULT NULL COMMENT '打包费',
  `tableware_number` int DEFAULT NULL COMMENT '餐具数量',
  `tableware_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '餐具数量状态  1按餐量提供  0选择具体数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='订单表';

DROP TABLE IF EXISTS `setmeal`;
CREATE TABLE `setmeal` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `category_id` bigint NOT NULL COMMENT '鲜花分类id',
  `name` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '花束名称',
  `price` decimal(10,2) NOT NULL COMMENT '花束价格',
  `status` int DEFAULT '1' COMMENT '售卖状态 0:停售 1:起售',
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '描述信息',
  `image` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '图片',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint DEFAULT NULL COMMENT '创建人',
  `update_user` bigint DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_setmeal_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='花束';

INSERT INTO `setmeal` VALUES (1,21,'草莓玫瑰花束',168.00,1,'红玫瑰11枝＋当日新鲜草莓，甜到心里的告白花束','http://localhost:8081/imgs/flowers/bouquet-strawberry-rose.png','2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `setmeal` VALUES (2,21,'车厘子满天星花束',258.00,1,'3J车厘子＋香槟玫瑰9枝＋满天星，果香与花香的组合','http://localhost:8081/imgs/flowers/bouquet-cherry-gypsophila.png','2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `setmeal` VALUES (3,22,'33朵经典红玫瑰',399.00,1,'33朵红玫瑰＋尤加利叶，经典告白款，送礼不出错','http://localhost:8081/imgs/flowers/bouquet-33-red.png','2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `setmeal` VALUES (4,22,'33朵经典香槟玫瑰',429.00,1,'33朵香槟玫瑰＋银叶菊，温柔高级感','http://localhost:8081/imgs/flowers/bouquet-33-champagne.png','2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `setmeal` VALUES (5,23,'99朵经典红玫瑰花束',1099.00,1,'99朵A级红玫瑰，求婚、纪念日首选大花束','http://localhost:8081/imgs/flowers/bouquet-99-red.png','2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `setmeal` VALUES (6,23,'99朵经典粉玫瑰花束',1188.00,1,'99朵戴安娜粉玫瑰＋满天星，浪漫公主风','http://localhost:8081/imgs/flowers/bouquet-99-pink.png','2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `setmeal` VALUES (7,24,'挚爱红玫瑰礼盒',299.00,1,'19朵红玫瑰＋费列罗巧克力，抱抱桶礼盒款','http://localhost:8081/imgs/flowers/bouquet-box-love.png','2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `setmeal` VALUES (8,24,'温柔粉语礼盒',269.00,1,'11朵粉玫瑰＋6朵白玫瑰，雾面纸礼盒款','http://localhost:8081/imgs/flowers/bouquet-box-pink.png','2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `setmeal` VALUES (9,25,'优雅花篮',358.00,1,'粉百合＋粉玫瑰＋尤加利叶，花篮款，到店自提或同城配送','http://localhost:8081/imgs/flowers/basket-elegant.png','2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `setmeal` VALUES (10,25,'阳光花篮',328.00,1,'向日葵＋满天星，明亮元气的花篮款','http://localhost:8081/imgs/flowers/basket-sunny.png','2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `setmeal` VALUES (11,26,'开业大吉双层花篮',688.00,1,'向日葵9枝＋红玫瑰11枝，开业庆典双层花篮，含条幅','http://localhost:8081/imgs/flowers/basket-opening-double.png','2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `setmeal` VALUES (12,26,'生意兴隆鲜花篮',588.00,1,'粉百合＋白玫瑰＋银叶菊，商务开业花礼','http://localhost:8081/imgs/flowers/basket-opening-biz.png','2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `setmeal` VALUES (13,27,'中秋团圆花篮',468.00,1,'粉百合＋粉玫瑰＋满天星，中秋团圆主题花篮','http://localhost:8081/imgs/flowers/basket-midautumn.png','2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `setmeal` VALUES (14,27,'月满中秋鲜花礼盒',398.00,1,'香槟玫瑰＋银叶菊，中秋送礼礼盒款，附赠中秋贺卡','http://localhost:8081/imgs/flowers/box-midautumn.png','2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `setmeal` VALUES (15,28,'情人节限定·永恒之约',799.00,1,'52朵红玫瑰＋满天星，情人节限定款','http://localhost:8081/imgs/flowers/bouquet-valentine-52.png','2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `setmeal` VALUES (16,28,'情人节限定·初恋告白',529.00,1,'33朵戴安娜粉玫瑰＋尤加利叶，情人节限定款','http://localhost:8081/imgs/flowers/bouquet-valentine-pink.png','2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `setmeal` VALUES (17,29,'向阳而生向日葵花束',199.00,1,'6枝大朵向日葵＋尤加利叶，元气满满的祝福','http://localhost:8081/imgs/flowers/bouquet-sunflower.png','2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `setmeal` VALUES (18,29,'迷你向日葵元气花束',139.00,1,'8枝迷你向日葵＋满天星，小巧可爱','http://localhost:8081/imgs/flowers/bouquet-sunflower-mini.png','2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `setmeal` VALUES (19,30,'感恩母爱康乃馨花束',218.00,1,'11枝粉康乃馨＋6枝红康乃馨＋尤加利叶，母亲节首选','http://localhost:8081/imgs/flowers/bouquet-carnation-mom.png','2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);
INSERT INTO `setmeal` VALUES (20,30,'温柔康乃馨混搭花束',168.00,1,'9枝粉康乃馨＋2枝白百合＋银叶菊，温柔的谢意','http://localhost:8081/imgs/flowers/bouquet-carnation-mix.png','2026-09-24 10:00:00','2026-09-24 10:00:00',1,1);

DROP TABLE IF EXISTS `setmeal_dish`;
CREATE TABLE `setmeal_dish` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `setmeal_id` bigint DEFAULT NULL COMMENT '花束id',
  `dish_id` bigint DEFAULT NULL COMMENT '鲜花id',
  `name` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '鲜花名称 （冗余字段）',
  `price` decimal(10,2) DEFAULT NULL COMMENT '鲜花单价（冗余字段）',
  `copies` int DEFAULT NULL COMMENT '鲜花份数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='花束鲜花关系';

INSERT INTO `setmeal_dish` VALUES (1,1,46,'红玫瑰',12.00,11);
INSERT INTO `setmeal_dish` VALUES (2,1,61,'尤加利叶',8.00,3);
INSERT INTO `setmeal_dish` VALUES (3,1,69,'新鲜草莓盒',19.90,1);
INSERT INTO `setmeal_dish` VALUES (4,2,47,'香槟玫瑰',15.00,9);
INSERT INTO `setmeal_dish` VALUES (5,2,62,'满天星',12.00,3);
INSERT INTO `setmeal_dish` VALUES (6,2,70,'车厘子礼盒',39.90,1);
INSERT INTO `setmeal_dish` VALUES (7,3,46,'红玫瑰',12.00,33);
INSERT INTO `setmeal_dish` VALUES (8,3,61,'尤加利叶',8.00,5);
INSERT INTO `setmeal_dish` VALUES (9,4,47,'香槟玫瑰',15.00,33);
INSERT INTO `setmeal_dish` VALUES (10,4,63,'银叶菊',8.00,5);
INSERT INTO `setmeal_dish` VALUES (11,5,46,'红玫瑰',12.00,99);
INSERT INTO `setmeal_dish` VALUES (12,5,61,'尤加利叶',8.00,10);
INSERT INTO `setmeal_dish` VALUES (13,6,49,'戴安娜粉玫瑰',15.00,99);
INSERT INTO `setmeal_dish` VALUES (14,6,62,'满天星',12.00,5);
INSERT INTO `setmeal_dish` VALUES (15,7,46,'红玫瑰',12.00,19);
INSERT INTO `setmeal_dish` VALUES (16,7,61,'尤加利叶',8.00,3);
INSERT INTO `setmeal_dish` VALUES (17,7,71,'费列罗巧克力',29.90,1);
INSERT INTO `setmeal_dish` VALUES (18,8,49,'戴安娜粉玫瑰',15.00,11);
INSERT INTO `setmeal_dish` VALUES (19,8,48,'白玫瑰',12.00,6);
INSERT INTO `setmeal_dish` VALUES (20,8,63,'银叶菊',8.00,3);
INSERT INTO `setmeal_dish` VALUES (21,9,57,'粉色百合',20.00,3);
INSERT INTO `setmeal_dish` VALUES (22,9,49,'戴安娜粉玫瑰',15.00,11);
INSERT INTO `setmeal_dish` VALUES (23,9,61,'尤加利叶',8.00,5);
INSERT INTO `setmeal_dish` VALUES (24,10,51,'大朵向日葵',22.00,5);
INSERT INTO `setmeal_dish` VALUES (25,10,62,'满天星',12.00,3);
INSERT INTO `setmeal_dish` VALUES (26,10,63,'银叶菊',8.00,4);
INSERT INTO `setmeal_dish` VALUES (27,11,51,'大朵向日葵',22.00,9);
INSERT INTO `setmeal_dish` VALUES (28,11,46,'红玫瑰',12.00,11);
INSERT INTO `setmeal_dish` VALUES (29,11,61,'尤加利叶',8.00,8);
INSERT INTO `setmeal_dish` VALUES (30,12,57,'粉色百合',20.00,5);
INSERT INTO `setmeal_dish` VALUES (31,12,48,'白玫瑰',12.00,11);
INSERT INTO `setmeal_dish` VALUES (32,12,63,'银叶菊',8.00,6);
INSERT INTO `setmeal_dish` VALUES (33,13,57,'粉色百合',20.00,3);
INSERT INTO `setmeal_dish` VALUES (34,13,49,'戴安娜粉玫瑰',15.00,9);
INSERT INTO `setmeal_dish` VALUES (35,13,62,'满天星',12.00,3);
INSERT INTO `setmeal_dish` VALUES (36,14,47,'香槟玫瑰',15.00,19);
INSERT INTO `setmeal_dish` VALUES (37,14,63,'银叶菊',8.00,5);
INSERT INTO `setmeal_dish` VALUES (38,15,46,'红玫瑰',12.00,52);
INSERT INTO `setmeal_dish` VALUES (39,15,62,'满天星',12.00,3);
INSERT INTO `setmeal_dish` VALUES (40,16,49,'戴安娜粉玫瑰',15.00,33);
INSERT INTO `setmeal_dish` VALUES (41,16,61,'尤加利叶',8.00,5);
INSERT INTO `setmeal_dish` VALUES (42,17,51,'大朵向日葵',22.00,6);
INSERT INTO `setmeal_dish` VALUES (43,17,61,'尤加利叶',8.00,5);
INSERT INTO `setmeal_dish` VALUES (44,18,52,'迷你向日葵',16.00,8);
INSERT INTO `setmeal_dish` VALUES (45,18,62,'满天星',12.00,2);
INSERT INTO `setmeal_dish` VALUES (46,19,53,'粉色康乃馨',10.00,11);
INSERT INTO `setmeal_dish` VALUES (47,19,54,'红色康乃馨',10.00,6);
INSERT INTO `setmeal_dish` VALUES (48,19,61,'尤加利叶',8.00,3);
INSERT INTO `setmeal_dish` VALUES (49,20,53,'粉色康乃馨',10.00,9);
INSERT INTO `setmeal_dish` VALUES (50,20,56,'白百合',18.00,2);
INSERT INTO `setmeal_dish` VALUES (51,20,63,'银叶菊',8.00,2);

DROP TABLE IF EXISTS `shopping_cart`;
CREATE TABLE `shopping_cart` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '商品名称',
  `image` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '图片',
  `user_id` bigint NOT NULL COMMENT '主键',
  `dish_id` bigint DEFAULT NULL COMMENT '鲜花id',
  `setmeal_id` bigint DEFAULT NULL COMMENT '花束id',
  `dish_flavor` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '规格',
  `number` int NOT NULL DEFAULT '1' COMMENT '数量',
  `amount` decimal(10,2) NOT NULL COMMENT '金额',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='购物车';

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `openid` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '微信用户唯一标识',
  `name` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '姓名',
  `phone` varchar(11) COLLATE utf8_bin DEFAULT NULL COMMENT '手机号',
  `sex` varchar(2) COLLATE utf8_bin DEFAULT NULL COMMENT '性别',
  `id_number` varchar(18) COLLATE utf8_bin DEFAULT NULL COMMENT '身份证号',
  `avatar` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '头像',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='用户信息';