package org.kehao.lems.dao;

import org.kehao.lems.entity.RolePermission;

public interface RolePermissionMapper {
    int insert(RolePermission record);

    int insertSelective(RolePermission record);
}