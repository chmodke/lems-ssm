package org.kehao.lems.dao;

import org.kehao.lems.entity.User;

public interface UserMapper{
    int deleteByPrimaryKey(String uid);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(String uid);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    //---------------------

    User selectByName(String uname);
}