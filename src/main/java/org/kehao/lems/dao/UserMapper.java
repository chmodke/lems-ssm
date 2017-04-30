package org.kehao.lems.dao;

import java.util.Map;

import org.kehao.lems.entity.User;

public interface UserMapper{
    int deleteByPrimaryKey(String uid);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(String uid);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    //---------------------

    /**
     * 根据用户名查询用户
     * @param uname
     * @return
     */
    User selectByName(String uname);

    /**
     * 根据用户uid修改用户token
     * @param data
     * @return
     */
    int updateTokenByUid(Map<String, Object> data);

    /**
     * 根据用户名email查询用户
     * @param email
     * @return
     */
    User selectByEmail(String email);

    /**
     * 根据用户名修改用户记录
     * @param record
     * @return
     */
    int updateByUserNameSelective(User record);

    /**
     * 根据用户uid查询，查询此用户的权限rid
     * @param uid
     * @return
     */
    User selectURloeByUid(String uid);

    /**
     * 根据用户uid查询，查询此用户的权限
     * @param uid
     * @return
     */
    User selectRloeByUid(String uid);
}