package org.kehao.lems.dao;

import org.kehao.lems.entity.UserRole;

import java.util.List;

public interface UserRoleMapper {
    int insert(UserRole record);

    int insertSelective(UserRole record);

    List<UserRole> selectRloeByURId(String rid);

    List<UserRole> selectUserByURId(String rid);

    int deleteByUid(String uid);
    int deleteByRid(String rid);
}