package org.kehao.lems.service.impl;

import org.kehao.lems.dao.EquScheduleMapper;
import org.kehao.lems.dao.LabScheduleMapper;
import org.kehao.lems.entity.*;
import org.kehao.lems.entity.extend.EquScheduleEx;
import org.kehao.lems.entity.extend.EquipmentEx;
import org.kehao.lems.entity.extend.LabScheduleEx;
import org.kehao.lems.service.EquScheduleService;
import org.kehao.lems.service.LabScheduleService;
import org.kehao.lems.utils.CodeUtil;
import org.kehao.lems.utils.LEMSResult;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by hao on 2017/05/10.
 */
@Service("equScheduleService")
public class EquScheduleServiceImpl implements EquScheduleService {
    @Resource
    EquScheduleMapper equScheduleMapper;

    /**
     * 预约设备
     * @param equSchedule
     * @return
     */
    @Override
    public LEMSResult addOrderEqu(EquSchedule equSchedule) {
        LEMSResult result=new LEMSResult();
        equSchedule.setSeid(CodeUtil.createId());
        int upCount =equScheduleMapper.insertSelective(equSchedule);
        if(1==upCount){
            result.setStatus(0);
            result.setMessage("预约成功");
        }else {
            result.setStatus(1);
            result.setMessage("预约失败");
        }
        return result;
    }

    @Override
    public LEMSResult getEquSchInfo(Integer page, Integer pageSize, String order, String sort, EquScheduleEx equScheduleEx) {
        LEMSResult result=new LEMSResult();
        Map<String, Object> map = new HashMap<String, Object>(8);
        //查询条件
        map.put("equScheduleEx", equScheduleEx);
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

        //排序
        map.put("order", order);
        map.put("sort", sort);

        List<EquSchedule> equScheduleList = equScheduleMapper.selectEquSchInfoByCondition(map);
        //将数据封装至扩展对象
        List<EquScheduleEx> equScheduleExList = new ArrayList<EquScheduleEx>(equScheduleList.size());

        for (EquSchedule equSchedule : equScheduleList) {
            EquScheduleEx equScheduleExTmp = new EquScheduleEx();
            BeanUtils.copyProperties(equSchedule, equScheduleExTmp);
            //拿到空记录，会导致结果集错乱
            if (equSchedule.getEquipment() != null) {//检测空记录
                Equipment equipment=equSchedule.getEquipment();
                equScheduleExTmp.setId(equipment.getId());
                equScheduleExTmp.setEname(equipment.getEname());
                equScheduleExTmp.setType(equipment.getType());
                equScheduleExTmp.setRemark(equipment.getRemark());
                if (equipment.getEquLab() != null) {//检测空记录
                    EquLab equLab=equipment.getEquLab();
                    if(equLab.getLaboratory()!=null){
                        Laboratory laboratory=equLab.getLaboratory();
                        equScheduleExTmp.setLname(laboratory.getLname());
                    }
                }
            }
            equScheduleExList.add(equScheduleExTmp);
        }

        result.setData(equScheduleExList);
        result.setStatus(0);
        return result;
    }

    @Override
    public Long getEquSchInfoCount(EquScheduleEx equScheduleEx) {
        LEMSResult result=new LEMSResult();
        Map<String, Object> map = new HashMap<String, Object>(8);
        //查询条件
        map.put("equScheduleEx", equScheduleEx);
        return equScheduleMapper.selectEquSchInfoByConditionCount(map);
    }
}
