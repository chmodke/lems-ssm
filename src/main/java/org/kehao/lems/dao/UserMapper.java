package org.kehao.lems.dao;

import org.kehao.lems.entity.User;

import java.util.Map;

public interface UserMapper{
    int deleteByPrimaryKey(String uid);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(String uid);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    //---------------------

    User selectByName(String uname);
    int updateTokenByUid(Map<String, Object> data);
    User selectByEmail(String email);
}