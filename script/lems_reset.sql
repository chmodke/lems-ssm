-- 重置实体状态
update s_equ_break set status='0';
update s_equipment set status='0';
update s_user set status='0';
update s_laboratory set status='0';
delete from s_equ_schedule;
delete from s_lab_schedule;
delete from s_equ_break;

-- 初始化数据库
-- 一下SQL会初始化数据库，谨慎操作
delete from s_equ_schedule;
delete from s_lab_schedule;
delete from s_equ_break;
DELETE FROM s_resources;
DELETE FROM equ_lab;
DELETE FROM role_permission;
DELETE FROM user_role WHERE uid !='9999';

DELETE FROM s_permission;
DELETE FROM s_role WHERE rname!='超级管理员';
DELETE FROM s_laboratory;
DELETE FROM s_equipment;
DELETE from s_equ_purchase;
alter table s_user drop foreign key user_master_id;
DELETE FROM s_user WHERE uid !='9999';
ALTER TABLE `s_user` ADD CONSTRAINT `user_master_id` FOREIGN KEY (`masterid`) REFERENCES `s_user` (`uid`);