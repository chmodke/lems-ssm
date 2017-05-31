package org.kehao.lems.service.impl;

import org.kehao.lems.dao.EquBreakMapper;
import org.kehao.lems.dao.EquLabMapper;
import org.kehao.lems.dao.EquipmentMapper;
import org.kehao.lems.entity.*;
import org.kehao.lems.entity.extend.EquBreakEx;
import org.kehao.lems.entity.extend.EquipmentEx;
import org.kehao.lems.entity.extend.LaboratoryEx;
import org.kehao.lems.service.EquScheduleService;
import org.kehao.lems.service.EquService;
import org.kehao.lems.utils.CodeUtil;
import org.kehao.lems.utils.LEMSResult;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.validation.ReportAsSingleViolation;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by hao on 2017/04/27.
 */
@Service("equService")
public class EquServiceImpl implements EquService {
    @Resource
    EquipmentMapper equipmentMapper;
    @Resource
    EquLabMapper equLabMapper;
    @Resource
    EquBreakMapper equBreakMapper;
    @Resource
    EquScheduleService equScheduleService;

    public LEMSResult equAdd(Equipment equipment) {
        LEMSResult result = new LEMSResult();
        equipment.setEid(CodeUtil.createId());
        equipment.setAddtime(new Timestamp(System.currentTimeMillis()));
        equipment.setStatus(0);
        if (equipmentMapper.insertSelective(equipment) == 1) {
            result.setStatus(0);
            result.setMessage("设备部分完成");
        } else {
            result.setStatus(1);
            result.setMessage("设备部分失败");
        }
        return result;
    }

    @Override
    public LEMSResult equGet(Integer page, Integer pageSize, String order, String sort, EquipmentEx equipmentEx) {
        LEMSResult result = new LEMSResult();
        Map<String, Object> map = new HashMap<String, Object>(8);
        //查询条件
        map.put("equipmentEx", equipmentEx);
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
        if (sort.equals("id")) {
            sort = "equ.id";
        }
        if (sort.equals("type")) {
            sort = "equ.type";
        }
        if (sort.equals("status")) {
            sort = "equ.status";
        }
        //排序
        map.put("order", order);
        map.put("sort", sort);

        List<Equipment> equipmentList = equipmentMapper.selectEquipmentCondition(map);
        //将数据封装至扩展对象
        List<EquipmentEx> equipmentExList = new ArrayList<EquipmentEx>(equipmentList.size());
        for (Equipment equipment : equipmentList) {
            EquipmentEx equipmentExTmp = new EquipmentEx();
            BeanUtils.copyProperties(equipment, equipmentExTmp);
            //拿到空记录，会导致结果集错乱
            if (equipment.getEquLab() != null) {//检测空记录
                EquLab equLab = equipment.getEquLab();
                if (equLab.getLaboratory() != null) {
                    equipmentExTmp.setLid(equLab.getLaboratory().getLid());
                    equipmentExTmp.setLanme(equLab.getLaboratory().getLname());
                }
            }
            equipmentExList.add(equipmentExTmp);
        }
        result.setData(equipmentExList);
        result.setStatus(0);
        result.setMessage("获取设备列表成功");
        return result;
    }

    @Override
    public Long equGetCount(EquipmentEx equipmentEx) {
        Map<String, Object> map = new HashMap<String, Object>(8);
        //查询条件
        map.put("equipmentEx", equipmentEx);
        return equipmentMapper.selectEquipmentConditionCount(map);
    }

