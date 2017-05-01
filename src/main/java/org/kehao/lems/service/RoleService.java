package org.kehao.lems.service;

import org.kehao.lems.entity.Role;
import org.kehao.lems.utils.LEMSResult;


/**
 * Created by kehao on 2017/4/20.
 */
public interface RoleService {

    /**
     * 添加角色方法
     * @param role
     * @return
     */
    LEMSResult roleAdd(Role role);

    /**
     * 校验角色名是否存在
     * @param rname
     * @return
     */
    LEMSResult roleaddValidation(String rname);
}
