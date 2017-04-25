/*
Navicat MySQL Data Transfer

Source Server         : kehao_mysql
Source Server Version : 50703
Source Host           : localhost:3306
Source Database       : lems

Target Server Type    : MYSQL
Target Server Version : 50703
File Encoding         : 65001

Date: 2017-04-24 21:45:45
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for equ_lab
-- ----------------------------
DROP TABLE IF EXISTS `equ_lab`;
CREATE TABLE `equ_lab` (
  `lid` char(32) NOT NULL COMMENT '实验室id',
  `eid` char(32) NOT NULL COMMENT '设备id',
  KEY `equ_lab_lib_lid` (`lid`),
  KEY `equ_lab_equ_eid` (`eid`),
  CONSTRAINT `equ_lab_equ_eid` FOREIGN KEY (`eid`) REFERENCES `s_equipment` (`eid`),
  CONSTRAINT `equ_lab_lib_lid` FOREIGN KEY (`lid`) REFERENCES `s_laboratory` (`lid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备所属实验室';

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
  KEY `role_perms_role_rid` (`rid`),
  KEY `role_perms_perms_pid` (`pid`),
  CONSTRAINT `role_perms_perms_pid` FOREIGN KEY (`pid`) REFERENCES `s_permission` (`pid`),
  CONSTRAINT `role_perms_role_rid` FOREIGN KEY (`rid`) REFERENCES `s_role` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色_权限表';

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
  `addtime` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '添加时间',
  `status` int(2) DEFAULT NULL COMMENT '设备状态',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `epid` char(32) DEFAULT NULL COMMENT '采购id',
  PRIMARY KEY (`eid`),
  KEY `equ_purc_eid` (`epid`),
  CONSTRAINT `equ_purc_eid` FOREIGN KEY (`epid`) REFERENCES `s_equ_purchase` (`epid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备表';

-- ----------------------------
-- Records of s_equipment
-- ----------------------------

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
  KEY `break_equ_eid` (`eid`),
  CONSTRAINT `break_equ_eid` FOREIGN KEY (`eid`) REFERENCES `s_equipment` (`eid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备故障表';

-- ----------------------------
-- Records of s_equ_break
-- ----------------------------

-- ----------------------------
-- Table structure for s_equ_purchase
-- ----------------------------
DROP TABLE IF EXISTS `s_equ_purchase`;
CREATE TABLE `s_equ_purchase` (
  `pcid` char(32) NOT NULL COMMENT '采购id',
  `epid` char(32) NOT NULL COMMENT '设备id',
  `uid` char(32) DEFAULT NULL COMMENT '采购员id',
  `pctime` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '采购时间',
  PRIMARY KEY (`epid`),
  KEY `purc_user_uid` (`uid`),
  CONSTRAINT `purc_user_uid` FOREIGN KEY (`uid`) REFERENCES `s_user` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备采购表';

-- ----------------------------
-- Records of s_equ_purchase
-- ----------------------------

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
  KEY `sch_equ_eid` (`eid`),
  CONSTRAINT `sch_equ_eid` FOREIGN KEY (`eid`) REFERENCES `s_equipment` (`eid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备使用日程表';

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
  KEY `lab_user_uid` (`uid`),
  CONSTRAINT `lab_user_uid` FOREIGN KEY (`uid`) REFERENCES `s_user` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='实验室表';

-- ----------------------------
-- Records of s_laboratory
-- ----------------------------

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
  KEY `sch_lib_lid` (`lid`),
  CONSTRAINT `sch_lib_lid` FOREIGN KEY (`lid`) REFERENCES `s_laboratory` (`lid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='实验室使用日程表';

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限表';

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
  KEY `perms_res_pid` (`pid`),
  CONSTRAINT `perms_res_pid` FOREIGN KEY (`pid`) REFERENCES `s_permission` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资源表';

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of s_role
-- ----------------------------

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
  KEY `user_master_id` (`masterid`),
  CONSTRAINT `user_master_id` FOREIGN KEY (`masterid`) REFERENCES `s_user` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of s_user
-- ----------------------------
INSERT INTO `s_user` VALUES ('9999', 'admin', 'admin', '6khXbzC+FmmXFpnAmtBclA==', '123456', 'address', '110', 'xxx@xx.com', '9999', '2017-04-24 20:29:04', '9b3c0bfce3bf41dc956f17f6b2ae0b63');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `uid` char(32) NOT NULL,
  `rid` int(9) NOT NULL,
  KEY `user_role_user_uid` (`uid`),
  KEY `user_role_role_rid` (`rid`),
  CONSTRAINT `user_role_role_rid` FOREIGN KEY (`rid`) REFERENCES `s_role` (`rid`),
  CONSTRAINT `user_role_user_uid` FOREIGN KEY (`uid`) REFERENCES `s_user` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户_角色表';

-- ----------------------------
-- Records of user_role
-- ----------------------------
