-- 修改状态存储过程
DELIMITER |
DROP PROCEDURE IF EXISTS event_lems_etime |
CREATE PROCEDURE event_lems_etime()
	BEGIN
		DECLARE x_lid varchar(32) DEFAULT '';
		DECLARE x_eid varchar(32) DEFAULT '';
		-- 实验室相关
		SELECT lems.s_lab_schedule.lid 
		INTO x_lid
		from lems.s_lab_schedule 
		where now()-endtime>=0 and status=0;
		
		update lems.s_lab_schedule set status=1 where lems.s_lab_schedule.lid=x_lid;
		update lems.s_laboratory set status=0 where lems.s_laboratory.lid=x_lid;
		
		
		-- 实验室相关
		SELECT lems.s_equ_schedule.eid 
		INTO x_eid
		from lems.s_equ_schedule 
		where now()-endtime>=0 and status=0;
		
		update lems.s_equ_schedule set status=1 where lems.s_equ_schedule.eid=x_eid;
		update lems.s_equipment set status=0 where lems.s_equipment.eid=x_eid;		
		
	END
|
-- 开启事件
SET GLOBAL event_scheduler = 1; 

-- 创建触发器
CREATE EVENT IF NOT EXISTS lems_trigger
ON SCHEDULE EVERY 1 SECOND
ON COMPLETION PRESERVE
DO CALL event_lems_etime();

-- 启动触发器
ALTER EVENT lems_trigger ON COMPLETION PRESERVE ENABLE;