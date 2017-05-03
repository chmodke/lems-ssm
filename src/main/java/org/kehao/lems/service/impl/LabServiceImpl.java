package org.kehao.lems.service.impl;

import org.kehao.lems.dao.LaboratoryMapper;
import org.kehao.lems.entity.Laboratory;
import org.kehao.lems.entity.User;
import org.kehao.lems.service.LabService;
import org.kehao.lems.utils.CodeUtil;
import org.kehao.lems.utils.LEMSResult;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by kehao on 2017/4/26.
 */
@Service("labService")
public class LabServiceImpl implements LabService{
    @Resource
    LaboratoryMapper laboratoryMapper;
    public LEMSResult labAdd(Laboratory laboratory) {
        LEMSResult result=new LEMSResult();
        laboratory.setLid(CodeUtil.createId());
        laboratory.setStatus(0);
        laboratory.setAddtime(new Timestamp(System.currentTimeMillis()));

        System.out.println(laboratory.getId());

        if(laboratoryMapper.insertSelective(laboratory)==1){
            result.setStatus(0);
            result.setMessage("添加实验室成功");
        }else{
            result.setStatus(1);
            result.setMessage("添加实验室失败");
        }
        return result;
    }

    public LEMSResult labGet(Integer page, Integer pageSize, String order, String sort, Laboratory laboratory) {
        LEMSResult result=new LEMSResult();
        Map<String,Object> map=new HashMap<String, Object>(8);
        //查询条件
        if(null!=laboratory.getLname()){
            map.put("lname",laboratory.getLname());
        }
        if(null!=laboratory.getId()){
            map.put("id",laboratory.getId());
        }
        if(null!=laboratory.getType()){
            map.put("type",laboratory.getType());
        }
        //分页
        if(null==page){
            page=1;
        }
        map.put("startRec",pageSize*(page-1));//5*(1-1)=0,,5*(2-1)=5
        if(null==pageSize){
            pageSize=5;
        }
        map.put("recCount",pageSize);
        //排序
        map.put("order",order);
        map.put("sort",sort);

        result.setData(laboratoryMapper.selectLaboratoryCondition(map));
        result.setStatus(0);
        return result;
    }

    public Long labGetCount(Laboratory laboratory) {
        Map<String,Object> map=new HashMap<String, Object>(8);
        //查询条件
        if(null!=laboratory.getLname()){
            map.put("lname",laboratory.getLname());
        }
        if(null!=laboratory.getId()){
            map.put("id",laboratory.getId());
        }
        if(null!=laboratory.getType()){
            map.put("type",laboratory.getType());
        }
        return laboratoryMapper.selectLaboratoryConditionCount(map);
    }
}
