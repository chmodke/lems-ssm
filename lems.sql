/*
Navicat MySQL Data Transfer

Source Server         : kehao_mysql
Source Server Version : 50703
Source Host           : localhost:3306
Source Database       : lems

Target Server Type    : MYSQL
Target Server Version : 50703
File Encoding         : 65001

Date: 2017-05-10 22:25:42
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for equ_lab
-- ----------------------------
DROP TABLE IF EXISTS `equ_lab`;
CREATE TABLE `equ_lab` (
  `lid` char(32) NOT NULL COMMENT '实验室id',
  `eid` char(32) NOT NULL COMMENT '设备id',
  KEY `equ_lab_lib_lid` (`lid`) USING BTREE,
  KEY `equ_lab_equ_eid` (`eid`) USING BTREE,
  CONSTRAINT `equ_lab_equ_eid` FOREIGN KEY (`eid`) REFERENCES `s_equipment` (`eid`),
  CONSTRAINT `equ_lab_lib_lid` FOREIGN KEY (`lid`) REFERENCES `s_laboratory` (`lid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='设备所属实验室';

-- ----------------------------
-- Records of equ_lab
-- ----------------------------
INSERT INTO `equ_lab` VALUES ('0b1533555c0748b4a8e985f7b9e52897', '41c9f5d89408441485a0be5dd9fde61b');
INSERT INTO `equ_lab` VALUES ('0b1533555c0748b4a8e985f7b9e52897', '6c2e9cbd753b4431942dbe1ebd82dba3');
INSERT INTO `equ_lab` VALUES ('0b1533555c0748b4a8e985f7b9e52897', '98b7579ec813488083287bfdb62cdd67');
INSERT INTO `equ_lab` VALUES ('5370735eff1f4a25ba5b046baa873c3c', 'a7d5fe3f19cd4fd5a58e785c9cba7c5f');
INSERT INTO `equ_lab` VALUES ('5370735eff1f4a25ba5b046baa873c3c', '9999');
INSERT INTO `equ_lab` VALUES ('45b0084bc10d4dd4b78eb9bf0c5ce477', '6101e7eedf2544b186f6fead7bf677bc');
INSERT INTO `equ_lab` VALUES ('b91e4444c3f843e2b2be0276bd8b3265', '82f89ad15cd74461884acac5dbf12284');

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission` (
  `rid` int(9) NOT NULL,
  `pid` int(9) NOT NULL,
  KEY `role_perms_role_rid` (`rid`) USING BTREE,
  KEY `role_perms_perms_pid` (`pid`) USING BTREE,
  CONSTRAINT `role_perms_perms_pid` FOREIGN KEY (`pid`) REFERENCES `s_permission` (`pid`),
  CONSTRAINT `role_perms_role_rid` FOREIGN KEY (`rid`) REFERENCES `s_role` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='角色_权限表';

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES ('405230015', '539485519');
INSERT INTO `role_permission` VALUES ('405230015', '539485519');

-- ----------------------------
-- Table structure for s_equipment
-- ----------------------------
DROP TABLE IF EXISTS `s_equipment`;
CREATE TABLE `s_equipment` (
  `eid` char(32) NOT NULL COMMENT '系统id',
  `id` varchar(32) NOT NULL COMMENT '用户定义编号',
  `ename` varchar(32) DEFAULT NULL COMMENT '设备名称',
  `type` varchar(32) DEFAULT NULL COMMENT '设备类别',
  `addtime` datetime DEFAULT NULL COMMENT '添加时间',
  `status` int(2) DEFAULT NULL COMMENT '设备状态',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `pcid` char(32) DEFAULT NULL COMMENT '采购id',
  PRIMARY KEY (`eid`),
  KEY `equ_purc_eid` (`pcid`) USING BTREE,
  CONSTRAINT `equ_pur_pcid` FOREIGN KEY (`pcid`) REFERENCES `s_equ_purchase` (`pcid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='设备表';

-- ----------------------------
-- Records of s_equipment
-- ----------------------------
INSERT INTO `s_equipment` VALUES ('41c9f5d89408441485a0be5dd9fde61b', '0429-003', '0429', '003', '2017-04-30 19:44:01', '0', '12', '08695abe001e40759a202d47ef4f7431');
INSERT INTO `s_equipment` VALUES ('6101e7eedf2544b186f6fead7bf677bc', '0429-001', '0429', '001', '2017-04-30 17:13:42', '0', '采购日期实现测试', '4f5565971ad24b1cb933395d98c58a0d');
INSERT INTO `s_equipment` VALUES ('6c2e9cbd753b4431942dbe1ebd82dba3', '0429-003', '0429', '003', '2017-04-30 19:45:21', '0', '12', 'ea40ef0930fa45e3becfe545902dc2e4');
INSERT INTO `s_equipment` VALUES ('6d0918be1a964d07948495feef08fbd2', '631-001', 'web服务器', '服务器', '2017-04-30 16:49:59', '0', '计算机', '495277f85336499cb646b68de9a91e22');
INSERT INTO `s_equipment` VALUES ('82f89ad15cd74461884acac5dbf12284', 'xxxy_zz01', '计算机', 'zz01', '2017-04-29 00:04:18', '1', '计算机', '8b880fc5597f4d329364ed680ceb826e');
INSERT INTO `s_equipment` VALUES ('98b7579ec813488083287bfdb62cdd67', '531-001', '星研硬件实验箱', 'Y001', '2017-04-27 18:41:56', '0', '星研硬件实验箱', '66de736c5743481980b81a96b16df497');
INSERT INTO `s_equipment` VALUES ('9999', '9999', '电脑', '电脑', '2017-04-25 09:32:11', '0', '电脑', '9999');
INSERT INTO `s_equipment` VALUES ('a7d5fe3f19cd4fd5a58e785c9cba7c5f', '631-002', '数据库服务器', '123', '2017-04-27 15:55:10', '0', '数据库服务器', '8050d7fc49d14468a6cd0fae7f9472d8');
INSERT INTO `s_equipment` VALUES ('cc4e2015519f4dd68d7ebadf4e37283e', '0429-002', '0429', '002', '2017-04-30 19:42:40', '0', '1', '72d7913511ca49bb84d41dafec02236d');
INSERT INTO `s_equipment` VALUES ('d16bbc38a9a94f6a8ca1f82797463cfa', '631-001', 'web服务器', '服务器', '2017-04-27 15:20:08', '2', '计算机', '79e142a75ba3492ca528c390863f3b93');
INSERT INTO `s_equipment` VALUES ('de3fd36c5d0e4401a667dc93c70a637c', 'equ_001_001', '数据库服务器', 'eq_003', '2017-04-27 23:48:22', '2', '服务器', '3c469c21d49242f7a1e27c47346db097');

-- ----------------------------
-- Table structure for s_equ_break
-- ----------------------------
DROP TABLE IF EXISTS `s_equ_break`;
CREATE TABLE `s_equ_break` (
  `bid` char(32) NOT NULL COMMENT '故障事件id',
  `eid` char(32) NOT NULL COMMENT '故障设备id',
  `id` int(11) DEFAULT NULL COMMENT '自定义编号',
  `breason` varchar(500) DEFAULT NULL COMMENT '故障原因',
  `status` int(2) DEFAULT NULL COMMENT '处理状态',
  PRIMARY KEY (`bid`),
  KEY `break_equ_eid` (`eid`) USING BTREE,
  CONSTRAINT `break_equ_eid` FOREIGN KEY (`eid`) REFERENCES `s_equipment` (`eid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='设备故障表';

-- ----------------------------
-- Records of s_equ_break
-- ----------------------------
INSERT INTO `s_equ_break` VALUES ('9999', '9999', '9999', '电源', '1');

-- ----------------------------
-- Table structure for s_equ_purchase
-- ----------------------------
DROP TABLE IF EXISTS `s_equ_purchase`;
CREATE TABLE `s_equ_purchase` (
  `pcid` char(32) NOT NULL COMMENT '采购id',
  `uid` char(32) DEFAULT NULL COMMENT '采购员id',
  `pctime` datetime DEFAULT NULL COMMENT '采购时间',
  `price` double(16,3) DEFAULT '0.000' COMMENT '价格',
  PRIMARY KEY (`pcid`),
  KEY `purc_user_uid` (`uid`) USING BTREE,
  CONSTRAINT `purc_user_uid` FOREIGN KEY (`uid`) REFERENCES `s_user` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='设备采购表';

-- ----------------------------
-- Records of s_equ_purchase
-- ----------------------------
INSERT INTO `s_equ_purchase` VALUES ('08695abe001e40759a202d47ef4f7431', 'af7b3b6768c243f28aa2f62de9a98287', '2017-04-20 19:42:23', '123123123.120');
INSERT INTO `s_equ_purchase` VALUES ('3c469c21d49242f7a1e27c47346db097', 'be817b4d6b8743f5a1e26fd826b4f155', '2017-04-27 23:48:22', '8888.880');
INSERT INTO `s_equ_purchase` VALUES ('495277f85336499cb646b68de9a91e22', '16e3a3765d2a40b4917eb2cce7d372d4', '2017-04-30 16:49:58', '88888.800');
INSERT INTO `s_equ_purchase` VALUES ('4f5565971ad24b1cb933395d98c58a0d', '16e3a3765d2a40b4917eb2cce7d372d4', '2017-04-18 17:13:14', '8989.890');
INSERT INTO `s_equ_purchase` VALUES ('66de736c5743481980b81a96b16df497', '16e3a3765d2a40b4917eb2cce7d372d4', '2017-04-27 18:41:56', '899.990');
INSERT INTO `s_equ_purchase` VALUES ('72d7913511ca49bb84d41dafec02236d', 'af7b3b6768c243f28aa2f62de9a98287', '2017-04-20 19:42:23', '123.120');
INSERT INTO `s_equ_purchase` VALUES ('79e142a75ba3492ca528c390863f3b93', '16e3a3765d2a40b4917eb2cce7d372d4', null, '88888.800');
INSERT INTO `s_equ_purchase` VALUES ('8050d7fc49d14468a6cd0fae7f9472d8', '16e3a3765d2a40b4917eb2cce7d372d4', '2017-04-27 15:55:10', '8888.880');
INSERT INTO `s_equ_purchase` VALUES ('8b880fc5597f4d329364ed680ceb826e', 'af7b3b6768c243f28aa2f62de9a98287', '2017-04-29 00:04:18', '8888.880');
INSERT INTO `s_equ_purchase` VALUES ('9999', '9999', '2017-04-25 09:30:54', '9999.000');
INSERT INTO `s_equ_purchase` VALUES ('ea40ef0930fa45e3becfe545902dc2e4', 'af7b3b6768c243f28aa2f62de9a98287', '2017-04-20 19:42:23', '123456789123.120');

-- ----------------------------
-- Table structure for s_equ_schedule
-- ----------------------------
DROP TABLE IF EXISTS `s_equ_schedule`;
CREATE TABLE `s_equ_schedule` (
  `seid` char(32) NOT NULL COMMENT '设备日程id',
  `eid` char(32) NOT NULL COMMENT '设备id',
  `starttime` datetime DEFAULT NULL COMMENT '开始时间',
  `endtime` datetime DEFAULT NULL COMMENT '结束时间',
  `sname` varchar(32) DEFAULT NULL COMMENT '借用人姓名',
  PRIMARY KEY (`seid`),
  KEY `sch_equ_eid` (`eid`) USING BTREE,
  CONSTRAINT `sch_equ_eid` FOREIGN KEY (`eid`) REFERENCES `s_equipment` (`eid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='设备使用日程表';

-- ----------------------------
-- Records of s_equ_schedule
-- ----------------------------

-- ----------------------------
-- Table structure for s_laboratory
-- ----------------------------
DROP TABLE IF EXISTS `s_laboratory`;
CREATE TABLE `s_laboratory` (
  `lid` char(32) NOT NULL COMMENT '系统id',
  `id` varchar(32) NOT NULL COMMENT '自定义编号',
  `lname` varchar(32) DEFAULT NULL COMMENT '实验室名称',
  `lsize` int(4) DEFAULT '0' COMMENT '实验室容量',
  `addtime` datetime DEFAULT NULL COMMENT '添加时间',
  `status` int(2) DEFAULT '0' COMMENT '实验室状态',
  `type` varchar(32) DEFAULT NULL COMMENT '实验室类别',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `uid` char(32) DEFAULT NULL COMMENT '负责人id',
  `equcount` int(4) DEFAULT NULL COMMENT '实验室设备数量',
  PRIMARY KEY (`lid`),
  KEY `lab_user_uid` (`uid`) USING BTREE,
  CONSTRAINT `lab_user_uid` FOREIGN KEY (`uid`) REFERENCES `s_user` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='实验室表';

-- ----------------------------
-- Records of s_laboratory
-- ----------------------------
INSERT INTO `s_laboratory` VALUES ('0b1533555c0748b4a8e985f7b9e52897', '630', '630', '80', '2017-05-03 19:16:31', '0', '计算机软件', '软件', '16e3a3765d2a40b4917eb2cce7d372d4', '80');
INSERT INTO `s_laboratory` VALUES ('45b0084bc10d4dd4b78eb9bf0c5ce477', '9#629', '629', '80', '2017-04-27 09:02:29', '2', '计算机机房', '计算机软件机房', '9999', '80');
INSERT INTO `s_laboratory` VALUES ('5370735eff1f4a25ba5b046baa873c3c', 'zzzz', 'zzz', '111', '2017-05-03 19:43:31', '0', 'zzz', 'zzz', '16e3a3765d2a40b4917eb2cce7d372d4', '111');
INSERT INTO `s_laboratory` VALUES ('62440b72fab24af984f99ceb1681bf2d', 'zzz_zz', '软件实验室', '80', '2017-05-03 19:33:04', '1', '计算机', '软件实验室', 'af7b3b6768c243f28aa2f62de9a98287', '80');
INSERT INTO `s_laboratory` VALUES ('8bbfe4d37a094789a042fface14e8d20', 'wqe', 'qqqq', '21', '2017-05-03 19:39:34', '0', 'qqqq', 'qweqe', '16e3a3765d2a40b4917eb2cce7d372d4', '21');
INSERT INTO `s_laboratory` VALUES ('b91e4444c3f843e2b2be0276bd8b3265', '629', '计算机公共机房', '50', '2017-04-25 09:41:08', '2', '计算机', '计算机机房', '9999', '50');
INSERT INTO `s_laboratory` VALUES ('b96a1257cbee464aba8845b29dbbea1a', 'soft_001', '软件工程实验室', '80', '2017-04-27 23:49:18', '0', '软件工程', '软件工程', 'be817b4d6b8743f5a1e26fd826b4f155', '80');
INSERT INTO `s_laboratory` VALUES ('c75ff212a8c148e1b7587008ae2e2589', '555', '555', '50', '2017-05-08 11:21:34', '2', '传媒', '传媒', '16e3a3765d2a40b4917eb2cce7d372d4', '50');
INSERT INTO `s_laboratory` VALUES ('ijfnsalfhai4325g93r20t14h3iq9hfe', '320', '320', '6', '2017-05-08 11:24:25', '2', '办公室', '办公', '6e28f9a7da5d44d3bc5d7e0844b45eb5', '6');

-- ----------------------------
-- Table structure for s_lab_schedule
-- ----------------------------
DROP TABLE IF EXISTS `s_lab_schedule`;
CREATE TABLE `s_lab_schedule` (
  `slid` char(32) NOT NULL COMMENT '实验室使用日程id',
  `lid` char(32) NOT NULL COMMENT '实验室id',
  `starttime` datetime DEFAULT NULL COMMENT '开始时间',
  `endtime` datetime DEFAULT NULL COMMENT '结束时间',
  `sname` varchar(32) DEFAULT NULL COMMENT '借用人姓名',
  `stel` char(32) DEFAULT NULL COMMENT '预约人电话',
  PRIMARY KEY (`slid`),
  KEY `sch_lib_lid` (`lid`) USING BTREE,
  CONSTRAINT `sch_lib_lid` FOREIGN KEY (`lid`) REFERENCES `s_laboratory` (`lid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='实验室使用日程表';

-- ----------------------------
-- Records of s_lab_schedule
-- ----------------------------
INSERT INTO `s_lab_schedule` VALUES ('27f5c6c8d6944314b26f0e1e531c7e1c', 'c75ff212a8c148e1b7587008ae2e2589', '2017-05-11 20:51:22', '2017-05-12 20:51:24', 'test', '123');
INSERT INTO `s_lab_schedule` VALUES ('e498d68bc8f64008a547828d86931e2f', 'ijfnsalfhai4325g93r20t14h3iq9hfe', '2017-05-10 19:59:41', '2017-05-17 19:59:43', 'kehao', '123445');

-- ----------------------------
-- Table structure for s_permission
-- ----------------------------
DROP TABLE IF EXISTS `s_permission`;
CREATE TABLE `s_permission` (
  `pid` int(9) NOT NULL COMMENT '权限ID',
  `pname` varchar(30) DEFAULT NULL COMMENT '权限名称',
  `remark` varchar(100) DEFAULT NULL COMMENT '权限说明',
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='权限表';

-- ----------------------------
-- Records of s_permission
-- ----------------------------
INSERT INTO `s_permission` VALUES ('539485519', 'select_equ', '查询设备');

-- ----------------------------
-- Table structure for s_resources
-- ----------------------------
DROP TABLE IF EXISTS `s_resources`;
CREATE TABLE `s_resources` (
  `rsid` char(9) NOT NULL COMMENT '资源ID',
  `pid` int(9) NOT NULL COMMENT '所属权限ID',
  `rsname` varchar(30) DEFAULT NULL COMMENT '资源描述',
  `url` varchar(50) NOT NULL COMMENT '资源路径',
  `remark` varchar(100) DEFAULT NULL COMMENT '资源说明',
  PRIMARY KEY (`rsid`),
  KEY `perms_res_pid` (`pid`) USING BTREE,
  CONSTRAINT `perms_res_pid` FOREIGN KEY (`pid`) REFERENCES `s_permission` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='资源表';

-- ----------------------------
-- Records of s_resources
-- ----------------------------

-- ----------------------------
-- Table structure for s_role
-- ----------------------------
DROP TABLE IF EXISTS `s_role`;
CREATE TABLE `s_role` (
  `rid` int(9) NOT NULL COMMENT '角色ID',
  `rname` varchar(30) NOT NULL COMMENT '角色名称',
  `remark` varchar(100) DEFAULT NULL COMMENT '角色说明',
  PRIMARY KEY (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='角色表';

-- ----------------------------
-- Records of s_role
-- ----------------------------
INSERT INTO `s_role` VALUES ('66232668', '设备管理员', 'equ_manager');
INSERT INTO `s_role` VALUES ('376703787', '普通用户', 'stander');
INSERT INTO `s_role` VALUES ('405230015', '超级管理员', 'administrator');
INSERT INTO `s_role` VALUES ('669445435', '测试账户', '测试人员');

-- ----------------------------
-- Table structure for s_user
-- ----------------------------
DROP TABLE IF EXISTS `s_user`;
CREATE TABLE `s_user` (
  `uid` char(32) NOT NULL COMMENT '用户ID',
  `uname` varchar(24) NOT NULL COMMENT '账户登录名',
  `ture_name` varchar(12) NOT NULL COMMENT '账户真实姓名',
  `passwd` char(32) NOT NULL COMMENT '加密过的密码',
  `salt` char(6) NOT NULL COMMENT '加密用的盐',
  `office_address` varchar(30) DEFAULT NULL COMMENT '办公室地址',
  `office_phone` varchar(12) DEFAULT NULL COMMENT '办公室电话',
  `email` varchar(40) DEFAULT NULL COMMENT '邮箱，作为激活账户使用',
  `masterid` char(32) NOT NULL COMMENT '创建者ID',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `token` char(32) DEFAULT NULL COMMENT '登录认证',
  `status` int(2) DEFAULT '0' COMMENT '用户状态',
  PRIMARY KEY (`uid`),
  KEY `user_master_id` (`masterid`) USING BTREE,
  CONSTRAINT `user_master_id` FOREIGN KEY (`masterid`) REFERENCES `s_user` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户表';

-- ----------------------------
-- Records of s_user
-- ----------------------------
INSERT INTO `s_user` VALUES ('0e690bc74f354a0996942ee091709943', 'kehao003', 'kehao003', 'ILfXjzPgW073ICQUfhIhwA==', 'sqDUL6', null, null, 'kehao003@xx.com', '16e3a3765d2a40b4917eb2cce7d372d4', '2017-05-01 18:17:11', null, '0');
INSERT INTO `s_user` VALUES ('0ec092f59ead420ba6b3829ea4d4cfb8', 'test002', 'test002', 'LV/jqd7Y0ZJRDxdf4alnFQ==', 'FjeoK4', null, null, 'test002@xx.com', '9999', '2017-05-01 18:17:11', null, '0');
INSERT INTO `s_user` VALUES ('16e3a3765d2a40b4917eb2cce7d372d4', 'kehao', 'kehao', 'VCN6WdSBoDOKnmnzLvpgzA==', '5a2615', '火星', '111', 'kehao@lems.com', '9999', '2017-05-05 11:27:40', '6eb09774a4464c1280466ea20f3687e7', '0');
INSERT INTO `s_user` VALUES ('2caf84fa65c04963818da964ce10fc4b', 'test000', 'kehao', 'aMtnkqh+KcQGjfZoLftcuQ==', '0tzkmh', null, null, 'test001@xx.com', '9999', '2017-05-01 18:17:11', null, '0');
INSERT INTO `s_user` VALUES ('56c0b00dbceb4a54b065b0aa71bca526', 'user1', 'user', '6khXbzC+FmmXFpnAmtBclA==', '123456', '630', '111', 'xxx@xx.com', '9999', '2017-05-01 18:17:11', null, '0');
INSERT INTO `s_user` VALUES ('6e28f9a7da5d44d3bc5d7e0844b45eb5', '朱晨光', '朱晨光', 'mUuuLL580Y+CC97uHFrgDw==', 'wHsa7Q', null, null, 'zhuchenguang@xx.com', '16e3a3765d2a40b4917eb2cce7d372d4', '2017-05-01 18:17:11', 'd1c553fb2f8e43ddb4704f79f0de53ae', '0');
INSERT INTO `s_user` VALUES ('8f6e66694bc84d3299e3c5df0485e579', 'wangwu', '王五', '4BnJUfs9SArj08zgPZttBQ==', '5dXKjO', null, null, 'wangwu@lems.com', 'af7b3b6768c243f28aa2f62de9a98287', '2017-05-01 18:17:23', null, '1');
INSERT INTO `s_user` VALUES ('9999', 'admin', 'admin', '6khXbzC+FmmXFpnAmtBclA==', '123456', 'address', '110', 'admin@xx.com', '9999', '2017-05-05 11:40:53', '91934aa334ed40a2ad5fca4e35c5c7dg', '0');
INSERT INTO `s_user` VALUES ('9a0329eac5f444ee93e16aa00627489e', 'kehao004', 'kehao004', 'yQGL6sCpxi4Ox4SqbUUp2A==', 'fCOdm4', null, null, 'kehao004@xx.com', '16e3a3765d2a40b4917eb2cce7d372d4', '2017-05-01 18:17:11', null, '0');
INSERT INTO `s_user` VALUES ('9b5f8b00c8aa4c188cdc7bfb6502c14c', 'kehao006', 'kehao', 'CSb7RgQVgOa1n3auvKn5cw==', 'gUHu7h', null, null, 'kehao006@lems.com', '16e3a3765d2a40b4917eb2cce7d372d4', '2017-05-03 00:03:29', null, '1');
INSERT INTO `s_user` VALUES ('9eeaaf17b2894b4bb3767a25f0155ce4', 'test004', 'test', 'G8TP3AtVmjMdK3BAvtsPpA==', 'jcPoOg', null, null, 'test004@lems.com', '16e3a3765d2a40b4917eb2cce7d372d4', '2017-05-03 19:17:52', null, '0');
INSERT INTO `s_user` VALUES ('af7b3b6768c243f28aa2f62de9a98287', 'zhangsan', '张三', 'f339Fttx2MEhM5tqQl1Hdg==', 'hWQrtH', '极地', '130', 'zhangsan@xx.com', '9999', '2017-05-01 18:17:11', '4143a2b82ef1485296c29f62d0213a24', '0');
INSERT INTO `s_user` VALUES ('be817b4d6b8743f5a1e26fd826b4f155', 'lisi', '李四', 'VGdHapNb/xVEX8A+z52XIA==', '6bGysS', null, null, 'lisi@xx.com', '9999', '2017-05-03 00:03:29', '89177a25ecc04c658561c6d14d97f3e9', '1');
INSERT INTO `s_user` VALUES ('c8f7256f5fa34a1b9fac60ce0d29ed6e', 'test003', 'test003', 'Gqs2VjEmWBQY3hsmN6rSqA==', '3rkUnK', null, null, 'test003@xx.com', '9999', '2017-05-01 18:17:11', null, '0');
INSERT INTO `s_user` VALUES ('caa8e746ff7e4cbd9285a21f51d25f8e', 'kehao001', 'kehao001', 'baSjbI/kE6d9BsThmXaZCA==', 'QdGPfX', null, null, 'kehao001@xx.com', '16e3a3765d2a40b4917eb2cce7d372d4', '2017-05-01 18:17:11', null, '0');
INSERT INTO `s_user` VALUES ('d791da75a18c4877b31b3b97cdc195a7', 'kehao002', 'kehao002', 'VF59KSBxbVFrTDjOsrfGcQ==', 'AhtWFp', null, null, 'kehao002@xx.com', '16e3a3765d2a40b4917eb2cce7d372d4', '2017-05-01 18:17:11', '12bc61a3f9474a98877764c45f850ef4', '0');
INSERT INTO `s_user` VALUES ('fc489fc09af74f659380b994011ca2d3', 'kehao005', 'kehao005', 'unPZRRKCZ4ITXoqn0LPVQA==', 'Xie4op', null, null, 'kehao005@xx.com', '16e3a3765d2a40b4917eb2cce7d372d4', '2017-05-01 18:17:11', null, '0');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `uid` char(32) NOT NULL,
  `rid` int(9) NOT NULL,
  KEY `user_role_user_uid` (`uid`) USING BTREE,
  KEY `user_role_role_rid` (`rid`) USING BTREE,
  CONSTRAINT `user_role_role_rid` FOREIGN KEY (`rid`) REFERENCES `s_role` (`rid`),
  CONSTRAINT `user_role_user_uid` FOREIGN KEY (`uid`) REFERENCES `s_user` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户_角色表';

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('9999', '405230015');
INSERT INTO `user_role` VALUES ('16e3a3765d2a40b4917eb2cce7d372d4', '405230015');
INSERT INTO `user_role` VALUES ('af7b3b6768c243f28aa2f62de9a98287', '376703787');
INSERT INTO `user_role` VALUES ('6e28f9a7da5d44d3bc5d7e0844b45eb5', '376703787');
INSERT INTO `user_role` VALUES ('0e690bc74f354a0996942ee091709943', '376703787');
INSERT INTO `user_role` VALUES ('fc489fc09af74f659380b994011ca2d3', '66232668');
INSERT INTO `user_role` VALUES ('9b5f8b00c8aa4c188cdc7bfb6502c14c', '376703787');
INSERT INTO `user_role` VALUES ('9eeaaf17b2894b4bb3767a25f0155ce4', '669445435');
