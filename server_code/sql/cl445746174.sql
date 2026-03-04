-- MySQL dump 10.13  Distrib 5.7.44, for Linux (x86_64)
--
-- Host: localhost    Database: cl445746174
-- ------------------------------------------------------
-- Server version	5.7.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `cl445746174`
--

/*!40000 DROP DATABASE IF EXISTS `cl445746174`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `cl445746174` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `cl445746174`;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `address` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '地址',
  `name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收货人',
  `phone` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
  `isdefault` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '否' COMMENT '是否默认地址',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `longitude` double DEFAULT NULL COMMENT '经度',
  `latitude` double DEFAULT NULL COMMENT '纬度',
  `fulladdress` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='地址';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'2025-12-15 09:24:34','地址1','李一','19819881111','是',11,NULL,NULL,NULL),(2,'2025-12-15 09:24:34','地址2','王二','19819882222','是',12,NULL,NULL,NULL),(3,'2025-12-15 09:24:34','地址3','张三','19819883333','是',13,NULL,NULL,NULL),(4,'2025-12-15 09:24:34','地址4','刘四','19819884444','是',14,NULL,NULL,NULL),(5,'2025-12-15 09:24:34','地址5','陈五','19819885555','是',15,NULL,NULL,NULL),(6,'2025-12-15 09:24:34','地址6','杨六','19819886666','是',16,NULL,NULL,NULL),(7,'2025-12-15 09:24:34','地址7','赵七','19819887777','是',17,NULL,NULL,NULL),(8,'2025-12-15 09:24:34','地址8','黄八','19819888888','是',18,NULL,NULL,NULL),(9,'2025-12-15 09:24:34','地址9','周九','19819889999','是',19,NULL,NULL,NULL),(10,'2025-12-15 09:24:34','地址10','吴十','19819880000','是',20,NULL,NULL,NULL);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `tablename` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT 'dongmanshangpin' COMMENT '商品表名',
  `goodid` bigint(20) NOT NULL COMMENT '商品id',
  `goodname` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品名称',
  `picture` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '图片',
  `buynumber` int(11) DEFAULT NULL COMMENT '购买数量',
  `price` double DEFAULT NULL COMMENT '单价',
  `discountprice` double DEFAULT NULL COMMENT '折扣价',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `shangjiazhanghao` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商户名称',
  PRIMARY KEY (`id`),
  KEY `goodid` (`goodid`,`price`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`goodid`, `price`) REFERENCES `dongmanshangpin` (`id`, `price`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='购物车';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_friend`
--

DROP TABLE IF EXISTS `chat_friend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chat_friend` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `uid` bigint(20) NOT NULL COMMENT '用户id',
  `fid` bigint(20) NOT NULL COMMENT '好友id',
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `picture` longtext COLLATE utf8mb4_unicode_ci COMMENT '图片',
  `role` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色',
  `tablename` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '表名',
  `alias` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '别名',
  `type` int(11) DEFAULT '0' COMMENT '类型(0:好友申请，1:好友，2:消息)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='好友表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_friend`
--

LOCK TABLES `chat_friend` WRITE;
/*!40000 ALTER TABLE `chat_friend` DISABLE KEYS */;
INSERT INTO `chat_friend` VALUES (1,'2025-12-15 09:24:35',1,1,'名称1','file/chat_friendPicture1.jpg,file/chat_friendPicture2.jpg,file/chat_friendPicture3.jpg','角色1','表名1','别名1',1),(2,'2025-12-15 09:24:35',2,2,'名称2','file/chat_friendPicture2.jpg,file/chat_friendPicture3.jpg,file/chat_friendPicture4.jpg','角色2','表名2','别名2',2),(3,'2025-12-15 09:24:35',3,3,'名称3','file/chat_friendPicture3.jpg,file/chat_friendPicture4.jpg,file/chat_friendPicture5.jpg','角色3','表名3','别名3',3),(4,'2025-12-15 09:24:35',4,4,'名称4','file/chat_friendPicture4.jpg,file/chat_friendPicture5.jpg,file/chat_friendPicture6.jpg','角色4','表名4','别名4',4),(5,'2025-12-15 09:24:35',5,5,'名称5','file/chat_friendPicture5.jpg,file/chat_friendPicture6.jpg,file/chat_friendPicture7.jpg','角色5','表名5','别名5',5),(6,'2025-12-15 09:24:35',6,6,'名称6','file/chat_friendPicture6.jpg,file/chat_friendPicture7.jpg,file/chat_friendPicture8.jpg','角色6','表名6','别名6',6),(7,'2025-12-15 09:24:35',7,7,'名称7','file/chat_friendPicture7.jpg,file/chat_friendPicture8.jpg,file/chat_friendPicture9.jpg','角色7','表名7','别名7',7),(8,'2025-12-15 09:24:35',8,8,'名称8','file/chat_friendPicture8.jpg,file/chat_friendPicture9.jpg,file/chat_friendPicture10.jpg','角色8','表名8','别名8',8),(9,'2025-12-15 09:24:35',9,9,'名称9','file/chat_friendPicture9.jpg,file/chat_friendPicture10.jpg,file/chat_friendPicture11.jpg','角色9','表名9','别名9',9),(10,'2025-12-15 09:24:35',10,10,'名称10','file/chat_friendPicture10.jpg,file/chat_friendPicture11.jpg,file/chat_friendPicture12.jpg','角色10','表名10','别名10',10);
/*!40000 ALTER TABLE `chat_friend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_message`
--

DROP TABLE IF EXISTS `chat_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chat_message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `uid` bigint(20) NOT NULL COMMENT '用户id',
  `fid` bigint(20) NOT NULL COMMENT '好友id',
  `content` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '内容',
  `format` int(11) DEFAULT NULL COMMENT '格式(1:文字，2:图片)',
  `is_read` int(11) DEFAULT '0' COMMENT '消息已读(0:未读，1:已读)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='消息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_message`
--

LOCK TABLES `chat_message` WRITE;
/*!40000 ALTER TABLE `chat_message` DISABLE KEYS */;
INSERT INTO `chat_message` VALUES (1,'2025-12-15 09:24:35',1,1,'内容1',1,1),(2,'2025-12-15 09:24:35',2,2,'内容2',2,2),(3,'2025-12-15 09:24:35',3,3,'内容3',3,3),(4,'2025-12-15 09:24:35',4,4,'内容4',4,4),(5,'2025-12-15 09:24:35',5,5,'内容5',5,5),(6,'2025-12-15 09:24:35',6,6,'内容6',6,6),(7,'2025-12-15 09:24:35',7,7,'内容7',7,7),(8,'2025-12-15 09:24:35',8,8,'内容8',8,8),(9,'2025-12-15 09:24:35',9,9,'内容9',9,9),(10,'2025-12-15 09:24:35',10,10,'内容10',10,10);
/*!40000 ALTER TABLE `chat_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `value` longtext COLLATE utf8mb4_unicode_ci COMMENT '值',
  `url` longtext COLLATE utf8mb4_unicode_ci COMMENT '链接',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='轮播图';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES (1,'2025-12-15 09:24:35','swiper1','file/swiperPicture1.jpg',NULL),(2,'2025-12-15 09:24:35','swiper2','file/swiperPicture2.jpg',NULL),(3,'2025-12-15 09:24:35','swiper3','file/swiperPicture3.jpg',NULL);
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupon`
--

DROP TABLE IF EXISTS `coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coupon` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `coupon_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '优惠券名称',
  `coupon_type` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '优惠券类型',
  `full_amount` double DEFAULT '0' COMMENT '满额',
  `discount_amount` double DEFAULT '0' COMMENT '优惠额',
  `effect_time` datetime DEFAULT NULL COMMENT '生效时间',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
  `remark` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `shangjiazhanghao` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商户名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='优惠券';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupon`
--

LOCK TABLES `coupon` WRITE;
/*!40000 ALTER TABLE `coupon` DISABLE KEYS */;
INSERT INTO `coupon` VALUES (1,'2025-12-15 09:24:34','优惠券名称1','满减券',1,1,'2025-12-15 17:24:34','2025-12-15 17:24:34','备注1',1,'商户名称1'),(2,'2025-12-15 09:24:34','优惠券名称2','满减券',2,2,'2025-12-15 17:24:34','2025-12-15 17:24:34','备注2',2,'商户名称2'),(3,'2025-12-15 09:24:34','优惠券名称3','满减券',3,3,'2025-12-15 17:24:34','2025-12-15 17:24:34','备注3',3,'商户名称3'),(4,'2025-12-15 09:24:34','优惠券名称4','满减券',4,4,'2025-12-15 17:24:34','2025-12-15 17:24:34','备注4',4,'商户名称4'),(5,'2025-12-15 09:24:34','优惠券名称5','满减券',5,5,'2025-12-15 17:24:34','2025-12-15 17:24:34','备注5',5,'商户名称5'),(6,'2025-12-15 09:24:34','优惠券名称6','满减券',6,6,'2025-12-15 17:24:34','2025-12-15 17:24:34','备注6',6,'商户名称6'),(7,'2025-12-15 09:24:34','优惠券名称7','满减券',7,7,'2025-12-15 17:24:34','2025-12-15 17:24:34','备注7',7,'商户名称7'),(8,'2025-12-15 09:24:34','优惠券名称8','满减券',8,8,'2025-12-15 17:24:34','2025-12-15 17:24:34','备注8',8,'商户名称8'),(9,'2025-12-15 09:24:34','优惠券名称9','满减券',9,9,'2025-12-15 17:24:34','2025-12-15 17:24:34','备注9',9,'商户名称9'),(10,'2025-12-15 09:24:34','优惠券名称10','满减券',10,10,'2025-12-15 17:24:34','2025-12-15 17:24:34','备注10',10,'商户名称10');
/*!40000 ALTER TABLE `coupon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dianpuhuodong`
--

DROP TABLE IF EXISTS `dianpuhuodong`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dianpuhuodong` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `huodongbiaoti` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '活动标题',
  `huodongleixing` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '活动类型',
  `tupian` longtext COLLATE utf8mb4_unicode_ci COMMENT '图片',
  `huodongneirong` longtext COLLATE utf8mb4_unicode_ci COMMENT '活动内容',
  `huodongshijian` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '活动时间',
  `shangjiazhanghao` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商家账号',
  `shangjiamingcheng` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商家名称',
  `fabushijian` datetime DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='店铺活动';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dianpuhuodong`
--

LOCK TABLES `dianpuhuodong` WRITE;
/*!40000 ALTER TABLE `dianpuhuodong` DISABLE KEYS */;
INSERT INTO `dianpuhuodong` VALUES (1,'2025-12-15 09:24:34','周末动漫好物狂欢','满赠活动','file/dianpuhuodong_紫罗兰永恒花园1.jpg,file/dianpuhuodong_紫罗兰永恒花园2.jpg,file/dianpuhuodong_紫罗兰永恒花园3.jpg','单笔订单满150送动漫角色贴纸1套','20240901-20240915','商家账号1','商家名称1','2025-12-15 17:24:34'),(2,'2025-12-15 09:24:34','动漫钥匙套促销日','限时折扣','file/dianpuhuodong_剑来1.jpg,file/dianpuhuodong_剑来2.jpg,file/dianpuhuodong_剑来3.jpg','硅胶钥匙套全系列享7折优惠','20240510-20240525','商家账号2','商家名称2','2025-12-15 17:24:34'),(3,'2025-12-15 09:24:34','动漫帆布包特惠场','满减活动','file/dianpuhuodong_心灵奇旅1.jpg,file/dianpuhuodong_心灵奇旅2.jpg,file/dianpuhuodong_心灵奇旅3.jpg','帆布包类商品满80减15满120减30','20240520-20240605','商家账号3','商家名称3','2025-12-15 17:24:34'),(4,'2025-12-15 09:24:34','夏日动漫周边大促','限时折扣','file/dianpuhuodong_沧元图1.jpg,file/dianpuhuodong_沧元图2.jpg,file/dianpuhuodong_沧元图3.jpg','全场动漫周边满200减50满300减100','20240715-20240730','商家账号4','商家名称4','2025-12-15 17:24:34'),(5,'2025-12-15 09:24:34','动漫胸针特惠场','清仓活动','file/dianpuhuodong_一人之下1.jpg,file/dianpuhuodong_一人之下2.jpg,file/dianpuhuodong_一人之下3.jpg','合金胸针全系列5折清仓售完即止','20240710-20240725','商家账号5','商家名称5','2025-12-15 17:24:34'),(6,'2025-12-15 09:24:34','动漫海报特卖会','特价活动','file/dianpuhuodong_蛛侠纵横宇宙1.jpg,file/dianpuhuodong_蛛侠纵横宇宙2.jpg,file/dianpuhuodong_蛛侠纵横宇宙3.jpg','经典动漫海报买3张送2张同款尺寸','20240420-20240505','商家账号6','商家名称6','2025-12-15 17:24:34'),(7,'2025-12-15 09:24:34','动漫鼠标垫狂欢购','限时特价','file/dianpuhuodong_三体1.jpg,file/dianpuhuodong_三体2.jpg,file/dianpuhuodong_三体3.jpg','游戏动漫鼠标垫特价9元起','20240910-20240925','商家账号7','商家名称7','2025-12-15 17:24:34'),(8,'2025-12-15 09:24:34','动漫手办狂欢周','降价促销','file/dianpuhuodong_降世神通科拉传奇1.jpg,file/dianpuhuodong_降世神通科拉传奇2.jpg,file/dianpuhuodong_降世神通科拉传奇3.jpg','热门角色手办直降30至50元','20240801-20240815','商家账号8','商家名称8','2025-12-15 17:24:34'),(9,'2025-12-15 09:24:34','跨年动漫周边盛典','满额换购','file/dianpuhuodong_海贼王1.jpg,file/dianpuhuodong_海贼王2.jpg,file/dianpuhuodong_海贼王3.jpg','满300元可换购限量版动漫立牌1个','20240605-20240620','商家账号9','商家名称9','2025-12-15 17:24:34'),(10,'2025-12-15 09:24:34','动漫拼图趣味购','组合优惠','file/dianpuhuodong_刺客伍六七1.jpg,file/dianpuhuodong_刺客伍六七2.jpg,file/dianpuhuodong_刺客伍六七3.jpg','任意2款拼图组合购买享75折优惠','20240401-20240415','商家账号10','商家名称10','2025-12-15 17:24:34');
/*!40000 ALTER TABLE `dianpuhuodong` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dingzhidingdan`
--

DROP TABLE IF EXISTS `dingzhidingdan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dingzhidingdan` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `dingdanbianhao` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '订单编号',
  `zhoubianmingcheng` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '周边名称',
  `shejituan` longtext COLLATE utf8mb4_unicode_ci COMMENT '设计图案',
  `zhoubianleixing` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '周边类型',
  `yanse` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '颜色',
  `chicun` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '尺寸',
  `caizhi` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '材质',
  `shejimiaoshu` longtext COLLATE utf8mb4_unicode_ci COMMENT '设计描述',
  `shangjiazhanghao` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商家账号',
  `shangjiamingcheng` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商家名称',
  `yonghuzhanghao` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户账号',
  `nicheng` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '昵称',
  `ispay` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '未支付' COMMENT '是否支付',
  PRIMARY KEY (`id`),
  UNIQUE KEY `dingdanbianhao` (`dingdanbianhao`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='定制订单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dingzhidingdan`
--

LOCK TABLES `dingzhidingdan` WRITE;
/*!40000 ALTER TABLE `dingzhidingdan` DISABLE KEYS */;
INSERT INTO `dingzhidingdan` VALUES (1,'2025-12-15 09:24:34','1111111111','动漫主题徽章','file/dingzhidingdan_动漫主题徽章1.jpg,file/dingzhidingdan_动漫主题徽章2.jpg,file/dingzhidingdan_动漫主题徽章3.jpg','徽章','金色','3cm','锌合金','刻进击的巨人调查兵团标志','商家账号1','商家名称1','用户账号1','昵称1','未支付'),(2,'2025-12-15 09:24:34','2222222222','动漫角色T恤','file/dingzhidingdan_动漫角色T恤1.jpg,file/dingzhidingdan_动漫角色T恤2.jpg,file/dingzhidingdan_动漫角色T恤3.jpg','T恤','藏青','M','纯棉','印火影忍者鸣人九尾模式','商家账号2','商家名称2','用户账号2','昵称2','未支付'),(3,'2025-12-15 09:24:34','3333333333','主题书签','file/dingzhidingdan_主题书签1.jpg,file/dingzhidingdan_主题书签2.jpg,file/dingzhidingdan_主题书签3.jpg','书签','金色','15cm','黄铜','制夏目友人帐猫咪老师图案','商家账号3','商家名称3','用户账号3','昵称3','未支付'),(4,'2025-12-15 09:24:34','4444444444','动漫主题胸针','file/dingzhidingdan_动漫主题胸针1.jpg,file/dingzhidingdan_动漫主题胸针2.jpg,file/dingzhidingdan_动漫主题胸针3.jpg','胸针','银色','2cm','合金','做间谍过家家阿尼亚表情包','商家账号4','商家名称4','用户账号4','昵称4','未支付'),(5,'2025-12-15 09:24:34','5555555555','Q版角色冰箱贴','file/dingzhidingdan_Q版角色冰箱贴1.jpg,file/dingzhidingdan_Q版角色冰箱贴2.jpg,file/dingzhidingdan_Q版角色冰箱贴3.jpg','冰箱贴','彩色','5cm','磁性','做原神派蒙应急食品造型','商家账号5','商家名称5','用户账号5','昵称5','未支付'),(6,'2025-12-15 09:24:34','6666666666','动漫场景拼图','file/dingzhidingdan_动漫场景拼图1.jpg,file/dingzhidingdan_动漫场景拼图2.jpg,file/dingzhidingdan_动漫场景拼图3.jpg','拼图','彩色','50x50cm','纸质','拼咒术回战高专全员合照','商家账号6','商家名称6','用户账号6','昵称6','未支付'),(7,'2025-12-15 09:24:34','7777777777','动漫主题帆布袋','file/dingzhidingdan_动漫主题帆布袋1.jpg,file/dingzhidingdan_动漫主题帆布袋2.jpg,file/dingzhidingdan_动漫主题帆布袋3.jpg','帆布袋','米色','30x40cm','帆布','印全职猎人小杰钓鱼图案','商家账号7','商家名称7','用户账号7','昵称7','未支付'),(8,'2025-12-15 09:24:34','8888888888','动漫场景明信片','file/dingzhidingdan_动漫场景明信片1.jpg,file/dingzhidingdan_动漫场景明信片2.jpg,file/dingzhidingdan_动漫场景明信片3.jpg','明信片','彩色','10x15cm','卡纸','印全职猎人友克鑫市场景','商家账号8','商家名称8','用户账号8','昵称8','未支付'),(9,'2025-12-15 09:24:34','9999999999','动漫场景挂画','file/dingzhidingdan_动漫场景挂画1.jpg,file/dingzhidingdan_动漫场景挂画2.jpg,file/dingzhidingdan_动漫场景挂画3.jpg','挂画','蓝色','50x70','油画布','绘鬼灭之刃无限列车场景','商家账号9','商家名称9','用户账号9','昵称9','未支付'),(10,'2025-12-15 09:24:34','11111111110','主题文化衫','file/dingzhidingdan_主题文化衫1.jpg,file/dingzhidingdan_主题文化衫2.jpg,file/dingzhidingdan_主题文化衫3.jpg','文化衫','白色','XL','棉混纺','印火影忍者木叶村标志','商家账号10','商家名称10','用户账号10','昵称10','未支付');
/*!40000 ALTER TABLE `dingzhidingdan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discussdongmanshangpin`
--

DROP TABLE IF EXISTS `discussdongmanshangpin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discussdongmanshangpin` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `refid` bigint(20) NOT NULL COMMENT '关联表id',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `avatarurl` longtext COLLATE utf8mb4_unicode_ci COMMENT '头像',
  `nickname` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `score` double DEFAULT NULL COMMENT '评分',
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论内容',
  `reply` longtext COLLATE utf8mb4_unicode_ci COMMENT '回复内容',
  `thumbsupnum` int(11) DEFAULT '0' COMMENT '赞',
  `crazilynum` int(11) DEFAULT '0' COMMENT '踩',
  `istop` int(11) DEFAULT '0' COMMENT '置顶(1:置顶,0:非置顶)',
  `tuserids` longtext COLLATE utf8mb4_unicode_ci COMMENT '赞用户ids',
  `cuserids` longtext COLLATE utf8mb4_unicode_ci COMMENT '踩用户ids',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='动漫商品评论表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discussdongmanshangpin`
--

LOCK TABLES `discussdongmanshangpin` WRITE;
/*!40000 ALTER TABLE `discussdongmanshangpin` DISABLE KEYS */;
/*!40000 ALTER TABLE `discussdongmanshangpin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dongmanshangpin`
--

DROP TABLE IF EXISTS `dongmanshangpin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dongmanshangpin` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `shangpinmingcheng` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品名称',
  `shangpinleixing` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品类型',
  `shangpintupian` longtext COLLATE utf8mb4_unicode_ci COMMENT '商品图片',
  `dongmanpinpai` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '动漫品牌',
  `dongmanIP` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '动漫IP',
  `guige` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '规格',
  `dongmancaizhi` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '动漫材质',
  `shangpinxiangqing` longtext COLLATE utf8mb4_unicode_ci COMMENT '商品详情',
  `score` double DEFAULT NULL COMMENT '评分',
  `onelimittimes` int(11) DEFAULT '-1' COMMENT '单限',
  `alllimittimes` int(11) DEFAULT '-1' COMMENT '库存',
  `sfsh` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '待审核' COMMENT '是否审核',
  `shhf` longtext COLLATE utf8mb4_unicode_ci COMMENT '回复内容',
  `storeup_number` int(11) DEFAULT '0' COMMENT '收藏数',
  `discuss_number` int(11) DEFAULT '0' COMMENT '评论数',
  `price` double DEFAULT '0' COMMENT '价格',
  `is_shelves` int(11) DEFAULT '1' COMMENT '是否上架',
  `thumbsup_number` int(11) DEFAULT '0' COMMENT '赞',
  `crazily_number` int(11) DEFAULT '0' COMMENT '踩',
  `clicktime` datetime DEFAULT NULL COMMENT '最近点击时间',
  `shangjiazhanghao` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商家账号',
  `shangjiamingcheng` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商家名称',
  PRIMARY KEY (`id`),
  KEY `dongmanshangpin_price` (`id`,`price`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='动漫商品';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dongmanshangpin`
--

LOCK TABLES `dongmanshangpin` WRITE;
/*!40000 ALTER TABLE `dongmanshangpin` DISABLE KEYS */;
INSERT INTO `dongmanshangpin` VALUES (1,'2025-12-15 09:24:34','《夏目友人帐》猫咪老师抱枕','抱枕','file/dongmanshangpin_《夏目友人帐》猫咪老师抱枕1.jpg,file/dongmanshangpin_《夏目友人帐》猫咪老师抱枕2.jpg,file/dongmanshangpin_《夏目友人帐》猫咪老师抱枕3.jpg','LIZERDYX','《夏目友人帐》','40cm×60cm','水晶绒','猫咪老师圆滚滚形象水晶绒面料亲肤透气填充均匀不易变形',1,1,110,'是','',1,1,69,1,1,1,'2025-12-15 17:24:34','商家账号1','商家名称1'),(2,'2025-12-15 09:24:34','《银魂》伊丽莎白玩偶','毛绒玩具','file/dongmanshangpin_《银魂》伊丽莎白玩偶1.jpg,file/dongmanshangpin_《银魂》伊丽莎白玩偶2.jpg,file/dongmanshangpin_《银魂》伊丽莎白玩偶3.jpg','都爱漫','《银魂》','高度30cm','短毛绒+PP棉','伊丽莎白呆萌形象毛绒柔软填充饱满手感好适合抱睡或装饰',2,2,90,'是','',2,2,89,1,2,2,'2025-12-15 17:24:34','商家账号2','商家名称2'),(3,'2025-12-15 09:24:34','《咒术回战》五条悟眼罩','配饰','file/dongmanshangpin_《咒术回战》五条悟眼罩1.jpg,file/dongmanshangpin_《咒术回战》五条悟眼罩2.jpg,file/dongmanshangpin_《咒术回战》五条悟眼罩3.jpg','幸运石动漫','《咒术回战》','均码','polyester','还原五条悟标志性黑色眼罩弹性适中佩戴舒适可日常使用或cosplay',3,3,200,'是','',3,3,25,1,3,3,'2025-12-15 17:24:34','商家账号3','商家名称3'),(4,'2025-12-15 09:24:34','《海贼王》罗宾同款耳环','配饰','file/dongmanshangpin_《海贼王》罗宾同款耳环1.jpg,file/dongmanshangpin_《海贼王》罗宾同款耳环2.jpg,file/dongmanshangpin_《海贼王》罗宾同款耳环3.jpg','MUGIWARASTORE','《海贼王》','单只装','合金+水钻','还原罗宾佩戴的耳环款式合金材质不易过敏水钻闪耀提升整体搭配感',4,4,170,'是','',4,4,69,1,4,4,'2025-12-15 17:24:34','商家账号4','商家名称4'),(5,'2025-12-15 09:24:34','《火影忍者》晓组织披风','服装','file/dongmanshangpin_《火影忍者》晓组织披风1.jpg,file/dongmanshangpin_《火影忍者》晓组织披风2.jpg,file/dongmanshangpin_《火影忍者》晓组织披风3.jpg','BANDAISPIRITS','《火影忍者》','均码','polyester','晓组织红色披风设计带黑色祥云图案面料垂顺有质感适合cosplay或装饰',5,5,95,'是','',5,5,14,1,5,5,'2025-12-15 17:24:34','商家账号5','商家名称5'),(6,'2025-12-15 09:24:34','《JOJO的奇妙冒险》替身使者贴纸','贴纸','file/dongmanshangpin_《JOJO的奇妙冒险》替身使者贴纸1.jpg,file/dongmanshangpin_《JOJO的奇妙冒险》替身使者贴纸2.jpg,file/dongmanshangpin_《JOJO的奇妙冒险》替身使者贴纸3.jpg','BANDAI','《JOJO的奇妙冒险》','10张/套','PVC','包含多种替身使者图案防水防刮可贴在手机笔记本等物品上',6,6,400,'是','',6,6,19,1,6,6,'2025-12-15 17:24:34','商家账号6','商家名称6'),(7,'2025-12-15 09:24:34','《海贼王》路飞草帽','配饰','file/dongmanshangpin_《海贼王》路飞草帽1.jpg,file/dongmanshangpin_《海贼王》路飞草帽2.jpg,file/dongmanshangpin_《海贼王》路飞草帽3.jpg','Abystyle','《海贼王》','均码','草编+棉布','还原路飞标志性草帽草编材质轻便棉布内衬舒适可日常佩戴或cosplay',7,7,130,'是','',7,7,79,1,7,7,'2025-12-15 17:24:34','商家账号7','商家名称7'),(8,'2025-12-15 09:24:34','《初音未来》洛天依联名马克杯','餐具','file/dongmanshangpin_《初音未来》洛天依联名马克杯1.jpg,file/dongmanshangpin_《初音未来》洛天依联名马克杯2.jpg,file/dongmanshangpin_《初音未来》洛天依联名马克杯3.jpg','GSC','《初音未来》《洛天依》','容量350ml','陶瓷','杯身印初音与洛天依联名图案陶瓷材质耐高温易清洗适合日常使用',8,8,230,'是','',8,8,49,1,8,8,'2025-12-15 17:24:34','商家账号8','商家名称8'),(9,'2025-12-15 09:24:34','《海贼王》万里阳光号模型','拼装模型','file/dongmanshangpin_《海贼王》万里阳光号模型1.jpg,file/dongmanshangpin_《海贼王》万里阳光号模型2.jpg,file/dongmanshangpin_《海贼王》万里阳光号模型3.jpg','万代spirits','《海贼王》','比例1:100','ABS塑料','还原万里阳光号外观结构含可拆卸部件需自行拼装锻炼动手能力',9,9,80,'是','',9,9,299,1,9,9,'2025-12-15 17:24:34','商家账号9','商家名称9'),(10,'2025-12-15 09:24:34','《鬼灭之刃》日轮刀挂件','挂件','file/dongmanshangpin_《鬼灭之刃》日轮刀挂件1.jpg,file/dongmanshangpin_《鬼灭之刃》日轮刀挂件2.jpg,file/dongmanshangpin_《鬼灭之刃》日轮刀挂件3.jpg','BANDAI','《鬼灭之刃》','长度10cm','金属+塑料','日轮刀缩小版造型金属刀身塑料刀柄细节精致可挂在背包或钥匙上',10,10,210,'是','',10,10,55,1,10,10,'2025-12-15 17:24:34','商家账号10','商家名称10');
/*!40000 ALTER TABLE `dongmanshangpin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dongmanzhutihuodong`
--

DROP TABLE IF EXISTS `dongmanzhutihuodong`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dongmanzhutihuodong` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `huodongmingcheng` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '活动名称',
  `huodongtupian` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '活动图片',
  `huodongleixing` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '活动类型',
  `canjiaxingshi` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '参加形式',
  `kaishishijian` datetime NOT NULL COMMENT '开始时间',
  `jieshushijian` datetime NOT NULL COMMENT '结束时间',
  `shengyuminge` int(11) NOT NULL COMMENT '剩余名额',
  `huodongdidian` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '活动地点',
  `huodongneirong` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '活动内容',
  `zhuyishixiang` longtext COLLATE utf8mb4_unicode_ci COMMENT '注意事项',
  `fabushijian` datetime NOT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='动漫主题活动';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dongmanzhutihuodong`
--

LOCK TABLES `dongmanzhutihuodong` WRITE;
/*!40000 ALTER TABLE `dongmanzhutihuodong` DISABLE KEYS */;
INSERT INTO `dongmanzhutihuodong` VALUES (1,'2025-12-15 09:24:35','原神提瓦特主题游园会','file/dongmanzhutihuodong_紫罗兰永恒花园1.jpg,file/dongmanzhutihuodong_紫罗兰永恒花园2.jpg,file/dongmanzhutihuodong_紫罗兰永恒花园3.jpg','线下主题活动','线上','2025-12-15 17:24:35','2025-12-15 17:24:35',300,'清风公园','搭建蒙德璃月稻妻主题场景开放角色互动拍照区设置元素反应小游戏发放原神限定周边','参与游戏需排队禁止损坏主题场景道具禁止攀爬布景设施','2025-12-15 17:24:35'),(2,'2025-12-15 09:24:35','线上动漫周边限时折扣节','file/dongmanzhutihuodong_剑来1.jpg,file/dongmanzhutihuodong_剑来2.jpg,file/dongmanzhutihuodong_剑来3.jpg','线上促销','线上','2025-12-15 17:24:35','2025-12-15 17:24:35',500,'电商平台官方店铺','全场动漫周边满200减50满300减100新品首周9折会员额外85折','下单前确认收货地址活动优惠不与其他福利叠加禁止恶意刷单','2025-12-15 17:24:35'),(3,'2025-12-15 09:24:35','动漫周边福袋秒杀专场','file/dongmanzhutihuodong_心灵奇旅1.jpg,file/dongmanzhutihuodong_心灵奇旅2.jpg,file/dongmanzhutihuodong_心灵奇旅3.jpg','线上促销','线上','2025-12-15 17:24:35','2025-12-15 17:24:35',40,'直播平台官方直播间','推出29元59元99元三档福袋每档福袋内含3至5件随机动漫周边限时1小时秒杀','福袋商品不支持退换秒杀需准时参与禁止恶意拍下不付款','2025-12-15 17:24:35'),(4,'2025-12-15 09:24:35','线上动漫主题直播带货','file/dongmanzhutihuodong_沧元图1.jpg,file/dongmanzhutihuodong_沧元图2.jpg,file/dongmanzhutihuodong_沧元图3.jpg','线上促销','线上','2025-12-15 17:24:35','2025-12-15 17:24:35',20,'直播平台','邀请动漫博主直播推荐动漫周边包括手办文具服饰等设置限时秒杀优惠券发放等福利','直播购物需理性消费禁止冲动下单禁止恶意退货','2025-12-15 17:24:35'),(5,'2025-12-15 09:24:35','火影忍者忍术对决挑战赛','file/dongmanzhutihuodong_一人之下1.jpg,file/dongmanzhutihuodong_一人之下2.jpg,file/dongmanzhutihuodong_一人之下3.jpg','线下竞技活动','线上','2025-12-15 17:24:35','2025-12-15 17:24:35',30,'电竞馆','设置火影忍者主题格斗游戏比赛选手cosplay火影角色参赛开展忍术知识问答评选优胜选手','比赛需遵守电竞馆规则禁止使用外挂禁止辱骂对手','2025-12-15 17:24:35'),(6,'2025-12-15 09:24:35','咒术回战高专特训营','file/dongmanzhutihuodong_蛛侠纵横宇宙1.jpg,file/dongmanzhutihuodong_蛛侠纵横宇宙2.jpg,file/dongmanzhutihuodong_蛛侠纵横宇宙3.jpg','线下互动活动','线上','2025-12-15 17:24:35','2025-12-15 17:24:35',40,'奥体中心体育馆','还原咒术高专教室场景举办咒术师cosplay招募开展咒术知识竞赛设置咒灵讨伐体验区','进入特训营需保持安静禁止大声喧哗禁止cosplay暴力装扮','2025-12-15 17:24:35'),(7,'2025-12-15 09:24:35','线上动漫角色绘画大赛','file/dongmanzhutihuodong_三体1.jpg,file/dongmanzhutihuodong_三体2.jpg,file/dongmanzhutihuodong_三体3.jpg','线上比赛','线上','2025-12-15 17:24:35','2025-12-15 17:24:35',500,'动漫社区平台','征集动漫角色原创绘画作品分插画手绘漫画三个赛道邀请专业评委打分评选获奖作品','参赛作品需为原创禁止抄袭盗用他人作品禁止提交违规内容','2025-12-15 17:24:35'),(8,'2025-12-15 09:24:35','二次元cosplay自由行','file/dongmanzhutihuodong_降世神通科拉传奇1.jpg,file/dongmanzhutihuodong_降世神通科拉传奇2.jpg,file/dongmanzhutihuodong_降世神通科拉传奇3.jpg','线下漫展衍生活动','线上','2025-12-15 17:24:35','2025-12-15 17:24:35',100,'环球动漫嬉戏谷','邀请coser自由入场拍摄设置cosplay摄影区举办coser才艺展示评选最美coser','cosplay服装需符合公序良俗禁止裸露装扮禁止使用仿真武器','2025-12-15 17:24:35'),(9,'2025-12-15 09:24:35','海贼王航海冒险挑战营','file/dongmanzhutihuodong_海贼王1.jpg,file/dongmanzhutihuodong_海贼王2.jpg,file/dongmanzhutihuodong_海贼王3.jpg','线下体验活动','线上','2025-12-15 17:24:35','2025-12-15 17:24:35',30,'海岸城购物中心中庭','模拟伟大航路探险任务设置寻宝关卡开展海贼王知识问答组织路飞橡胶拳体验游戏','关卡挑战需遵守规则禁止推搡拥挤禁止私自移动关卡道具','2025-12-15 17:24:35'),(10,'2025-12-15 09:24:35','动漫周边跳蚤市场','file/dongmanzhutihuodong_刺客伍六七1.jpg,file/dongmanzhutihuodong_刺客伍六七2.jpg,file/dongmanzhutihuodong_刺客伍六七3.jpg','线下交易活动','线上','2025-12-15 17:24:35','2025-12-15 17:24:35',150,'文化广场','邀请漫迷摆摊售卖闲置动漫周边包括手办徽章海报等设置官方鉴定区保障商品质量','交易需自愿公平禁止售卖盗版周边禁止强买强卖','2025-12-15 17:24:35');
/*!40000 ALTER TABLE `dongmanzhutihuodong` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `huodongbaoming`
--

DROP TABLE IF EXISTS `huodongbaoming`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `huodongbaoming` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `baomingbianhao` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '报名编号',
  `huodongmingcheng` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '活动名称',
  `huodongtupian` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '活动图片',
  `huodongleixing` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '活动类型',
  `shengyuminge` int(11) NOT NULL COMMENT '剩余名额',
  `huodongdidian` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '活动地点',
  `baomingshijian` datetime NOT NULL COMMENT '报名时间',
  `yonghuzhanghao` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户账号',
  `nicheng` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '昵称',
  `crossuserid` bigint(20) DEFAULT NULL COMMENT '跨表用户id',
  `crossrefid` bigint(20) DEFAULT NULL COMMENT '跨表主键id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `baomingbianhao` (`baomingbianhao`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='活动报名';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `huodongbaoming`
--

LOCK TABLES `huodongbaoming` WRITE;
/*!40000 ALTER TABLE `huodongbaoming` DISABLE KEYS */;
INSERT INTO `huodongbaoming` VALUES (1,'2025-12-15 09:24:35','1111111111','原神提瓦特主题游园会','file/huodongbaoming_紫罗兰永恒花园1.jpg,file/huodongbaoming_紫罗兰永恒花园2.jpg,file/huodongbaoming_紫罗兰永恒花园3.jpg','线下主题活动',300,'清风公园','2025-12-15 17:24:35','用户账号1','昵称1',1,1),(2,'2025-12-15 09:24:35','2222222222','线上动漫周边限时折扣节','file/huodongbaoming_剑来1.jpg,file/huodongbaoming_剑来2.jpg,file/huodongbaoming_剑来3.jpg','线上促销',500,'电商平台官方店铺','2025-12-15 17:24:35','用户账号2','昵称2',2,2),(3,'2025-12-15 09:24:35','3333333333','动漫周边福袋秒杀专场','file/huodongbaoming_心灵奇旅1.jpg,file/huodongbaoming_心灵奇旅2.jpg,file/huodongbaoming_心灵奇旅3.jpg','线上促销',40,'直播平台官方直播间','2025-12-15 17:24:35','用户账号3','昵称3',3,3),(4,'2025-12-15 09:24:35','4444444444','线上动漫主题直播带货','file/huodongbaoming_沧元图1.jpg,file/huodongbaoming_沧元图2.jpg,file/huodongbaoming_沧元图3.jpg','线上促销',20,'直播平台','2025-12-15 17:24:35','用户账号4','昵称4',4,4),(5,'2025-12-15 09:24:35','5555555555','火影忍者忍术对决挑战赛','file/huodongbaoming_一人之下1.jpg,file/huodongbaoming_一人之下2.jpg,file/huodongbaoming_一人之下3.jpg','线下竞技活动',30,'电竞馆','2025-12-15 17:24:35','用户账号5','昵称5',5,5),(6,'2025-12-15 09:24:35','6666666666','咒术回战高专特训营','file/huodongbaoming_蛛侠纵横宇宙1.jpg,file/huodongbaoming_蛛侠纵横宇宙2.jpg,file/huodongbaoming_蛛侠纵横宇宙3.jpg','线下互动活动',40,'奥体中心体育馆','2025-12-15 17:24:35','用户账号6','昵称6',6,6),(7,'2025-12-15 09:24:35','7777777777','线上动漫角色绘画大赛','file/huodongbaoming_三体1.jpg,file/huodongbaoming_三体2.jpg,file/huodongbaoming_三体3.jpg','线上比赛',500,'动漫社区平台','2025-12-15 17:24:35','用户账号7','昵称7',7,7),(8,'2025-12-15 09:24:35','8888888888','二次元cosplay自由行','file/huodongbaoming_降世神通科拉传奇1.jpg,file/huodongbaoming_降世神通科拉传奇2.jpg,file/huodongbaoming_降世神通科拉传奇3.jpg','线下漫展衍生活动',100,'环球动漫嬉戏谷','2025-12-15 17:24:35','用户账号8','昵称8',8,8),(9,'2025-12-15 09:24:35','9999999999','海贼王航海冒险挑战营','file/huodongbaoming_海贼王1.jpg,file/huodongbaoming_海贼王2.jpg,file/huodongbaoming_海贼王3.jpg','线下体验活动',30,'海岸城购物中心中庭','2025-12-15 17:24:35','用户账号9','昵称9',9,9),(10,'2025-12-15 09:24:35','11111111110','动漫周边跳蚤市场','file/huodongbaoming_刺客伍六七1.jpg,file/huodongbaoming_刺客伍六七2.jpg,file/huodongbaoming_刺客伍六七3.jpg','线下交易活动',150,'文化广场','2025-12-15 17:24:35','用户账号10','昵称10',10,10);
/*!40000 ALTER TABLE `huodongbaoming` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `huodongleixing`
--

DROP TABLE IF EXISTS `huodongleixing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `huodongleixing` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `huodongleixing` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '活动类型',
  PRIMARY KEY (`id`),
  UNIQUE KEY `huodongleixing` (`huodongleixing`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='活动类型';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `huodongleixing`
--

LOCK TABLES `huodongleixing` WRITE;
/*!40000 ALTER TABLE `huodongleixing` DISABLE KEYS */;
INSERT INTO `huodongleixing` VALUES (1,'2025-12-15 09:24:35','线下主题活动'),(2,'2025-12-15 09:24:35','线上促销'),(3,'2025-12-15 09:24:35','线下竞技活动'),(4,'2025-12-15 09:24:35','线下互动活动'),(5,'2025-12-15 09:24:35','线上比赛'),(6,'2025-12-15 09:24:35','线下漫展衍生活动'),(7,'2025-12-15 09:24:35','线下体验活动'),(8,'2025-12-15 09:24:35','线下交易活动'),(9,'2025-12-15 09:24:35','活动类型9'),(10,'2025-12-15 09:24:35','活动类型10');
/*!40000 ALTER TABLE `huodongleixing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `menujson` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='菜单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'2025-12-15 09:24:35','[{\"backMenu\":[{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"日销量\",\"月销量\",\"日销额\",\"月销额\",\"品销量\",\"导出\",\"首页总数\",\"首页统计\"],\"appFrontIcon\":\"cuIcon-wenzi\",\"buttons\":[\"查看\"],\"menu\":\"商品订单\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"日销量\",\"月销量\",\"日销额\",\"月销额\",\"品销量\",\"导出\",\"首页总数\",\"首页统计\"],\"appFrontIcon\":\"cuIcon-wenzi\",\"buttons\":[\"查看\"],\"menu\":\"未支付订单\",\"menuJump\":\"未支付\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"日销量\",\"月销量\",\"日销额\",\"月销额\",\"品销量\",\"导出\",\"首页总数\",\"首页统计\",\"发货\",\"物流\",\"核销\"],\"appFrontIcon\":\"cuIcon-wenzi\",\"buttons\":[\"查看\",\"物流\"],\"menu\":\"已支付订单\",\"menuJump\":\"已支付\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"日销量\",\"月销量\",\"日销额\",\"月销额\",\"品销量\",\"导出\",\"首页总数\",\"首页统计\",\"物流\"],\"appFrontIcon\":\"cuIcon-wenzi\",\"buttons\":[\"查看\",\"物流\"],\"menu\":\"已完成订单\",\"menuJump\":\"已完成\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"日销量\",\"月销量\",\"日销额\",\"月销额\",\"品销量\",\"导出\",\"首页总数\",\"首页统计\"],\"appFrontIcon\":\"cuIcon-wenzi\",\"buttons\":[\"查看\"],\"menu\":\"已取消订单\",\"menuJump\":\"已取消\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"日销量\",\"月销量\",\"日销额\",\"月销额\",\"品销量\",\"导出\",\"首页总数\",\"首页统计\",\"物流\"],\"appFrontIcon\":\"cuIcon-wenzi\",\"buttons\":[\"查看\",\"物流\"],\"menu\":\"已退款订单\",\"menuJump\":\"已退款\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"日销量\",\"月销量\",\"日销额\",\"月销额\",\"品销量\",\"导出\",\"首页总数\",\"首页统计\",\"确认收货\",\"物流\"],\"appFrontIcon\":\"cuIcon-wenzi\",\"buttons\":[\"查看\",\"确认收货\",\"物流\"],\"menu\":\"已发货订单\",\"menuJump\":\"已发货\",\"tableName\":\"orders\"}],\"fontClass\":\"icon-common19\",\"menu\":\"订单管理\",\"unicode\":\"&#xee00;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"支付\"],\"appFrontIcon\":\"cuIcon-copy\",\"buttons\":[\"查看\",\"支付\"],\"classname\":\"dingzhidingdan\",\"menu\":\"定制订单\",\"menuJump\":\"列表\",\"tableName\":\"dingzhidingdan\"}],\"fontClass\":\"icon-common15\",\"menu\":\"定制订单管理\",\"unicode\":\"&#xedfc;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-circle\",\"buttons\":[\"查看\"],\"classname\":\"huodongbaoming\",\"menu\":\"活动报名\",\"menuJump\":\"列表\",\"tableName\":\"huodongbaoming\"}],\"fontClass\":\"icon-common10\",\"menu\":\"活动报名管理\",\"unicode\":\"&#xedd1;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-rank\",\"buttons\":[\"查看\"],\"classname\":\"storeup\",\"menu\":\"我的收藏\",\"menuJump\":\"1\",\"tableName\":\"storeup\"}],\"fontClass\":\"icon-common30\",\"menu\":\"我的收藏管理\",\"unicode\":\"&#xee30;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-keyboard\",\"buttons\":[\"查看\"],\"classname\":\"myCoupon\",\"menu\":\"我的优惠券\",\"menuJump\":\"列表\",\"tableName\":\"my_coupon\"}],\"fontClass\":\"icon-common47\",\"menu\":\"我的优惠券管理\",\"unicode\":\"&#xef63;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-present\",\"buttons\":[\"查看\"],\"classname\":\"address\",\"menu\":\"地址\",\"menuJump\":\"列表\",\"tableName\":\"address\"}],\"fontClass\":\"icon-common46\",\"menu\":\"地址管理\",\"unicode\":\"&#xef3d;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-pic\",\"buttons\":[\"查看\"],\"classname\":\"rechargeRecord\",\"menu\":\"充值记录\",\"menuJump\":\"列表\",\"tableName\":\"recharge_record\"}],\"fontClass\":\"icon-common40\",\"menu\":\"充值记录管理\",\"unicode\":\"&#xeebb;\"}],\"frontMenu\":[{\"child\":[{\"appFrontIcon\":\"cuIcon-rank\",\"buttons\":[\"查看\",\"私信\"],\"classname\":\"dongmanshangpin\",\"fontClass\":\"icon-common16\",\"menu\":\"动漫商品\",\"menuJump\":\"列表\",\"tableName\":\"dongmanshangpin\",\"unicode\":\"&#xedfd;\"}],\"fontClass\":\"icon-common16\",\"menu\":\"动漫商品\",\"unicode\":\"&#xedfd;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-camera\",\"buttons\":[\"查看\",\"定制周边\"],\"classname\":\"zhoubiandingzhi\",\"fontClass\":\"icon-common17\",\"menu\":\"周边定制\",\"menuJump\":\"列表\",\"tableName\":\"zhoubiandingzhi\",\"unicode\":\"&#xedfe;\"}],\"fontClass\":\"icon-common17\",\"menu\":\"周边定制\",\"unicode\":\"&#xedfe;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-flashlightopen\",\"buttons\":[\"查看\"],\"classname\":\"dianpuhuodong\",\"fontClass\":\"icon-common45\",\"menu\":\"店铺活动\",\"menuJump\":\"列表\",\"tableName\":\"dianpuhuodong\",\"unicode\":\"&#xef3b;\"}],\"fontClass\":\"icon-common45\",\"menu\":\"店铺活动\",\"unicode\":\"&#xef3b;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-addressbook\",\"buttons\":[\"查看\",\"报名\"],\"classname\":\"dongmanzhutihuodong\",\"fontClass\":\"icon-common23\",\"menu\":\"动漫主题活动\",\"menuJump\":\"列表\",\"tableName\":\"dongmanzhutihuodong\",\"unicode\":\"&#xee05;\"}],\"fontClass\":\"icon-common23\",\"menu\":\"动漫主题活动\",\"unicode\":\"&#xee05;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-rank\",\"buttons\":[\"查看\"],\"classname\":\"news\",\"fontClass\":\"icon-common15\",\"menu\":\"系统公告\",\"menuJump\":\"列表\",\"tableName\":\"news\",\"unicode\":\"&#xedfc;\"}],\"fontClass\":\"icon-common15\",\"menu\":\"系统公告\",\"unicode\":\"&#xedfc;\"}],\"hasBackLogin\":\"否\",\"hasBackRegister\":\"否\",\"hasFrontLogin\":\"是\",\"hasFrontRegister\":\"是\",\"pathName\":\"yonghu\",\"roleName\":\"用户\",\"tableName\":\"yonghu\"},{\"backMenu\":[{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-form\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"classname\":\"coupon\",\"menu\":\"优惠券\",\"menuJump\":\"列表\",\"tableName\":\"coupon\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"查看评论\",\"私信\"],\"appFrontIcon\":\"cuIcon-qrcode\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"查看评论\"],\"classname\":\"dongmanshangpin\",\"menu\":\"动漫商品\",\"menuJump\":\"列表\",\"tableName\":\"dongmanshangpin\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-circle\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"classname\":\"shangpinleixing\",\"menu\":\"商品类型\",\"menuJump\":\"列表\",\"tableName\":\"shangpinleixing\"}],\"fontClass\":\"icon-common50\",\"menu\":\"动漫商品管理\",\"unicode\":\"&#xef96;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"日销量\",\"月销量\",\"日销额\",\"月销额\",\"品销量\",\"导出\",\"首页总数\",\"首页统计\"],\"appFrontIcon\":\"cuIcon-wenzi\",\"buttons\":[\"查看\",\"日销量\",\"月销量\",\"日销额\",\"月销额\",\"品销量\",\"首页总数\",\"首页统计\",\"审核\"],\"menu\":\"商品订单\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"日销量\",\"月销量\",\"日销额\",\"月销额\",\"品销量\",\"导出\",\"首页总数\",\"首页统计\"],\"appFrontIcon\":\"cuIcon-wenzi\",\"buttons\":[\"查看\"],\"menu\":\"未支付订单\",\"menuJump\":\"未支付\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"日销量\",\"月销量\",\"日销额\",\"月销额\",\"品销量\",\"导出\",\"首页总数\",\"首页统计\",\"发货\",\"物流\",\"核销\"],\"appFrontIcon\":\"cuIcon-wenzi\",\"buttons\":[\"查看\",\"物流\",\"发货\"],\"menu\":\"已支付订单\",\"menuJump\":\"已支付\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"日销量\",\"月销量\",\"日销额\",\"月销额\",\"品销量\",\"导出\",\"首页总数\",\"首页统计\",\"物流\"],\"appFrontIcon\":\"cuIcon-wenzi\",\"buttons\":[\"查看\",\"审核\",\"物流\"],\"menu\":\"已完成订单\",\"menuJump\":\"已完成\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"日销量\",\"月销量\",\"日销额\",\"月销额\",\"品销量\",\"导出\",\"首页总数\",\"首页统计\"],\"appFrontIcon\":\"cuIcon-wenzi\",\"buttons\":[\"查看\"],\"menu\":\"已取消订单\",\"menuJump\":\"已取消\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"日销量\",\"月销量\",\"日销额\",\"月销额\",\"品销量\",\"导出\",\"首页总数\",\"首页统计\",\"物流\"],\"appFrontIcon\":\"cuIcon-wenzi\",\"buttons\":[\"查看\",\"物流\"],\"menu\":\"已退款订单\",\"menuJump\":\"已退款\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"日销量\",\"月销量\",\"日销额\",\"月销额\",\"品销量\",\"导出\",\"首页总数\",\"首页统计\",\"确认收货\",\"物流\"],\"appFrontIcon\":\"cuIcon-wenzi\",\"buttons\":[\"查看\",\"物流\"],\"menu\":\"已发货订单\",\"menuJump\":\"已发货\",\"tableName\":\"orders\"}],\"fontClass\":\"icon-common19\",\"menu\":\"订单管理\",\"unicode\":\"&#xee00;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"定制周边\"],\"appFrontIcon\":\"cuIcon-rank\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"classname\":\"zhoubiandingzhi\",\"menu\":\"周边定制\",\"menuJump\":\"列表\",\"tableName\":\"zhoubiandingzhi\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-attentionfavor\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"classname\":\"zhoubianleixing\",\"menu\":\"周边类型\",\"menuJump\":\"列表\",\"tableName\":\"zhoubianleixing\"}],\"fontClass\":\"icon-common34\",\"menu\":\"周边定制管理\",\"unicode\":\"&#xee85;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"支付\"],\"appFrontIcon\":\"cuIcon-copy\",\"buttons\":[\"查看\"],\"classname\":\"dingzhidingdan\",\"menu\":\"定制订单\",\"menuJump\":\"列表\",\"tableName\":\"dingzhidingdan\"}],\"fontClass\":\"icon-common15\",\"menu\":\"定制订单管理\",\"unicode\":\"&#xedfc;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-copy\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"classname\":\"dianpuhuodong\",\"menu\":\"店铺活动\",\"menuJump\":\"列表\",\"tableName\":\"dianpuhuodong\"}],\"fontClass\":\"icon-common2\",\"menu\":\"店铺活动管理\",\"unicode\":\"&#xeda4;\"}],\"frontMenu\":[{\"child\":[{\"appFrontIcon\":\"cuIcon-rank\",\"buttons\":[\"查看\",\"私信\"],\"classname\":\"dongmanshangpin\",\"fontClass\":\"icon-common16\",\"menu\":\"动漫商品\",\"menuJump\":\"列表\",\"tableName\":\"dongmanshangpin\",\"unicode\":\"&#xedfd;\"}],\"fontClass\":\"icon-common16\",\"menu\":\"动漫商品\",\"unicode\":\"&#xedfd;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-camera\",\"buttons\":[\"查看\",\"定制周边\"],\"classname\":\"zhoubiandingzhi\",\"fontClass\":\"icon-common17\",\"menu\":\"周边定制\",\"menuJump\":\"列表\",\"tableName\":\"zhoubiandingzhi\",\"unicode\":\"&#xedfe;\"}],\"fontClass\":\"icon-common17\",\"menu\":\"周边定制\",\"unicode\":\"&#xedfe;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-flashlightopen\",\"buttons\":[\"查看\"],\"classname\":\"dianpuhuodong\",\"fontClass\":\"icon-common45\",\"menu\":\"店铺活动\",\"menuJump\":\"列表\",\"tableName\":\"dianpuhuodong\",\"unicode\":\"&#xef3b;\"}],\"fontClass\":\"icon-common45\",\"menu\":\"店铺活动\",\"unicode\":\"&#xef3b;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-addressbook\",\"buttons\":[\"查看\",\"报名\"],\"classname\":\"dongmanzhutihuodong\",\"fontClass\":\"icon-common23\",\"menu\":\"动漫主题活动\",\"menuJump\":\"列表\",\"tableName\":\"dongmanzhutihuodong\",\"unicode\":\"&#xee05;\"}],\"fontClass\":\"icon-common23\",\"menu\":\"动漫主题活动\",\"unicode\":\"&#xee05;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-rank\",\"buttons\":[\"查看\"],\"classname\":\"news\",\"fontClass\":\"icon-common15\",\"menu\":\"系统公告\",\"menuJump\":\"列表\",\"tableName\":\"news\",\"unicode\":\"&#xedfc;\"}],\"fontClass\":\"icon-common15\",\"menu\":\"系统公告\",\"unicode\":\"&#xedfc;\"}],\"hasBackLogin\":\"是\",\"hasBackRegister\":\"是\",\"hasFrontLogin\":\"否\",\"hasFrontRegister\":\"否\",\"pathName\":\"shangjia\",\"roleName\":\"商家\",\"tableName\":\"shangjia\"},{\"backMenu\":[{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-form\",\"buttons\":[\"查看\",\"修改\",\"删除\"],\"classname\":\"coupon\",\"menu\":\"优惠券\",\"menuJump\":\"列表\",\"tableName\":\"coupon\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"查看评论\",\"私信\"],\"appFrontIcon\":\"cuIcon-qrcode\",\"buttons\":[\"查看\",\"修改\",\"删除\",\"审核\",\"查看评论\",\"私信\"],\"classname\":\"dongmanshangpin\",\"menu\":\"动漫商品\",\"menuJump\":\"列表\",\"tableName\":\"dongmanshangpin\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-circle\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"classname\":\"shangpinleixing\",\"menu\":\"商品类型\",\"menuJump\":\"列表\",\"tableName\":\"shangpinleixing\"}],\"fontClass\":\"icon-common50\",\"menu\":\"动漫商品管理\",\"unicode\":\"&#xef96;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"日销量\",\"月销量\",\"日销额\",\"月销额\",\"品销量\",\"导出\",\"首页总数\",\"首页统计\"],\"appFrontIcon\":\"cuIcon-wenzi\",\"buttons\":[\"查看\",\"修改\",\"删除\",\"审核\",\"日销量\",\"月销量\",\"日销额\",\"月销额\",\"品销量\",\"导出\",\"首页总数\",\"首页统计\"],\"menu\":\"商品订单\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"日销量\",\"月销量\",\"日销额\",\"月销额\",\"品销量\",\"导出\",\"首页总数\",\"首页统计\"],\"appFrontIcon\":\"cuIcon-wenzi\",\"buttons\":[\"查看\",\"修改\",\"删除\"],\"menu\":\"未支付订单\",\"menuJump\":\"未支付\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"日销量\",\"月销量\",\"日销额\",\"月销额\",\"品销量\",\"导出\",\"首页总数\",\"首页统计\",\"发货\",\"物流\",\"核销\"],\"appFrontIcon\":\"cuIcon-wenzi\",\"buttons\":[\"查看\",\"修改\",\"删除\",\"物流\"],\"menu\":\"已支付订单\",\"menuJump\":\"已支付\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"日销量\",\"月销量\",\"日销额\",\"月销额\",\"品销量\",\"导出\",\"首页总数\",\"首页统计\",\"物流\"],\"appFrontIcon\":\"cuIcon-wenzi\",\"buttons\":[\"查看\",\"修改\",\"删除\",\"物流\",\"审核\"],\"menu\":\"已完成订单\",\"menuJump\":\"已完成\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"日销量\",\"月销量\",\"日销额\",\"月销额\",\"品销量\",\"导出\",\"首页总数\",\"首页统计\"],\"appFrontIcon\":\"cuIcon-wenzi\",\"buttons\":[\"查看\",\"修改\",\"删除\"],\"menu\":\"已取消订单\",\"menuJump\":\"已取消\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"日销量\",\"月销量\",\"日销额\",\"月销额\",\"品销量\",\"导出\",\"首页总数\",\"首页统计\",\"物流\"],\"appFrontIcon\":\"cuIcon-wenzi\",\"buttons\":[\"查看\",\"修改\",\"删除\",\"物流\"],\"menu\":\"已退款订单\",\"menuJump\":\"已退款\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"日销量\",\"月销量\",\"日销额\",\"月销额\",\"品销量\",\"导出\",\"首页总数\",\"首页统计\",\"确认收货\",\"物流\"],\"appFrontIcon\":\"cuIcon-wenzi\",\"buttons\":[\"查看\",\"修改\",\"删除\",\"物流\"],\"menu\":\"已发货订单\",\"menuJump\":\"已发货\",\"tableName\":\"orders\"}],\"fontClass\":\"icon-common19\",\"menu\":\"订单管理\",\"unicode\":\"&#xee00;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"定制周边\"],\"appFrontIcon\":\"cuIcon-rank\",\"buttons\":[\"查看\",\"修改\",\"删除\",\"定制周边\"],\"classname\":\"zhoubiandingzhi\",\"menu\":\"周边定制\",\"menuJump\":\"列表\",\"tableName\":\"zhoubiandingzhi\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-attentionfavor\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"classname\":\"zhoubianleixing\",\"menu\":\"周边类型\",\"menuJump\":\"列表\",\"tableName\":\"zhoubianleixing\"}],\"fontClass\":\"icon-common34\",\"menu\":\"周边定制管理\",\"unicode\":\"&#xee85;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"支付\"],\"appFrontIcon\":\"cuIcon-copy\",\"buttons\":[\"查看\",\"修改\",\"删除\"],\"classname\":\"dingzhidingdan\",\"menu\":\"定制订单\",\"menuJump\":\"列表\",\"tableName\":\"dingzhidingdan\"}],\"fontClass\":\"icon-common15\",\"menu\":\"定制订单管理\",\"unicode\":\"&#xedfc;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-copy\",\"buttons\":[\"查看\",\"修改\",\"删除\"],\"classname\":\"dianpuhuodong\",\"menu\":\"店铺活动\",\"menuJump\":\"列表\",\"tableName\":\"dianpuhuodong\"}],\"fontClass\":\"icon-common2\",\"menu\":\"店铺活动管理\",\"unicode\":\"&#xeda4;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"报名\"],\"appFrontIcon\":\"cuIcon-wenzi\",\"buttons\":[\"查看\",\"修改\",\"删除\",\"新增\"],\"classname\":\"dongmanzhutihuodong\",\"menu\":\"动漫主题活动\",\"menuJump\":\"列表\",\"tableName\":\"dongmanzhutihuodong\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-album\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"classname\":\"huodongleixing\",\"menu\":\"活动类型\",\"menuJump\":\"列表\",\"tableName\":\"huodongleixing\"}],\"fontClass\":\"icon-common28\",\"menu\":\"动漫主题活动管理\",\"unicode\":\"&#xee2d;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-circle\",\"buttons\":[\"查看\",\"修改\",\"删除\"],\"classname\":\"huodongbaoming\",\"menu\":\"活动报名\",\"menuJump\":\"列表\",\"tableName\":\"huodongbaoming\"}],\"fontClass\":\"icon-common10\",\"menu\":\"活动报名管理\",\"unicode\":\"&#xedd1;\"},{\"child\":[{\"allButtons\":[\"菜单管理\"],\"appFrontIcon\":\"cuIcon-medal\",\"buttons\":[\"菜单管理\"],\"classname\":\"menu\",\"menu\":\"菜单\",\"menuJump\":\"列表\",\"tableName\":\"menu\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-medal\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"classname\":\"config\",\"menu\":\"轮播图\",\"menuJump\":\"列表\",\"tableName\":\"config\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-circle\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"classname\":\"users\",\"menu\":\"管理员\",\"menuJump\":\"列表\",\"tableName\":\"users\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-newshot\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"classname\":\"news\",\"menu\":\"系统公告\",\"menuJump\":\"列表\",\"tableName\":\"news\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-wenzi\",\"buttons\":[\"查看\"],\"classname\":\"syslog\",\"menu\":\"操作日志\",\"menuJump\":\"列表\",\"tableName\":\"syslog\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"私信\"],\"appFrontIcon\":\"cuIcon-shop\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"classname\":\"yonghu\",\"menu\":\"用户\",\"menuJump\":\"列表\",\"tableName\":\"yonghu\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"私信\"],\"appFrontIcon\":\"cuIcon-vipcard\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\"],\"classname\":\"shangjia\",\"menu\":\"商家\",\"menuJump\":\"列表\",\"tableName\":\"shangjia\"}],\"fontClass\":\"icon-common50\",\"menu\":\"菜单管理\",\"unicode\":\"&#xef96;\"}],\"frontMenu\":[{\"child\":[{\"appFrontIcon\":\"cuIcon-rank\",\"buttons\":[\"查看\",\"私信\"],\"classname\":\"dongmanshangpin\",\"fontClass\":\"icon-common16\",\"menu\":\"动漫商品\",\"menuJump\":\"列表\",\"tableName\":\"dongmanshangpin\",\"unicode\":\"&#xedfd;\"}],\"fontClass\":\"icon-common16\",\"menu\":\"动漫商品\",\"unicode\":\"&#xedfd;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-camera\",\"buttons\":[\"查看\",\"定制周边\"],\"classname\":\"zhoubiandingzhi\",\"fontClass\":\"icon-common17\",\"menu\":\"周边定制\",\"menuJump\":\"列表\",\"tableName\":\"zhoubiandingzhi\",\"unicode\":\"&#xedfe;\"}],\"fontClass\":\"icon-common17\",\"menu\":\"周边定制\",\"unicode\":\"&#xedfe;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-flashlightopen\",\"buttons\":[\"查看\"],\"classname\":\"dianpuhuodong\",\"fontClass\":\"icon-common45\",\"menu\":\"店铺活动\",\"menuJump\":\"列表\",\"tableName\":\"dianpuhuodong\",\"unicode\":\"&#xef3b;\"}],\"fontClass\":\"icon-common45\",\"menu\":\"店铺活动\",\"unicode\":\"&#xef3b;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-addressbook\",\"buttons\":[\"查看\",\"报名\"],\"classname\":\"dongmanzhutihuodong\",\"fontClass\":\"icon-common23\",\"menu\":\"动漫主题活动\",\"menuJump\":\"列表\",\"tableName\":\"dongmanzhutihuodong\",\"unicode\":\"&#xee05;\"}],\"fontClass\":\"icon-common23\",\"menu\":\"动漫主题活动\",\"unicode\":\"&#xee05;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-rank\",\"buttons\":[\"查看\"],\"classname\":\"news\",\"fontClass\":\"icon-common15\",\"menu\":\"系统公告\",\"menuJump\":\"列表\",\"tableName\":\"news\",\"unicode\":\"&#xedfc;\"}],\"fontClass\":\"icon-common15\",\"menu\":\"系统公告\",\"unicode\":\"&#xedfc;\"}],\"hasBackLogin\":\"是\",\"hasBackRegister\":\"否\",\"hasFrontLogin\":\"否\",\"hasFrontRegister\":\"否\",\"pathName\":\"users\",\"roleName\":\"管理员\",\"tableName\":\"users\"}]');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_coupon`
--

DROP TABLE IF EXISTS `my_coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_coupon` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `coupon_id` bigint(20) NOT NULL COMMENT '优惠券id',
  `coupon_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '优惠券名称',
  `coupon_number` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '券编号',
  `coupon_type` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '优惠券类型',
  `full_amount` double DEFAULT '0' COMMENT '满额',
  `discount_amount` double DEFAULT '0' COMMENT '优惠额',
  `effect_time` datetime DEFAULT NULL COMMENT '生效时间',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
  `remark` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `status` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '使用状态',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `shangjiazhanghao` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商户名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='我的优惠券';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_coupon`
--

LOCK TABLES `my_coupon` WRITE;
/*!40000 ALTER TABLE `my_coupon` DISABLE KEYS */;
INSERT INTO `my_coupon` VALUES (1,'2025-12-15 09:24:34',1,'优惠券名称1','券编号1','满减券',1,1,'2025-12-15 17:24:34','2025-12-15 17:24:34','备注1','可使用',1,'商户名称1'),(2,'2025-12-15 09:24:34',2,'优惠券名称2','券编号2','满减券',2,2,'2025-12-15 17:24:34','2025-12-15 17:24:34','备注2','可使用',2,'商户名称2'),(3,'2025-12-15 09:24:34',3,'优惠券名称3','券编号3','满减券',3,3,'2025-12-15 17:24:34','2025-12-15 17:24:34','备注3','可使用',3,'商户名称3'),(4,'2025-12-15 09:24:34',4,'优惠券名称4','券编号4','满减券',4,4,'2025-12-15 17:24:34','2025-12-15 17:24:34','备注4','可使用',4,'商户名称4'),(5,'2025-12-15 09:24:34',5,'优惠券名称5','券编号5','满减券',5,5,'2025-12-15 17:24:34','2025-12-15 17:24:34','备注5','可使用',5,'商户名称5'),(6,'2025-12-15 09:24:34',6,'优惠券名称6','券编号6','满减券',6,6,'2025-12-15 17:24:34','2025-12-15 17:24:34','备注6','可使用',6,'商户名称6'),(7,'2025-12-15 09:24:34',7,'优惠券名称7','券编号7','满减券',7,7,'2025-12-15 17:24:34','2025-12-15 17:24:34','备注7','可使用',7,'商户名称7'),(8,'2025-12-15 09:24:34',8,'优惠券名称8','券编号8','满减券',8,8,'2025-12-15 17:24:34','2025-12-15 17:24:34','备注8','可使用',8,'商户名称8'),(9,'2025-12-15 09:24:34',9,'优惠券名称9','券编号9','满减券',9,9,'2025-12-15 17:24:34','2025-12-15 17:24:34','备注9','可使用',9,'商户名称9'),(10,'2025-12-15 09:24:34',10,'优惠券名称10','券编号10','满减券',10,10,'2025-12-15 17:24:34','2025-12-15 17:24:34','备注10','可使用',10,'商户名称10');
/*!40000 ALTER TABLE `my_coupon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `title` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题',
  `introduction` longtext COLLATE utf8mb4_unicode_ci COMMENT '简介',
  `picture` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '图片',
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统公告';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` VALUES (1,'2025-12-15 09:24:34','《夏目友人帐》猫咪老师抱枕','森野小憩・抱枕被二合一','file/news_《夏目友人帐》猫咪老师抱枕1.jpg,file/news_《夏目友人帐》猫咪老师抱枕2.jpg,file/news_《夏目友人帐》猫咪老师抱枕3.jpg','猫咪老师圆滚滚形象水晶绒面料亲肤透气填充均匀不易变形'),(2,'2025-12-15 09:24:34','《银魂》伊丽莎白玩偶','万事屋闲躺・多功能抱枕玩偶','file/news_《银魂》伊丽莎白玩偶1.jpg,file/news_《银魂》伊丽莎白玩偶2.jpg,file/news_《银魂》伊丽莎白玩偶3.jpg','伊丽莎白呆萌形象毛绒柔软填充饱满手感好适合抱睡或装饰'),(3,'2025-12-15 09:24:34','《咒术回战》五条悟眼罩','六眼咒力封印','file/news_《咒术回战》五条悟眼罩1.jpg,file/news_《咒术回战》五条悟眼罩2.jpg,file/news_《咒术回战》五条悟眼罩3.jpg','还原五条悟标志性黑色眼罩弹性适中佩戴舒适可日常使用或cosplay'),(4,'2025-12-15 09:24:34','《海贼王》罗宾同款耳环','花花果实・立体浮雕潮流耳环','file/news_《海贼王》罗宾同款耳环1.jpg,file/news_《海贼王》罗宾同款耳环2.jpg,file/news_《海贼王》罗宾同款耳环3.jpg','还原罗宾佩戴的耳环款式合金材质不易过敏水钻闪耀提升整体搭配感'),(5,'2025-12-15 09:24:34','《火影忍者》晓组织披风','赤云秘印・原版复刻典藏披风','file/news_《火影忍者》晓组织披风1.jpg,file/news_《火影忍者》晓组织披风2.jpg,file/news_《火影忍者》晓组织披风3.jpg','晓组织红色披风设计带黑色祥云图案面料垂顺有质感适合cosplay或装饰'),(6,'2025-12-15 09:24:34','《JOJO的奇妙冒险》替身使者贴纸','星尘斗士・时停闪卡典藏','file/news_《JOJO的奇妙冒险》替身使者贴纸1.jpg,file/news_《JOJO的奇妙冒险》替身使者贴纸2.jpg,file/news_《JOJO的奇妙冒险》替身使者贴纸3.jpg','包含多种替身使者图案防水防刮可贴在手机笔记本等物品上'),(7,'2025-12-15 09:24:34','《海贼王》路飞草帽','新世界冒险・机能风遮阳草帽','file/news_《海贼王》路飞草帽1.jpg,file/news_《海贼王》路飞草帽2.jpg,file/news_《海贼王》路飞草帽3.jpg','还原路飞标志性草帽草编材质轻便棉布内衬舒适可日常佩戴或cosplay'),(8,'2025-12-15 09:24:34','《初音未来》洛天依联名马克杯','双声共鸣・渐变釉彩马克杯','file/news_《初音未来》洛天依联名马克杯1.jpg,file/news_《初音未来》洛天依联名马克杯2.jpg,file/news_《初音未来》洛天依联名马克杯3.jpg','杯身印初音与洛天依联名图案陶瓷材质耐高温易清洗适合日常使用'),(9,'2025-12-15 09:24:34','《海贼王》万里阳光号模型','伟大的船收藏系列','file/news_《海贼王》万里阳光号模型1.jpg,file/news_《海贼王》万里阳光号模型2.jpg,file/news_《海贼王》万里阳光号模型3.jpg','还原万里阳光号外观结构含可拆卸部件需自行拼装锻炼动手能力'),(10,'2025-12-15 09:24:34','《鬼灭之刃》日轮刀挂件','九柱共鸣・日轮刀鍔复刻挂件套装','file/news_《鬼灭之刃》日轮刀挂件1.jpg,file/news_《鬼灭之刃》日轮刀挂件2.jpg,file/news_《鬼灭之刃》日轮刀挂件3.jpg','日轮刀缩小版造型金属刀身塑料刀柄细节精致可挂在背包或钥匙上');
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `orderid` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '订单编号',
  `tablename` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT 'dongmanshangpin' COMMENT '商品表名',
  `goodid` bigint(20) NOT NULL COMMENT '商品id',
  `goodname` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品名称',
  `picture` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '图片',
  `buynumber` int(11) DEFAULT NULL COMMENT '购买数量',
  `price` double DEFAULT NULL COMMENT '单价',
  `discountprice` double DEFAULT NULL COMMENT '折扣价',
  `total` double DEFAULT NULL COMMENT '总价',
  `discounttotal` double DEFAULT NULL COMMENT '折扣总价格',
  `type` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '支付类型',
  `status` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '订单状态',
  `return_reason` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '退货原因',
  `address` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '地址',
  `tel` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
  `consignee` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收货人',
  `remark` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `logistics` longtext COLLATE utf8mb4_unicode_ci COMMENT '物流',
  `role` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户角色',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `sfsh` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否审核',
  `shhf` longtext COLLATE utf8mb4_unicode_ci COMMENT '回复内容',
  `longitude` double DEFAULT NULL COMMENT '经度',
  `latitude` double DEFAULT NULL COMMENT '纬度',
  `fulladdress` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '地址',
  `shangjiazhanghao` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商户名称',
  `coupon_number` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '券编号',
  `discount_amount` double DEFAULT '0' COMMENT '优惠额',
  `order_no` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '统一订单编号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `orderid` (`orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品订单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recharge_record`
--

DROP TABLE IF EXISTS `recharge_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recharge_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `username` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `role` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色',
  `amount` double NOT NULL COMMENT '充值金额',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='充值记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recharge_record`
--

LOCK TABLES `recharge_record` WRITE;
/*!40000 ALTER TABLE `recharge_record` DISABLE KEYS */;
INSERT INTO `recharge_record` VALUES (1,'2025-12-15 09:24:34','用户名1','角色1',1,1),(2,'2025-12-15 09:24:34','用户名2','角色2',2,2),(3,'2025-12-15 09:24:34','用户名3','角色3',3,3),(4,'2025-12-15 09:24:34','用户名4','角色4',4,4),(5,'2025-12-15 09:24:34','用户名5','角色5',5,5),(6,'2025-12-15 09:24:34','用户名6','角色6',6,6),(7,'2025-12-15 09:24:34','用户名7','角色7',7,7),(8,'2025-12-15 09:24:34','用户名8','角色8',8,8),(9,'2025-12-15 09:24:34','用户名9','角色9',9,9),(10,'2025-12-15 09:24:34','用户名10','角色10',10,10);
/*!40000 ALTER TABLE `recharge_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shangjia`
--

DROP TABLE IF EXISTS `shangjia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shangjia` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `shangjiazhanghao` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商家账号',
  `shangjiamima` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商家密码',
  `shangjiamingcheng` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商家名称',
  `touxiang` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '头像',
  `youxiang` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮箱',
  `lianxifangshi` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '联系方式',
  `shenfenzheng` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '身份证',
  `yingyezizhi` longtext COLLATE utf8mb4_unicode_ci COMMENT '营业资质',
  `sfsh` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '待审核' COMMENT '是否审核',
  `shhf` longtext COLLATE utf8mb4_unicode_ci COMMENT '回复内容',
  `zhuceshijian` datetime DEFAULT NULL COMMENT '注册时间',
  `max_password_wrong` int(11) NOT NULL DEFAULT '-1' COMMENT '最大密码输错次数',
  `is_locked` int(11) NOT NULL DEFAULT '0' COMMENT '用户锁定状态',
  `longitude` double DEFAULT NULL COMMENT '经度',
  `latitude` double DEFAULT NULL COMMENT '纬度',
  `fulladdress` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '地址',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shangjiazhanghao` (`shangjiazhanghao`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商家';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shangjia`
--

LOCK TABLES `shangjia` WRITE;
/*!40000 ALTER TABLE `shangjia` DISABLE KEYS */;
INSERT INTO `shangjia` VALUES (71,'2025-12-15 09:24:34','商家账号1','123456','商家名称1','file/shangjiaTouxiang1.jpg','102020001@qq.com','19819881111','441622200101010001','','是','','2025-12-15 17:24:34',1,0,1,1,'宇宙银河系地球1号'),(72,'2025-12-15 09:24:34','商家账号2','123456','商家名称2','file/shangjiaTouxiang2.jpg','102020002@qq.com','19819881112','441622200202020002','','是','','2025-12-15 17:24:34',2,0,2,2,'宇宙银河系地球2号'),(73,'2025-12-15 09:24:34','商家账号3','123456','商家名称3','file/shangjiaTouxiang3.jpg','102020003@qq.com','19819881113','441622200303030003','','是','','2025-12-15 17:24:34',3,0,3,3,'宇宙银河系地球3号'),(74,'2025-12-15 09:24:34','商家账号4','123456','商家名称4','file/shangjiaTouxiang4.jpg','102020004@qq.com','19819881114','441622200404040004','','是','','2025-12-15 17:24:34',4,0,4,4,'宇宙银河系地球4号'),(75,'2025-12-15 09:24:34','商家账号5','123456','商家名称5','file/shangjiaTouxiang5.jpg','102020005@qq.com','19819881115','441622200505050005','','是','','2025-12-15 17:24:34',5,0,5,5,'宇宙银河系地球5号'),(76,'2025-12-15 09:24:34','商家账号6','123456','商家名称6','file/shangjiaTouxiang6.jpg','102020006@qq.com','19819881116','441622200606060006','','是','','2025-12-15 17:24:34',6,0,6,6,'宇宙银河系地球6号'),(77,'2025-12-15 09:24:34','商家账号7','123456','商家名称7','file/shangjiaTouxiang7.jpg','102020007@qq.com','19819881117','441622200707070007','','是','','2025-12-15 17:24:34',7,0,7,7,'宇宙银河系地球7号'),(78,'2025-12-15 09:24:34','商家账号8','123456','商家名称8','file/shangjiaTouxiang8.jpg','102020008@qq.com','19819881118','441622200808080008','','是','','2025-12-15 17:24:34',8,0,8,8,'宇宙银河系地球8号'),(79,'2025-12-15 09:24:34','商家账号9','123456','商家名称9','file/shangjiaTouxiang9.jpg','102020009@qq.com','19819881119','441622200909090009','','是','','2025-12-15 17:24:34',9,0,9,9,'宇宙银河系地球9号'),(80,'2025-12-15 09:24:34','商家账号10','123456','商家名称10','file/shangjiaTouxiang10.jpg','1020200010@qq.com','198198811110','4416222001001001000010','','是','','2025-12-15 17:24:34',10,0,10,10,'宇宙银河系地球10号');
/*!40000 ALTER TABLE `shangjia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shangpinleixing`
--

DROP TABLE IF EXISTS `shangpinleixing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shangpinleixing` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `shangpinleixing` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品类型',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shangpinleixing` (`shangpinleixing`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品类型';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shangpinleixing`
--

LOCK TABLES `shangpinleixing` WRITE;
/*!40000 ALTER TABLE `shangpinleixing` DISABLE KEYS */;
INSERT INTO `shangpinleixing` VALUES (1,'2025-12-15 09:24:35','抱枕'),(2,'2025-12-15 09:24:35','毛绒玩具'),(3,'2025-12-15 09:24:35','配饰'),(4,'2025-12-15 09:24:35','服装'),(5,'2025-12-15 09:24:35','贴纸'),(6,'2025-12-15 09:24:35','餐具'),(7,'2025-12-15 09:24:35','拼装模型'),(8,'2025-12-15 09:24:35','挂件'),(9,'2025-12-15 09:24:35','商品类型9'),(10,'2025-12-15 09:24:35','商品类型10');
/*!40000 ALTER TABLE `shangpinleixing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storeup`
--

DROP TABLE IF EXISTS `storeup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `storeup` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `refid` bigint(20) DEFAULT NULL COMMENT 'refid',
  `tablename` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '表名',
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `picture` longtext COLLATE utf8mb4_unicode_ci COMMENT '图片',
  `type` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '1' COMMENT '类型(1:收藏,21:赞,22:踩,31:竞拍参与,41:关注)',
  `inteltype` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '推荐类型',
  `remark` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='我的收藏';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storeup`
--

LOCK TABLES `storeup` WRITE;
/*!40000 ALTER TABLE `storeup` DISABLE KEYS */;
/*!40000 ALTER TABLE `storeup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `syslog`
--

DROP TABLE IF EXISTS `syslog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `syslog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `username` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `operation` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户操作',
  `method` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '请求方法',
  `params` longtext COLLATE utf8mb4_unicode_ci COMMENT '请求参数',
  `time` bigint(20) DEFAULT NULL COMMENT '请求时长(毫秒)',
  `ip` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ip地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='操作日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `syslog`
--

LOCK TABLES `syslog` WRITE;
/*!40000 ALTER TABLE `syslog` DISABLE KEYS */;
/*!40000 ALTER TABLE `syslog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token`
--

DROP TABLE IF EXISTS `token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `token` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `tablename` varchar(100) DEFAULT NULL COMMENT '表名',
  `role` varchar(100) DEFAULT NULL COMMENT '角色',
  `token` varchar(200) NOT NULL COMMENT '密码',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `expiratedtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '过期时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='token表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
INSERT INTO `token` VALUES (1,70,'用户账号10','yonghu','用户','jqd1gn74kzohewny4bkrj18avbcyj6ln','2025-12-15 09:26:16','2025-12-15 10:26:16');
/*!40000 ALTER TABLE `token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `username` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `role` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '管理员' COMMENT '角色',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理员';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'2025-12-15 09:24:35','admin','admin','管理员');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `yonghu`
--

DROP TABLE IF EXISTS `yonghu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yonghu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `yonghuzhanghao` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户账号',
  `mima` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `nicheng` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '昵称',
  `xingbie` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '性别',
  `touxiang` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '头像',
  `youxiang` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮箱',
  `shouji` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '手机',
  `shenfenzheng` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '身份证',
  `zhuceshijian` datetime DEFAULT NULL COMMENT '注册时间',
  `max_password_wrong` int(11) NOT NULL DEFAULT '1' COMMENT '最大密码输错次数',
  `is_locked` int(11) NOT NULL DEFAULT '0' COMMENT '用户锁定状态',
  `money` double DEFAULT '0' COMMENT '余额',
  PRIMARY KEY (`id`),
  UNIQUE KEY `yonghuzhanghao` (`yonghuzhanghao`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yonghu`
--

LOCK TABLES `yonghu` WRITE;
/*!40000 ALTER TABLE `yonghu` DISABLE KEYS */;
INSERT INTO `yonghu` VALUES (61,'2025-12-15 09:24:34','用户账号1','123456','昵称1','男','file/yonghuTouxiang1.jpg','102020001@qq.com','19819881111','441622200101010001','2025-12-15 17:24:34',1,0,200),(62,'2025-12-15 09:24:34','用户账号2','123456','昵称2','男','file/yonghuTouxiang2.jpg','102020002@qq.com','19819881112','441622200202020002','2025-12-15 17:24:34',2,0,200),(63,'2025-12-15 09:24:34','用户账号3','123456','昵称3','男','file/yonghuTouxiang3.jpg','102020003@qq.com','19819881113','441622200303030003','2025-12-15 17:24:34',3,0,200),(64,'2025-12-15 09:24:34','用户账号4','123456','昵称4','男','file/yonghuTouxiang4.jpg','102020004@qq.com','19819881114','441622200404040004','2025-12-15 17:24:34',4,0,200),(65,'2025-12-15 09:24:34','用户账号5','123456','昵称5','男','file/yonghuTouxiang5.jpg','102020005@qq.com','19819881115','441622200505050005','2025-12-15 17:24:34',5,0,200),(66,'2025-12-15 09:24:34','用户账号6','123456','昵称6','男','file/yonghuTouxiang6.jpg','102020006@qq.com','19819881116','441622200606060006','2025-12-15 17:24:34',6,0,200),(67,'2025-12-15 09:24:34','用户账号7','123456','昵称7','男','file/yonghuTouxiang7.jpg','102020007@qq.com','19819881117','441622200707070007','2025-12-15 17:24:34',7,0,200),(68,'2025-12-15 09:24:34','用户账号8','123456','昵称8','男','file/yonghuTouxiang8.jpg','102020008@qq.com','19819881118','441622200808080008','2025-12-15 17:24:34',8,0,200),(69,'2025-12-15 09:24:34','用户账号9','123456','昵称9','男','file/yonghuTouxiang9.jpg','102020009@qq.com','19819881119','441622200909090009','2025-12-15 17:24:34',9,0,200),(70,'2025-12-15 09:24:34','用户账号10','123456','昵称10','男','file/yonghuTouxiang10.jpg','1020200010@qq.com','198198811110','4416222001001001000010','2025-12-15 17:24:34',10,0,200);
/*!40000 ALTER TABLE `yonghu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zhoubiandingzhi`
--

DROP TABLE IF EXISTS `zhoubiandingzhi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zhoubiandingzhi` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `shangjiazhanghao` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商家账号',
  `shangjiamingcheng` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商家名称',
  `yangpinzhanshi` longtext COLLATE utf8mb4_unicode_ci COMMENT '样品展示',
  `dingzhijiage` double DEFAULT NULL COMMENT '定制价格',
  `dingzhijieshao` longtext COLLATE utf8mb4_unicode_ci COMMENT '定制介绍',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='周边定制';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zhoubiandingzhi`
--

LOCK TABLES `zhoubiandingzhi` WRITE;
/*!40000 ALTER TABLE `zhoubiandingzhi` DISABLE KEYS */;
INSERT INTO `zhoubiandingzhi` VALUES (1,'2025-12-15 09:24:34','商家账号1','商家名称1','file/zhoubiandingzhi_动漫主题徽章1.jpg,file/zhoubiandingzhi_动漫主题徽章2.jpg,file/zhoubiandingzhi_动漫主题徽章3.jpg',15,'金属质感强细节清晰百搭动漫周边配饰'),(2,'2025-12-15 09:24:34','商家账号2','商家名称2','file/zhoubiandingzhi_动漫角色T恤1.jpg,file/zhoubiandingzhi_动漫角色T恤2.jpg,file/zhoubiandingzhi_动漫角色T恤3.jpg',69,'纯棉面料透气亲肤版型宽松穿着舒适'),(3,'2025-12-15 09:24:34','商家账号3','商家名称3','file/zhoubiandingzhi_主题书签1.jpg,file/zhoubiandingzhi_主题书签2.jpg,file/zhoubiandingzhi_主题书签3.jpg',18,'黄铜材质不易氧化精致小巧阅读好伴侣'),(4,'2025-12-15 09:24:34','商家账号4','商家名称4','file/zhoubiandingzhi_动漫主题胸针1.jpg,file/zhoubiandingzhi_动漫主题胸针2.jpg,file/zhoubiandingzhi_动漫主题胸针3.jpg',13,'合金材质不易褪色百搭服饰配饰彰显个性'),(5,'2025-12-15 09:24:34','商家账号5','商家名称5','file/zhoubiandingzhi_Q版角色冰箱贴1.jpg,file/zhoubiandingzhi_Q版角色冰箱贴2.jpg,file/zhoubiandingzhi_Q版角色冰箱贴3.jpg',14,'磁性强劲不易掉落装饰冰箱增添趣味'),(6,'2025-12-15 09:24:34','商家账号6','商家名称6','file/zhoubiandingzhi_动漫场景拼图1.jpg,file/zhoubiandingzhi_动漫场景拼图2.jpg,file/zhoubiandingzhi_动漫场景拼图3.jpg',85,'纸质厚实图案清晰锻炼动手能力收藏佳品'),(7,'2025-12-15 09:24:34','商家账号7','商家名称7','file/zhoubiandingzhi_动漫主题帆布袋1.jpg,file/zhoubiandingzhi_动漫主题帆布袋2.jpg,file/zhoubiandingzhi_动漫主题帆布袋3.jpg',39,'环保材质结实耐用容量大日常通勤购物'),(8,'2025-12-15 09:24:34','商家账号8','商家名称8','file/zhoubiandingzhi_动漫场景明信片1.jpg,file/zhoubiandingzhi_动漫场景明信片2.jpg,file/zhoubiandingzhi_动漫场景明信片3.jpg',12,'卡纸厚实图案精美可收藏可邮寄传递心意'),(9,'2025-12-15 09:24:34','商家账号9','商家名称9','file/zhoubiandingzhi_动漫场景挂画1.jpg,file/zhoubiandingzhi_动漫场景挂画2.jpg,file/zhoubiandingzhi_动漫场景挂画3.jpg',129,'高清喷绘色彩持久悬挂美观装饰动漫空间'),(10,'2025-12-15 09:24:34','商家账号10','商家名称10','file/zhoubiandingzhi_主题文化衫1.jpg,file/zhoubiandingzhi_主题文化衫2.jpg,file/zhoubiandingzhi_主题文化衫3.jpg',59,'棉混纺面料不易起球版型修身穿着有型');
/*!40000 ALTER TABLE `zhoubiandingzhi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zhoubianleixing`
--

DROP TABLE IF EXISTS `zhoubianleixing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zhoubianleixing` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `zhoubianleixing` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '周边类型',
  PRIMARY KEY (`id`),
  UNIQUE KEY `zhoubianleixing` (`zhoubianleixing`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='周边类型';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zhoubianleixing`
--

LOCK TABLES `zhoubianleixing` WRITE;
/*!40000 ALTER TABLE `zhoubianleixing` DISABLE KEYS */;
INSERT INTO `zhoubianleixing` VALUES (1,'2025-12-15 09:24:34','徽章'),(2,'2025-12-15 09:24:34','T恤'),(3,'2025-12-15 09:24:34','书签'),(4,'2025-12-15 09:24:34','胸针'),(5,'2025-12-15 09:24:34','冰箱贴'),(6,'2025-12-15 09:24:34','拼图'),(7,'2025-12-15 09:24:34','帆布袋'),(8,'2025-12-15 09:24:34','明信片'),(9,'2025-12-15 09:24:34','挂画'),(10,'2025-12-15 09:24:34','文化衫');
/*!40000 ALTER TABLE `zhoubianleixing` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-16 17:55:11
