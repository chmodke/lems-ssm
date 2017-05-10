package org.kehao.lems.service.impl;

import org.kehao.lems.dao.LabScheduleMapper;
import org.kehao.lems.entity.LabSchedule;
import org.kehao.lems.entity.Laboratory;
import org.kehao.lems.entity.User;
import org.kehao.lems.entity.extend.LabScheduleEx;
import org.kehao.lems.service.LabScheduleService;
import org.kehao.lems.service.LabService;
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

    @Override
    public LEMSResult getLabSchInfo(Integer page, Integer pageSize, String order, String sort, LabScheduleEx labScheduleEx) {
        LEMSResult result=new LEMSResult();
        Map<String, Object> map = new HashMap<String, Object>(8);
        //查询条件
        map.put("labScheduleEx", labScheduleEx);
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

        List<LabSchedule> labScheduleList = labScheduleMapper.selectLabSchInfoByCondition(map);
        //将数据封装至扩展对象
        List<LabScheduleEx> laboratoryExList = new ArrayList<LabScheduleEx>(labScheduleList.size());

        for (LabSchedule labSchedule : labScheduleList) {
            LabScheduleEx labScheduleExTmp = new LabScheduleEx();
            BeanUtils.copyProperties(labSchedule, labScheduleExTmp);
            //拿到空记录，会导致结果集错乱
            if (labSchedule.getLaboratory() != null) {//检测空记录
                Laboratory laboratory=labSchedule.getLaboratory();
                labScheduleExTmp.setId(laboratory.getId());
                labScheduleExTmp.setLname(laboratory.getLname());
                labScheduleExTmp.setType(laboratory.getType());
                labScheduleExTmp.setLsize(laboratory.getLsize());
                labScheduleExTmp.setEqucount(laboratory.getEqucount());
                labScheduleExTmp.setRemark(laboratory.getRemark());
                if(laboratory.getUser()!=null){
                    User user=laboratory.getUser();
                    labScheduleExTmp.setUname(user.getUname());
                }
            }
            laboratoryExList.add(labScheduleExTmp);
        }
        result.setData(laboratoryExList);
        result.setStatus(0);
        return result;
    }

    @Override
    public Long getLabSchInfoCount(LabScheduleEx labScheduleEx) {
        LEMSResult result=new LEMSResult();
        Map<String, Object> map = new HashMap<String, Object>(8);
        //查询条件
        map.put("labScheduleEx", labScheduleEx);
        return labScheduleMapper.selectLabSchInfoByConditionCount(map);
    }
}
