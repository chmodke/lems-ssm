package org.kehao.lems.service.impl;

import org.kehao.lems.dao.EquipmentMapper;
import org.kehao.lems.entity.Equipment;
import org.kehao.lems.service.EquService;
import org.kehao.lems.utils.CodeUtil;
import org.kehao.lems.utils.LEMSResult;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.Timestamp;

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
}
