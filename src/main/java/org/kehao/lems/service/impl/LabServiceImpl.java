package org.kehao.lems.service.impl;

import org.kehao.lems.dao.LaboratoryMapper;
import org.kehao.lems.entity.EquLab;
import org.kehao.lems.entity.LabSchedule;
import org.kehao.lems.entity.Laboratory;
import org.kehao.lems.entity.User;
import org.kehao.lems.entity.extend.LaboratoryEx;
import org.kehao.lems.service.LabScheduleService;
import org.kehao.lems.service.LabService;
import org.kehao.lems.utils.CodeUtil;
import org.kehao.lems.utils.LEMSResult;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by kehao on 2017/4/26.
 */
@Service("labService")
public class LabServiceImpl implements LabService {
    @Resource
    LaboratoryMapper laboratoryMapper;
    @Resource
    LabScheduleService labScheduleService;

    @Override
    public LEMSResult labAdd(Laboratory laboratory) {
        LEMSResult result = new LEMSResult();
        laboratory.setLid(CodeUtil.createId());
        laboratory.setStatus(0);
        laboratory.setAddtime(new Timestamp(System.currentTimeMillis()));
        if (laboratoryMapper.insertSelective(laboratory) == 1) {
            result.setStatus(0);
            result.setMessage("添加实验室成功");
        } else {
            result.setStatus(1);
            result.setMessage("添加实验室失败");
        }
        return result;
    }

    @Override
    public LEMSResult labGet(Integer page, Integer pageSize, String order, String sort, LaboratoryEx laboratoryEx) {
        LEMSResult result = new LEMSResult();
        Map<String, Object> map = new HashMap<String, Object>(8);
        //查询条件
        map.put("laboratoryEx", laboratoryEx);
        //分页
        if (null == page) {
            page = 1;
        }
        if (null == pageSize) {
            pageSize = 5;
        }
        map.put("startRec", pageSize * (page - 1));//5*(1-1)=0,,5*(2-1)=5
        map.put("recCount", pageSize);
        //映射排序字段
        if (sort.equals("lab_uname")) {
            sort = "user.uname";
        }
        //排序
        map.put("order", order);
        map.put("sort", sort);
        List<Laboratory> laboratoryList = laboratoryMapper.selectLaboratoryCondition(map);
        //将数据封装至扩展对象
        List<LaboratoryEx> laboratoryExList = new ArrayList<LaboratoryEx>(laboratoryList.size());
        for (Laboratory laboratory : laboratoryList) {
            LaboratoryEx laboratoryEx1 = new LaboratoryEx();
            BeanUtils.copyProperties(laboratory, laboratoryEx1);
            //拿到空记录，会导致结果集错乱
            if (laboratory.getUser() != null) {//检测空记录
                laboratoryEx1.setLab_uname(laboratory.getUser().getUname());
                laboratoryEx1.setLab_uid(laboratory.getUser().getUid());
            }
            laboratoryExList.add(laboratoryEx1);
        }
        result.setData(laboratoryExList);
        result.setStatus(0);
        result.setMessage("获取实验室列表成功");
        return result;
    }

    @Override
    public Long labGetCount(LaboratoryEx laboratoryEx) {
        Map<String, Object> map = new HashMap<String, Object>(8);
        //查询条件
        map.put("laboratoryEx", laboratoryEx);
        return laboratoryMapper.selectLaboratoryConditionCount(map);
    }

    @Override
    public LEMSResult labDel(List<String> delList) {
        LEMSResult result = new LEMSResult();
        Map map = new HashMap();
        map.put("status", 1);//删除状态
        map.put("list", delList);
        int rec = laboratoryMapper.updateLabStatusByLidBatch(map);
        if (rec == delList.size()) {
            result.setMessage("批量删除成功");
            result.setStatus(0);
            result.setData(rec);
        } else {
            result.setMessage("批量删除失败");
            result.setStatus(1);
        }
        return result;
    }

    @Override
    public LEMSResult searchLab(Integer page, Integer pageSize, String order, String sort, LaboratoryEx laboratoryEx) {
        LEMSResult result = new LEMSResult();
        Map<String, Object> map = new HashMap<String, Object>(8);
        //查询条件
        map.put("laboratoryEx", laboratoryEx);
        //分页
        if (null == page) {
            page = 1;
        }
        if (null == pageSize) {
            pageSize = 5;
        }
        map.put("startRec", pageSize * (page - 1));//5*(1-1)=0,,5*(2-1)=5
        map.put("recCount", pageSize);
        //排序
        map.put("order", order);
        //映射排序字段
        if (sort.equals("equ_ename")) {
            sort = "ename";
        }
        if (sort.equals("equ_type")) {
            sort = "e_type";
        }
        if (sort.equals("equ_id")) {
            sort = "e_id";
        }
        if(sort.equals("equ_status")){
            sort="e_status";
        }
        map.put("sort", "a."+sort);//因为后台采用了联合查询，结果集名称为'a'
        //封装返回数据集合
        List<Laboratory> laboratoryList = laboratoryMapper.selectLabEquUserByCondition(map);
        List<LaboratoryEx> laboratoryExList = new ArrayList<LaboratoryEx>();
        for (Laboratory laboratory : laboratoryList) {
            BeanUtils.copyProperties(laboratory, laboratoryEx);
            if (laboratory.getLid() != null) {//检测空记录
                Laboratory laboratoryTmp = laboratoryMapper.selectLabUserByLid(laboratory.getLid());
                if (laboratoryTmp != null) {
                    User userTmp = laboratoryTmp.getUser();
                    if (userTmp != null) {
                        laboratoryEx.setLab_uname(userTmp.getUname());//实验室负责人名称
                    }
                }
            }
            //以上是共有属性
            for (EquLab equLab : laboratory.getEquLab()) {
                LaboratoryEx laboratoryExTmp = new LaboratoryEx();
                if (equLab.getEquipment() != null) {
                    //这里是非共有属性
                    BeanUtils.copyProperties(laboratoryEx, laboratoryExTmp);//复制一份数据
                    //复制非共有属性
                    laboratoryExTmp.setEqu_id(equLab.getEquipment().getId());
                    laboratoryExTmp.setEqu_ename(equLab.getEquipment().getEname());
                    laboratoryExTmp.setEqu_type(equLab.getEquipment().getType());
                    laboratoryExTmp.setEqu_status(equLab.getEquipment().getStatus());
                    laboratoryExTmp.setEqu_remark(equLab.getEquipment().getRemark());
                    if (equLab.getEquipment().getEquPurchase() != null) {
                        if (equLab.getEquipment().getEquPurchase().getUser() != null) {
                            laboratoryExTmp.setEqu_uname(equLab.getEquipment().getEquPurchase().getUser().getUname());
                        }
                        laboratoryExTmp.setPurc_price(equLab.getEquipment().getEquPurchase().getPrice());
                    }
                }
                //添加到集合
                laboratoryExList.add(laboratoryExTmp);
            }
        }
        result.setData(laboratoryExList);
        result.setStatus(0);
        result.setMessage("实验室查询成功");
        return result;
    }

