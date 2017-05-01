package org.kehao.lems.service.impl;

import org.kehao.lems.dao.RoleMapper;
import org.kehao.lems.entity.Role;
import org.kehao.lems.service.RoleService;
import org.kehao.lems.utils.CodeUtil;
import org.kehao.lems.utils.LEMSResult;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by kehao on 2017/5/1.
 */
@Service("roleService")
public class RoleServiceImpl implements RoleService {
    @Resource
    RoleMapper roleMapper;

    public LEMSResult roleAdd(Role role) {
        LEMSResult result=new LEMSResult();
        role.setRid(Integer.valueOf(CodeUtil.createCode(9)));
        if(1==(roleMapper.insertSelective(role))){
            result.setStatus(0);
            result.setMessage("添加角色成功");
        }else{
            result.setStatus(1);
            result.setMessage("添加角色失败");
        }
        return result;
    }

    public LEMSResult roleaddValidation(String rname) {
        LEMSResult result=new LEMSResult();
        Role role=roleMapper.selectByRname(rname);
        if(role==null){
            result.setStatus(0);
            result.setMessage("角色名可用");
        }else{
            result.setStatus(1);
            result.setMessage("角色名不可用");
        }
        return result;
    }
}
