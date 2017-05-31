package org.kehao.lems.service.impl;

import org.kehao.lems.dao.UserRoleMapper;
import org.kehao.lems.entity.UserRole;
import org.kehao.lems.service.UserRoleService;
import org.kehao.lems.utils.LEMSResult;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by kehao on 2017/5/13.
 */
@Service("userRoleService")
public class UserRoleServiceImpl implements UserRoleService {
    @Resource
    UserRoleMapper userRoleMapper;
    @Override
    public LEMSResult modUserRole(UserRole userRole) {
        LEMSResult result=new LEMSResult();
        UserRole userRoleTmp=userRoleMapper.selectUserRoleByUid(userRole.getUid());
        int upCount=0;
        if(userRoleTmp==null){
            upCount=userRoleMapper.insert(userRole);
        }else {
            upCount=userRoleMapper.updateRidByUid(userRole);
        }
        if(1==upCount){
            result.setStatus(0);
            result.setMessage("修改成功");
        }else {
            result.setStatus(1);
            result.setMessage("修改失败");
        }
        return result;
    }
}
