-- 重置实体状态
update s_equ_break set status='0';
update s_equipment set status='0';
update s_user set status='0';
update s_laboratory set status='0';
delete from s_equ_schedule;
delete from s_lab_schedule;
delete from s_equ_break;