package org.kehao.lems.service.impl;

import org.kehao.lems.dao.UserMapper;
import org.kehao.lems.entity.User;
import org.kehao.lems.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by kehao on 2017/4/20.
 */
@Service("userService")
public class UserServiceImpl implements UserService{
    @Resource
    private UserMapper userMapper;

    public User getUserByUid(String uid) {
        return userMapper.selectByPrimaryKey(uid);
    }

    public User getUserByName(String name) {
        return new User();
    }
}
