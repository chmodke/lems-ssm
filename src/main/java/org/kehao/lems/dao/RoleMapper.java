package org.kehao.lems.dao;

import org.kehao.lems.entity.Role;

import java.util.List;

public interface RoleMapper {
    int deleteByPrimaryKey(Integer rid);

    int insert(Role record);

    int insertSelective(Role record);

    Role selectByPrimaryKey(Integer rid);

    int updateByPrimaryKeySelective(Role record);

    int updateByPrimaryKey(Role record);

    /**
     * 根据权限rid查询，此权限下有哪些用户uid
     * @param rid
     * @return
     */
    Role selectURloeByRid(String rid);

    /**
     * 根据权限rid查询，此权限下有哪些用户
     * @param rid
     * @return
     */
    Role selectUserByRid(String rid);

    /**
     * 根据角色名查询角色
     * @param rname
     * @return
     */
    Role selectByRname(String rname);

    List<Role> selectAllRole();
}