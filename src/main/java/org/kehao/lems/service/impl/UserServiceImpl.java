package org.kehao.lems.service.impl;

import org.kehao.lems.dao.UserMapper;
import org.kehao.lems.entity.User;
import org.kehao.lems.service.UserService;
import org.kehao.lems.utils.LEMSResult;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by kehao on 2017/4/20.
 */
@Service("userService")
public class UserServiceImpl implements UserService{
    @Resource
    private UserMapper userMapper;

    public LEMSResult getUserByUid(String uid) {
        LEMSResult result=new LEMSResult();
        result.setData(userMapper.selectByPrimaryKey(uid));
        return result;
    }

    public LEMSResult getUserByName(String name) {
        LEMSResult result=new LEMSResult();
        result.setData(userMapper.selectByName(name));
        return result;
    }

    public LEMSResult validationUser(String name, String passwd) {
        LEMSResult result=new LEMSResult();
        User user=userMapper.selectByName(name);
        if(user==null){
            result.setMessage("用户名不存在");
            result.setStatus(1);
            return result;
        }else if(passwd.equals(user.getPasswd())){
            //TODO 密码校验算法
            result.setData(user);
            result.setMessage("登录成功");
            result.setStatus(0);
            return result;
        }else {
            result.setMessage("密码不正确");
            result.setStatus(2);
            return result;
        }
    }
}