    @Override
    public Long searchLabCount(LaboratoryEx laboratoryEx) {
        LEMSResult result = new LEMSResult();
        Map<String, Object> map = new HashMap<String, Object>(8);
        //查询条件
        map.put("laboratoryEx", laboratoryEx);
        return laboratoryMapper.selectLabEquUserByConditionCount(map);
    }

    @Override
    public LEMSResult enOrderLab(Integer page, Integer pageSize, String order, String sort, LaboratoryEx laboratoryEx) {
        LEMSResult result = new LEMSResult();
        Map<String, Object> map = new HashMap<String, Object>(8);
        //查询条件
        map.put("laboratoryEx", laboratoryEx);
        //分页
        if (null == page) {
            page = 1;
        }
        if (null == pageSize) {
            pageSize = 5;
        }
        map.put("startRec", pageSize * (page - 1));//5*(1-1)=0,,5*(2-1)=5
        map.put("recCount", pageSize);
        //映射排序字段
        if (sort.equals("lab_uname")) {
            sort = "user.uname";
        }
        //排序
        map.put("order", order);
        map.put("sort", sort);

        List<Laboratory> laboratoryList = laboratoryMapper.selectEnOrderLabCondition(map);
        //将数据封装至扩展对象
        List<LaboratoryEx> laboratoryExList = new ArrayList<LaboratoryEx>(laboratoryList.size());
        for (Laboratory laboratory : laboratoryList) {
            LaboratoryEx laboratoryEx1 = new LaboratoryEx();
            BeanUtils.copyProperties(laboratory, laboratoryEx1);
            //拿到空记录，会导致结果集错乱
            if (laboratory.getUser() != null) {//检测空记录
                laboratoryEx1.setLab_uname(laboratory.getUser().getUname());
                laboratoryEx1.setLab_uid(laboratory.getUser().getUid());
            }
            laboratoryExList.add(laboratoryEx1);
        }
        result.setData(laboratoryExList);
        result.setStatus(0);
        result.setMessage("获取可预约实验室成功");
        return result;
    }

    @Override
    public Long enOrderLabCount(LaboratoryEx laboratoryEx) {
        Map<String, Object> map = new HashMap<String, Object>(8);
        //查询条件
        map.put("laboratoryEx", laboratoryEx);
        return laboratoryMapper.selectEnOrderLabConditionCount(map);
    }

    @Override
    public LEMSResult orderLab(LabSchedule labSchedule) {
        LEMSResult result = new LEMSResult();
        if (labSchedule != null) {
            Map<String, String> map = new HashMap<String, String>(4);
            map.put("lid", labSchedule.getLid());
            map.put("status", "2");
            int upConut = laboratoryMapper.updateLabStatusByLid(map);
            if (1 == upConut) {
                int status = labScheduleService.addOrderLab(labSchedule).getStatus();
                if (0 == status) {
                    result.setStatus(0);
                    result.setMessage("预约成功");
                } else {
                    //回滚数据
                    map.put("status", "0");
                    laboratoryMapper.updateLabStatusByLid(map);
                    result.setStatus(2);
                    result.setMessage("预约失败");
                }
            } else {
                result.setStatus(1);
                result.setMessage("更改实验室状态失败");
            }
        }
        return result;
    }

    @Override
    public LEMSResult modMgrLab(String lid, String uid) {
        LEMSResult result = new LEMSResult();
        Map<String, String> map = new HashMap<String, String>(4);
        map.put("lid", lid);
        map.put("uid", uid);
        int upCount = laboratoryMapper.updateLabUidByLid(map);
        if (1 == upCount) {
            result.setStatus(0);
            result.setMessage("修改成功");
        } else {
            result.setStatus(1);
            result.setMessage("修改失败");
        }
        return result;
    }

    @Override
    public LEMSResult getAllLab() {
        LEMSResult result =new LEMSResult();
        List<Laboratory> laboratoryList=laboratoryMapper.selectAllLab();
        if(laboratoryList.size()>0){
            result.setData(laboratoryList);
            result.setMessage("获取成功");
            result.setStatus(0);
        }else {
            result.setMessage("获取失败");
            result.setStatus(1);
        }
        return result;
    }
}
