select equ.eid, equ.id e_id, equ.ename, equ.type, equ.addtime, equ.status e_status, equ.remark e_remark, lab.lname,lab.id l_id
from s_equipment equ join equ_lab elab on(equ.eid=elab.eid) join s_laboratory lab on(elab.lid=lab.lid)
where equ.status!='1' ORDER BY ename asc LIMIT 0,5;