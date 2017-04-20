package org.kehao.lems.dao;

import org.kehao.lems.entity.UserRole;

public interface UserRoleMapper {
    int insert(UserRole record);

    int insertSelective(UserRole record);
}