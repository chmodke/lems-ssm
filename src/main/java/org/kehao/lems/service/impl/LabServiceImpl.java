package org.kehao.lems.service.impl;

import org.kehao.lems.dao.LaboratoryMapper;
import org.kehao.lems.entity.Laboratory;
import org.kehao.lems.service.LabService;
import org.kehao.lems.utils.CodeUtil;
import org.kehao.lems.utils.LEMSResult;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.Timestamp;

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
}
