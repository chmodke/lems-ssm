package org.kehao.lems.dao;

import org.kehao.lems.entity.UserRole;

import java.util.List;

public interface UserRoleMapper {
    int insert(UserRole record);

    int insertSelective(UserRole record);

    List<UserRole> selectRloeByURId(String rid);

    List<UserRole> selectUserByURId(String rid);

    /**
     * 添加用户失败时回滚事务
     * @param uid
     * @return
     */
    int deleteByUid(String uid);

    /**
     * 更新用户角色时
     * @param uid
     * @return
     */
    UserRole selectUserRoleByUid(String uid);

    int updateRidByUid(UserRole record);
}