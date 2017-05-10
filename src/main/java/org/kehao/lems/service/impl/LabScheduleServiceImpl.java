package org.kehao.lems.service.impl;

import org.kehao.lems.dao.LabScheduleMapper;
import org.kehao.lems.entity.LabSchedule;
import org.kehao.lems.service.LabScheduleService;
import org.kehao.lems.utils.CodeUtil;
import org.kehao.lems.utils.LEMSResult;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by hao on 2017/05/10.
 */
@Service("labScheduleService")
public class LabScheduleServiceImpl implements LabScheduleService{
    @Resource
    LabScheduleMapper labScheduleMapper;

    /**
     * 预约实验室
     * @param labSchedule
     * @return
     */
    @Override
    public LEMSResult addOrderLab(LabSchedule labSchedule) {
        LEMSResult result=new LEMSResult();
        labSchedule.setSlid(CodeUtil.createId());
        int upCount =labScheduleMapper.insertSelective(labSchedule);
        if(1==upCount){
            result.setStatus(0);
            result.setMessage("预约成功");
        }else {
            result.setStatus(1);
            result.setMessage("预约失败");
        }
        return result;
    }
}
