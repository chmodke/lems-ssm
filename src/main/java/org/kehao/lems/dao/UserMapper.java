package org.kehao.lems.dao;

import java.util.List;
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

    /**
     * 查询用户，搜索功能接口
     * @return
     */
    List<User> selectUserCondition(Map map);
    /**
     * 查询用户数量，搜索功能接口
     * @return
     */
    Long selectUserConditionCount(Map map);

    /**
     * 禁用用户
     * @param map
     * ['status':1]
     * ['list':del_list]
     * @return
     */
    int updateUserStatusByUid(Map map);

    /**
     * 按状态查询所有用户
     * @param status
     * @return
     */
    List<User> selectAllUser(String status);
}