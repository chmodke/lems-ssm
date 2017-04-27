/*
Navicat MySQL Data Transfer

Source Server         : mysql_root
Source Server Version : 50703
Source Host           : localhost:3306
Source Database       : lems

Target Server Type    : MYSQL
Target Server Version : 50703
File Encoding         : 65001

Date: 2017-04-27 09:33:19
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
  CONSTRAINT `equ_lab_lib_lid` FOREIGN KEY (`lid`) REFERENCES `s_laboratory` (`lid`),
  CONSTRAINT `equ_lab_equ_eid` FOREIGN KEY (`eid`) REFERENCES `s_equipment` (`eid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='设备所属实验室';

-- ----------------------------
-- Records of equ_lab
-- ----------------------------

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission` (
  `rid` int(9) NOT NULL,
  `pid` int(9) NOT NULL,
  KEY `role_perms_role_rid` (`rid`) USING BTREE,
  KEY `role_perms_perms_pid` (`pid`) USING BTREE,
  CONSTRAINT `role_perms_role_rid` FOREIGN KEY (`rid`) REFERENCES `s_role` (`rid`),
  CONSTRAINT `role_perms_perms_pid` FOREIGN KEY (`pid`) REFERENCES `s_permission` (`pid`)
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
  `addtime` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '添加时间',
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
INSERT INTO `s_equipment` VALUES ('9999', '9999', '电脑', '电脑', '2017-04-25 09:32:11', '0', '电脑', '9999');

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
  `pctime` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '采购时间',
  `price` double(10,3) DEFAULT '0.000' COMMENT '价格',
  PRIMARY KEY (`pcid`),
  KEY `purc_user_uid` (`uid`) USING BTREE,
  CONSTRAINT `purc_user_uid` FOREIGN KEY (`uid`) REFERENCES `s_user` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='设备采购表';

-- ----------------------------
-- Records of s_equ_purchase
-- ----------------------------
INSERT INTO `s_equ_purchase` VALUES ('9999', '9999', '2017-04-25 09:30:54', '9999.000');

-- ----------------------------
-- Table structure for s_equ_schedule
-- ----------------------------
DROP TABLE IF EXISTS `s_equ_schedule`;
CREATE TABLE `s_equ_schedule` (
  `seid` char(32) NOT NULL COMMENT '设备日程id',
  `eid` char(32) NOT NULL COMMENT '设备id',
  `starttime` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '开始时间',
  `endtime` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '结束时间',
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
  `addtime` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '添加时间',
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
INSERT INTO `s_laboratory` VALUES ('45b0084bc10d4dd4b78eb9bf0c5ce477', '9#629', '629', '80', '2017-04-27 09:02:29', '0', '计算机机房', '计算机软件机房', '9999', '80');
INSERT INTO `s_laboratory` VALUES ('b91e4444c3f843e2b2be0276bd8b3265', '629', '计算机公共机房', '50', '2017-04-25 09:41:08', '0', '计算机', '计算机机房', '9999', '50');

-- ----------------------------
-- Table structure for s_lab_schedule
-- ----------------------------
DROP TABLE IF EXISTS `s_lab_schedule`;
CREATE TABLE `s_lab_schedule` (
  `slid` char(32) NOT NULL COMMENT '实验室使用日程id',
  `lid` char(32) NOT NULL COMMENT '实验室id',
  `starttime` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '开始时间',
  `endtime` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '结束时间',
  `sname` varchar(32) DEFAULT NULL COMMENT '借用人姓名',
  PRIMARY KEY (`slid`),
  KEY `sch_lib_lid` (`lid`) USING BTREE,
  CONSTRAINT `sch_lib_lid` FOREIGN KEY (`lid`) REFERENCES `s_laboratory` (`lid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='实验室使用日程表';

-- ----------------------------
-- Records of s_lab_schedule
-- ----------------------------

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
INSERT INTO `s_role` VALUES ('376703787', 'stander', 'stander');
INSERT INTO `s_role` VALUES ('405230015', 'administrator', 'administrator');

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
  `createtime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `token` char(32) DEFAULT NULL COMMENT '登录认证',
  PRIMARY KEY (`uid`),
  KEY `user_master_id` (`masterid`) USING BTREE,
  CONSTRAINT `user_master_id` FOREIGN KEY (`masterid`) REFERENCES `s_user` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户表';

-- ----------------------------
-- Records of s_user
-- ----------------------------
INSERT INTO `s_user` VALUES ('0e690bc74f354a0996942ee091709943', 'kehao003', 'kehao003', 'ILfXjzPgW073ICQUfhIhwA==', 'sqDUL6', null, null, 'kehao003@xx.com', '16e3a3765d2a40b4917eb2cce7d372d4', '2017-04-26 11:31:19', null);
INSERT INTO `s_user` VALUES ('0ec092f59ead420ba6b3829ea4d4cfb8', 'test002', 'test002', 'LV/jqd7Y0ZJRDxdf4alnFQ==', 'FjeoK4', null, null, 'test002@xx.com', '9999', '2017-04-26 09:53:50', null);
INSERT INTO `s_user` VALUES ('16e3a3765d2a40b4917eb2cce7d372d4', 'kehao', 'kehao', 'kNO3eXei0oqCUGep7pImyw==', 'SJvwg7', null, null, 'kehao@x.com', '9999', '2017-04-26 16:56:04', 'b8dcfd69ee664dc88a0aa43dc0e9871c');
INSERT INTO `s_user` VALUES ('2caf84fa65c04963818da964ce10fc4b', 'test000', 'kehao', 'aMtnkqh+KcQGjfZoLftcuQ==', '0tzkmh', null, null, 'test001@xx.com', '9999', '2017-04-26 09:46:33', null);
INSERT INTO `s_user` VALUES ('56c0b00dbceb4a54b065b0aa71bca526', 'user1', 'user', '6khXbzC+FmmXFpnAmtBclA==', '123456', '630', '111', 'xxx@xx.com', '9999', '2017-04-25 09:42:57', null);
INSERT INTO `s_user` VALUES ('6e28f9a7da5d44d3bc5d7e0844b45eb5', '朱晨光', '朱晨光', 'mUuuLL580Y+CC97uHFrgDw==', 'wHsa7Q', null, null, 'zhuchenguang@xx.com', '16e3a3765d2a40b4917eb2cce7d372d4', '2017-04-26 11:34:34', 'd1c553fb2f8e43ddb4704f79f0de53ae');
INSERT INTO `s_user` VALUES ('9999', 'admin', 'admin', '6khXbzC+FmmXFpnAmtBclA==', '123456', 'address', '110', 'admin@xx.com', '9999', '2017-04-27 09:00:46', '86d01fc5706b407da8d45eb69a35af97');
INSERT INTO `s_user` VALUES ('9a0329eac5f444ee93e16aa00627489e', 'kehao004', 'kehao004', 'yQGL6sCpxi4Ox4SqbUUp2A==', 'fCOdm4', null, null, 'kehao004@xx.com', '16e3a3765d2a40b4917eb2cce7d372d4', '2017-04-26 11:40:53', null);
INSERT INTO `s_user` VALUES ('c8f7256f5fa34a1b9fac60ce0d29ed6e', 'test003', 'test003', 'Gqs2VjEmWBQY3hsmN6rSqA==', '3rkUnK', null, null, 'test003@xx.com', '9999', '2017-04-26 09:56:02', null);
INSERT INTO `s_user` VALUES ('caa8e746ff7e4cbd9285a21f51d25f8e', 'kehao001', 'kehao001', 'baSjbI/kE6d9BsThmXaZCA==', 'QdGPfX', null, null, 'kehao001@xx.com', '16e3a3765d2a40b4917eb2cce7d372d4', '2017-04-26 10:34:46', null);
INSERT INTO `s_user` VALUES ('d791da75a18c4877b31b3b97cdc195a7', 'kehao002', 'kehao002', 'VF59KSBxbVFrTDjOsrfGcQ==', 'AhtWFp', null, null, 'kehao002@xx.com', '16e3a3765d2a40b4917eb2cce7d372d4', '2017-04-26 11:26:43', '12bc61a3f9474a98877764c45f850ef4');
INSERT INTO `s_user` VALUES ('fc489fc09af74f659380b994011ca2d3', 'kehao005', 'kehao005', 'unPZRRKCZ4ITXoqn0LPVQA==', 'Xie4op', null, null, 'kehao005@xx.com', '16e3a3765d2a40b4917eb2cce7d372d4', '2017-04-26 16:56:36', null);

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `uid` char(32) NOT NULL,
  `rid` int(9) NOT NULL,
  KEY `user_role_user_uid` (`uid`) USING BTREE,
  KEY `user_role_role_rid` (`rid`) USING BTREE,
  CONSTRAINT `user_role_user_uid` FOREIGN KEY (`uid`) REFERENCES `s_user` (`uid`),
  CONSTRAINT `user_role_role_rid` FOREIGN KEY (`rid`) REFERENCES `s_role` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户_角色表';

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('9999', '405230015');
SET FOREIGN_KEY_CHECKS=1;
