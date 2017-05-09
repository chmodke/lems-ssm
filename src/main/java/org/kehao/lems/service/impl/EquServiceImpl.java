package org.kehao.lems.service.impl;

import org.kehao.lems.dao.EquipmentMapper;
import org.kehao.lems.entity.EquLab;
import org.kehao.lems.entity.Equipment;
import org.kehao.lems.entity.Laboratory;
import org.kehao.lems.entity.extend.EquipmentEx;
import org.kehao.lems.entity.extend.LaboratoryEx;
import org.kehao.lems.service.EquService;
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
 * Created by hao on 2017/04/27.
 */
@Service("equService")
public class EquServiceImpl implements EquService {
    @Resource
    EquipmentMapper equipmentMapper;
    public LEMSResult equAdd(Equipment equipment) {
        LEMSResult result=new LEMSResult();
        equipment.setEid(CodeUtil.createId());
        equipment.setAddtime(new Timestamp(System.currentTimeMillis()));
        equipment.setStatus(0);
        if(equipmentMapper.insertSelective(equipment)==1){
            result.setStatus(0);
            result.setMessage("设备部分完成");
        }else {
            result.setStatus(1);
            result.setMessage("设备部分失败");
        }
        return result;
    }

    @Override
    public LEMSResult labGet(Integer page, Integer pageSize, String order, String sort,  EquipmentEx equipmentEx) {
        LEMSResult result=new LEMSResult();
        Map<String,Object> map=new HashMap<String, Object>(8);
        //查询条件
        map.put("equipmentEx",equipmentEx);
        //分页
        if(null==page){
            page=1;
        }
        if(null==pageSize){
            pageSize=5;
        }
        map.put("startRec",pageSize*(page-1));//5*(1-1)=0,,5*(2-1)=5
        map.put("recCount",pageSize);
        //映射排序字段
        if(sort.equals("id")){
            sort="equ.id";
        }
        if(sort.equals("type")){
            sort="equ.type";
        }
        if(sort.equals("status")){
            sort="equ.status";
        }
        //排序
        map.put("order",order);
        map.put("sort",sort);

        List<Equipment> equipmentList=equipmentMapper.selectEquipmentCondition(map);
        //将数据封装至扩展对象
        List<EquipmentEx> equipmentExList=new ArrayList<EquipmentEx>(equipmentList.size());
        for(Equipment equipment:equipmentList){
            EquipmentEx equipmentExTmp = new EquipmentEx();
            BeanUtils.copyProperties(equipment,equipmentExTmp);
            //拿到空记录，会导致结果集错乱
            if(equipment.getEquLab()!=null){//检测空记录
                EquLab equLab=equipment.getEquLab();
                if(equLab.getLaboratory()!=null){
                    equipmentExTmp.setLid(equLab.getLaboratory().getLid());
                    equipmentExTmp.setLanme(equLab.getLaboratory().getLname());
                }
            }
            equipmentExList.add(equipmentExTmp);
        }
        result.setData(equipmentExList);
        result.setStatus(0);
        return result;
    }

    @Override
    public Long labGetCount(EquipmentEx equipmentEx) {
        Map<String,Object> map=new HashMap<String, Object>(8);
        //查询条件
        map.put("equipmentEx",equipmentEx);
        return equipmentMapper.selectEquipmentConditionCount(map);
    }
}
