/*
Navicat MySQL Data Transfer

Source Server         : root_mysql
Source Server Version : 50703
Source Host           : localhost:3306
Source Database       : lems

Target Server Type    : MYSQL
Target Server Version : 50703
File Encoding         : 65001

Date: 2017-05-14 20:35:26
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
INSERT INTO `equ_lab` VALUES ('90583c07c9e542ceacfec6a4f0def2b6', '1f31e4e37b724bacab4874ffbde16593');
INSERT INTO `equ_lab` VALUES ('90583c07c9e542ceacfec6a4f0def2b6', '80eafa666cd94f11a903707b1fc50255');
INSERT INTO `equ_lab` VALUES ('90583c07c9e542ceacfec6a4f0def2b6', 'b7bf068da7404358a4a853ccab9484db');
INSERT INTO `equ_lab` VALUES ('7ffd6161f171408ba77d9069727c67d3', 'b8d1c6cf26bb45378ebc02bf45f79090');
INSERT INTO `equ_lab` VALUES ('7ffd6161f171408ba77d9069727c67d3', '63dd0237d0d3422491268a00753741f5');
INSERT INTO `equ_lab` VALUES ('0901e9aa103f40fb9b469564ca6119d4', '40f9627a24b54617a275653c825ac87b');
INSERT INTO `equ_lab` VALUES ('953c09c8ac7d4644b757ca746ed2010a', 'f2fbfb4f18b349afab6ef1dc82b2cbb0');
INSERT INTO `equ_lab` VALUES ('0901e9aa103f40fb9b469564ca6119d4', 'ff6d02dc17c7410585d2439d462fe0ec');
INSERT INTO `equ_lab` VALUES ('953c09c8ac7d4644b757ca746ed2010a', '72dc710722c1477d85bd2ec0e9f0effa');

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
INSERT INTO `s_equipment` VALUES ('1f31e4e37b724bacab4874ffbde16593', 'NCIT-01-07', '笔记本电脑07', 'ThinkPad T430 Plus', '2017-05-12 16:15:25', '2', '无', 'fd53b30b1d82429ea85fdf45312be78b');
INSERT INTO `s_equipment` VALUES ('2d2f4dec4e864a6fa191f5382af20f23', 'NCIT-01-01', '笔记本电脑01', 'ThinkPad T430', '2017-05-12 16:03:47', '0', '无', '2e7d4108a7154153873f08151ef7401f');
INSERT INTO `s_equipment` VALUES ('40f9627a24b54617a275653c825ac87b', 'NCIT-01-05', '笔记本电脑05', 'ThinkPad T430', '2017-05-12 16:13:02', '0', '无', 'a45c9bc5487741c0ad84a75244e24b35');
INSERT INTO `s_equipment` VALUES ('63dd0237d0d3422491268a00753741f5', 'NCIT-01-10', '笔记本电脑10', 'ThinkPad T430', '2017-05-12 16:19:08', '0', '无', '25db7d13887448518a10abba5a9bdf86');
INSERT INTO `s_equipment` VALUES ('72dc710722c1477d85bd2ec0e9f0effa', 'NCIT-01-02', '笔记本电脑02', 'ThinkPad T430', '2017-05-12 16:05:31', '2', '无', '63606cd5b20a4a369a41419c917cc6ce');
INSERT INTO `s_equipment` VALUES ('80eafa666cd94f11a903707b1fc50255', 'NCIT-01-08', '笔记本电脑08', 'ThinkPad T430 Plus', '2017-05-12 16:17:09', '2', '无', 'ff1754bb969146f7b5a192d161ed66eb');
INSERT INTO `s_equipment` VALUES ('b7bf068da7404358a4a853ccab9484db', 'NCIT-01-06', '笔记本电脑06', 'ThinkPad T430', '2017-05-12 16:13:44', '0', '无', '52bd9a78ff5d49d981783af3de372677');
INSERT INTO `s_equipment` VALUES ('b8d1c6cf26bb45378ebc02bf45f79090', 'NCIT-01-09', '笔记本电脑09', 'ThinkPad T430 Mini', '2017-05-12 16:18:19', '0', '无', 'd2dde6496bcd4fdba765cbe06ac31195');
INSERT INTO `s_equipment` VALUES ('f2fbfb4f18b349afab6ef1dc82b2cbb0', 'NCIT-01-04', '笔记本电脑04', 'ThinkPad T430', '2017-05-12 16:09:47', '0', '无', '5585aa71285b44b2b9d265675ec65d3b');
INSERT INTO `s_equipment` VALUES ('ff6d02dc17c7410585d2439d462fe0ec', 'NCIT-01-03', '笔记本电脑03', 'ThinkPad T430', '2017-05-12 16:08:49', '0', '无', 'cea4e21364eb478ca8b1e4338608c6fb');

-- ----------------------------
-- Table structure for s_equ_break
-- ----------------------------
DROP TABLE IF EXISTS `s_equ_break`;
CREATE TABLE `s_equ_break` (
  `bid` char(32) NOT NULL COMMENT '故障事件id',
  `eid` char(32) NOT NULL COMMENT '故障设备id',
  `id` varchar(15) DEFAULT NULL COMMENT '自定义编号',
  `breason` varchar(500) DEFAULT NULL COMMENT '故障原因',
  `status` int(2) DEFAULT NULL COMMENT '处理状态',
  PRIMARY KEY (`bid`),
  KEY `break_equ_eid` (`eid`) USING BTREE,
  CONSTRAINT `break_equ_eid` FOREIGN KEY (`eid`) REFERENCES `s_equipment` (`eid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='设备故障表';

-- ----------------------------
-- Records of s_equ_break
-- ----------------------------

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
INSERT INTO `s_equ_purchase` VALUES ('25db7d13887448518a10abba5a9bdf86', '30e5ec73716746bf8e6520c5d5c93d6f', '2017-05-12 16:18:56', '4888.990');
INSERT INTO `s_equ_purchase` VALUES ('2e7d4108a7154153873f08151ef7401f', '30e5ec73716746bf8e6520c5d5c93d6f', '2017-05-12 16:03:33', '5000.000');
INSERT INTO `s_equ_purchase` VALUES ('52bd9a78ff5d49d981783af3de372677', '30e5ec73716746bf8e6520c5d5c93d6f', '2017-05-12 16:13:36', '4888.880');
INSERT INTO `s_equ_purchase` VALUES ('5585aa71285b44b2b9d265675ec65d3b', '30e5ec73716746bf8e6520c5d5c93d6f', '2017-05-12 16:09:33', '5888.880');
INSERT INTO `s_equ_purchase` VALUES ('63606cd5b20a4a369a41419c917cc6ce', '30e5ec73716746bf8e6520c5d5c93d6f', '2017-05-12 16:05:03', '5010.000');
INSERT INTO `s_equ_purchase` VALUES ('a45c9bc5487741c0ad84a75244e24b35', '30e5ec73716746bf8e6520c5d5c93d6f', '2017-05-12 16:12:45', '5011.110');
INSERT INTO `s_equ_purchase` VALUES ('cea4e21364eb478ca8b1e4338608c6fb', '30e5ec73716746bf8e6520c5d5c93d6f', '2017-05-12 16:08:40', '4999.990');
INSERT INTO `s_equ_purchase` VALUES ('d2dde6496bcd4fdba765cbe06ac31195', '30e5ec73716746bf8e6520c5d5c93d6f', '2017-05-12 16:18:08', '3999.990');
INSERT INTO `s_equ_purchase` VALUES ('fd53b30b1d82429ea85fdf45312be78b', '30e5ec73716746bf8e6520c5d5c93d6f', '2017-05-12 16:15:17', '8999.990');
INSERT INTO `s_equ_purchase` VALUES ('ff1754bb969146f7b5a192d161ed66eb', '30e5ec73716746bf8e6520c5d5c93d6f', '2017-05-12 16:17:01', '7999.990');

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
  `stel` varchar(15) DEFAULT NULL COMMENT '联系方式',
  `status` int(2) DEFAULT '0' COMMENT '预约状态',
  PRIMARY KEY (`seid`),
  KEY `sch_equ_eid` (`eid`) USING BTREE,
  CONSTRAINT `sch_equ_eid` FOREIGN KEY (`eid`) REFERENCES `s_equipment` (`eid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='设备使用日程表';

-- ----------------------------
-- Records of s_equ_schedule
-- ----------------------------
INSERT INTO `s_equ_schedule` VALUES ('54a6a1bcce0a483bbdc5d2757d1ea9a3', 'ff6d02dc17c7410585d2439d462fe0ec', '2017-05-09 13:40:33', '2017-05-12 13:40:36', 'zzz', '123', '1');
INSERT INTO `s_equ_schedule` VALUES ('be4f43f71d5841e6be0ad78daf47ed4f', '80eafa666cd94f11a903707b1fc50255', '2017-05-15 16:34:14', '2017-05-19 16:34:18', 'stu02', '222', '0');
INSERT INTO `s_equ_schedule` VALUES ('bfe413477ad845ae8615d540cab0be0d', '2d2f4dec4e864a6fa191f5382af20f23', '2017-05-12 23:12:19', '2017-05-13 23:12:21', 'stu03', '3333', '1');
INSERT INTO `s_equ_schedule` VALUES ('efda73606a5948a9ae156312a2af700e', '72dc710722c1477d85bd2ec0e9f0effa', '2017-05-12 16:48:17', '2017-05-15 16:48:18', 'stu01', '1111', '0');

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
INSERT INTO `s_laboratory` VALUES ('0901e9aa103f40fb9b469564ca6119d4', 'NCIT-02', 'NCIT-02', '25', '2017-05-12 16:20:02', '2', '测试', '无', '30e5ec73716746bf8e6520c5d5c93d6f', '25');
INSERT INTO `s_laboratory` VALUES ('270ff7f071e848acbbb46699b0d559df', 'NCIT-05', 'NCIT-05', '25', '2017-05-12 16:25:19', '0', '实施', '无', '30e5ec73716746bf8e6520c5d5c93d6f', '25');
INSERT INTO `s_laboratory` VALUES ('7ffd6161f171408ba77d9069727c67d3', 'NCIT-04', 'NCIT-04', '20', '2017-05-12 16:20:52', '0', '翻译', '无', '30e5ec73716746bf8e6520c5d5c93d6f', '20');
INSERT INTO `s_laboratory` VALUES ('90583c07c9e542ceacfec6a4f0def2b6', 'NCIT-01', 'NCIT-01', '25', '2017-05-12 16:19:45', '0', '开发', '无', '30e5ec73716746bf8e6520c5d5c93d6f', '25');
INSERT INTO `s_laboratory` VALUES ('953c09c8ac7d4644b757ca746ed2010a', 'NCIT-03', 'NCIT-03', '25', '2017-05-12 16:20:18', '0', '研发', '无', '30e5ec73716746bf8e6520c5d5c93d6f', '25');

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
  `stel` varchar(15) DEFAULT NULL COMMENT '预约人电话',
  `status` int(2) DEFAULT '0' COMMENT '预约状态',
  PRIMARY KEY (`slid`),
  KEY `sch_lib_lid` (`lid`) USING BTREE,
  CONSTRAINT `sch_lib_lid` FOREIGN KEY (`lid`) REFERENCES `s_laboratory` (`lid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='实验室使用日程表';

-- ----------------------------
-- Records of s_lab_schedule
-- ----------------------------
INSERT INTO `s_lab_schedule` VALUES ('303e2c3e75074e1f850156ac58ffe24b', '0901e9aa103f40fb9b469564ca6119d4', '2017-05-11 16:29:09', '2017-05-15 16:29:12', 'stu12', '123456', '0');
INSERT INTO `s_lab_schedule` VALUES ('911096a461364559a115c4250549ac33', '90583c07c9e542ceacfec6a4f0def2b6', '2017-05-12 16:28:42', '2017-05-13 16:28:44', 'stu11', '123', '1');

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
INSERT INTO `s_role` VALUES ('9999', '超级管理员', 'administrator');
INSERT INTO `s_role` VALUES ('148883867', '管理员', '管理员');
INSERT INTO `s_role` VALUES ('771598489', '普通用户', '普通用户');
INSERT INTO `s_role` VALUES ('921795995', '测试账户', '测试账户');

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
INSERT INTO `s_user` VALUES ('1b402fd2d24c4628a6f16d835a97b357', 'user01', 'user01', 'ICd/ijtRf7geyzUPx/Cawg==', 'Tapifw', null, null, 'user01@lems.com', '30e5ec73716746bf8e6520c5d5c93d6f', '2017-05-12 16:31:10', null, '0');
INSERT INTO `s_user` VALUES ('30e5ec73716746bf8e6520c5d5c93d6f', 'kehao', 'kehao', 'JsewF//12GasChZ8EzWouw==', 'Ph03LA', 'xi`an', '123456', 'kehao@lems.com', '9999', '2017-05-12 15:58:23', 'd87888d672664346a00fe2830168e673', '0');
INSERT INTO `s_user` VALUES ('35da2e5a6296403baedd089c9ac4d671', 'test', 'test', 'dD2PDvUqL8lXeTSzMa5sTQ==', 'Divwa6', null, null, 'test@lems.com', '30e5ec73716746bf8e6520c5d5c93d6f', '2017-05-12 16:30:33', null, '0');
INSERT INTO `s_user` VALUES ('3666ca6111fa4d19b0ca10391f07ba53', 'user02', 'user02', 'SoTuUpomebromALFThAIMw==', 'tOZGgh', null, null, 'user02@lems.com', '30e5ec73716746bf8e6520c5d5c93d6f', '2017-05-13 11:09:08', null, '0');
INSERT INTO `s_user` VALUES ('9999', 'admin', 'admin', '6khXbzC+FmmXFpnAmtBclA==', '123456', 'address', '110', 'admin@lems.com', '9999', '2017-05-05 11:40:53', 'a0a66a90d39c42d18fed8e3b82f3661a', '0');

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
INSERT INTO `user_role` VALUES ('9999', '9999');
INSERT INTO `user_role` VALUES ('30e5ec73716746bf8e6520c5d5c93d6f', '148883867');
INSERT INTO `user_role` VALUES ('35da2e5a6296403baedd089c9ac4d671', '921795995');
INSERT INTO `user_role` VALUES ('1b402fd2d24c4628a6f16d835a97b357', '771598489');
INSERT INTO `user_role` VALUES ('3666ca6111fa4d19b0ca10391f07ba53', '771598489');

SET FOREIGN_KEY_CHECKS=1;