    public LEMSResult equDel(List<String> delList) {
        LEMSResult result = new LEMSResult();
        Map map = new HashMap();
        map.put("status", 1);//删除状态
        map.put("list", delList);
        int rec = equipmentMapper.updateEquStatusByEidBatch(map);
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
    public LEMSResult moveEqu(EquLab equLab) {
        LEMSResult result = new LEMSResult();
        EquLab equLabTmp = equLabMapper.selectEquLabByEid(equLab.getEid());
        int upCount = 0;
        if (equLabTmp != null) {
            upCount = equLabMapper.updateEquLabLidByEid(equLab);
        } else {
            upCount = equLabMapper.insert(equLab);
        }
        if (1 == upCount) {
            result.setStatus(0);
            result.setMessage("转移成功");
        } else {
            result.setStatus(1);
            result.setMessage("转移失败");
        }
        return result;
    }

    @Override
    public LEMSResult breakEqu(EquBreak equBreak) {
        LEMSResult result = new LEMSResult();
        List<String> list = new ArrayList<String>(1);
        list.add(equBreak.getEid());
        Map map = new HashMap();
        map.put("status", "3");//故障状态
        map.put("list", list);
        int upCount = equipmentMapper.updateEquStatusByEidBatch(map);//更新设备状态
        if (1 == upCount) {
            equBreak.setBid(CodeUtil.createId());
            equBreak.setStatus(0);
            upCount=equBreakMapper.insertSelective(equBreak);
        }
        if (1==upCount){
            result.setStatus(0);
            result.setMessage("报修成功");
        }else {
            result.setStatus(1);
            result.setMessage("报修失败");
        }
        return result;
    }

    @Override
    public LEMSResult labGetBreak(Integer page, Integer pageSize, String order, String sort, EquBreakEx equBreakEx) {
        LEMSResult result = new LEMSResult();
        Map<String, Object> map = new HashMap<String, Object>(8);
        //查询条件
        map.put("equBreakEx", equBreakEx);
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
        if (sort.equals("id")) {
            sort = "brk.id";
        }
        if (sort.equals("e_id")) {
            sort = "equ.id";
        }
        if (sort.equals("ename")) {
            sort = "equ.ename";
        }
        if (sort.equals("etype")) {
            sort = "equ.type";
        }
        if (sort.equals("status")) {
            sort = "brk.status";
        }
        //排序
        map.put("order", order);
        map.put("sort", sort);

        List<EquBreak> equBreakList=equBreakMapper.selectEquBreakByCondition(map);
        //将数据封装至扩展对象
        List<EquBreakEx> equBreakExList=new ArrayList<EquBreakEx>(equBreakList.size());
        for(EquBreak equBreak:equBreakList){
            EquBreakEx equBreakExTmp=new EquBreakEx();
            BeanUtils.copyProperties(equBreak,equBreakExTmp);
            if (equBreak.getEquipment()!=null){
                Equipment equipment=equBreak.getEquipment();
                equBreakExTmp.setEname(equipment.getEname());
                equBreakExTmp.setEtype(equipment.getType());
                equBreakExTmp.setE_id(equipment.getId());
                if(equipment.getEquLab()!=null){
                    EquLab equLab=equipment.getEquLab();
                    if(equLab.getLaboratory()!=null){
                        Laboratory laboratory=equLab.getLaboratory();
                        equBreakExTmp.setLname(laboratory.getLname());
                    }
                }
            }
            equBreakExList.add(equBreakExTmp);
        }
        result.setData(equBreakExList);
        result.setStatus(0);
        result.setMessage("获取保修列表成功");
        return result;
    }

    @Override
    public Long labGetBreakCount(EquBreakEx equBreakEx) {
        Map<String, Object> map = new HashMap<String, Object>(8);
        //查询条件
        map.put("equBreakEx", equBreakEx);
        return equBreakMapper.selectEquBreakByConditionCount(map);
    }

    @Override
    public LEMSResult fixEqu(String bid,String eid) {
        LEMSResult result=new LEMSResult();
        List<String> list = new ArrayList<String>(1);
        list.add(eid);
        Map map = new HashMap();
        map.put("status", "0");//故障状态
        map.put("list", list);
        int upCount = equipmentMapper.updateEquStatusByEidBatch(map);//更新设备状态
        if(1==upCount){
            Map map1=new HashMap();
            map1.put("bid",bid);
            map1.put("status","1");
            upCount=equBreakMapper.updateBrkStatusByBid(map1);//更新报修状态
        }
        if (1 == upCount) {
            result.setStatus(0);
            result.setMessage("更新成功");
        } else {
            result.setStatus(1);
            result.setMessage("更新失败");
        }
        return result;
    }

    @Override
    public LEMSResult fixEquDel(String bid) {
        LEMSResult result=new LEMSResult();
        int upCount=equBreakMapper.deleteByPrimaryKey(bid);
        if(1==upCount){
            result.setStatus(0);
            result.setMessage("删除成功");
        }else{
            result.setStatus(1);
            result.setMessage("删除失败");
        }
        return result;
    }

    @Override
    public Long enOrderEquCount(EquipmentEx equipmentEx) {
        Map<String, Object> map = new HashMap<String, Object>(8);
        //查询条件
        map.put("equipmentEx", equipmentEx);
        return equipmentMapper.selectEnOrderEquConditionCount(map);
    }

    @Override
    public LEMSResult enOrderEqu(Integer page, Integer pageSize, String order, String sort, EquipmentEx equipmentEx) {
        LEMSResult result = new LEMSResult();
        Map<String, Object> map = new HashMap<String, Object>(8);
        //查询条件
        map.put("equipmentEx", equipmentEx);
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

        List<Equipment> equipmentList = equipmentMapper.selectEnOrderEquCondition(map);
        //将数据封装至扩展对象
        List<EquipmentEx> laboratoryExList = new ArrayList<EquipmentEx>(equipmentList.size());
        for (Equipment equipment : equipmentList) {
            EquipmentEx equipmentExTmp = new EquipmentEx();
            BeanUtils.copyProperties(equipment, equipmentExTmp);
            //拿到空记录，会导致结果集错乱
            if (equipment.getEquLab() != null) {//检测空记录
                EquLab equLab=equipment.getEquLab();
                if(equLab.getLaboratory()!=null){
                    Laboratory laboratory=equLab.getLaboratory();
                    equipmentExTmp.setLanme(laboratory.getLname());
                }
            }
            laboratoryExList.add(equipmentExTmp);
        }
        result.setData(laboratoryExList);
        result.setStatus(0);
        result.setMessage("获取可预约设备成功");
        return result;
    }

    @Override
    public LEMSResult orderEqu(EquSchedule equSchedule) {
        LEMSResult result = new LEMSResult();
        if (equSchedule != null) {
            Map<String, String> map = new HashMap<String, String>(4);
            map.put("eid", equSchedule.getEid());
            map.put("status", "2");//预约状态
            int upConut = equipmentMapper.updateEquStatusByEid(map);
            if (1 == upConut) {
                int status = equScheduleService.addOrderEqu(equSchedule).getStatus();
                if (0 == status) {
                    result.setStatus(0);
                    result.setMessage("预约成功");
                } else {
                    //回滚数据
                    map.put("status", "0");
                    equipmentMapper.updateEquStatusByEid(map);
                    result.setStatus(2);
                    result.setMessage("预约失败");
                }
            } else {
                result.setStatus(1);
                result.setMessage("更改设备状态失败");
            }
        }
        return result;
    }
}
