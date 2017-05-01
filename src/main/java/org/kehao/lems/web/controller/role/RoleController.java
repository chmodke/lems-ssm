package org.kehao.lems.web.controller.role;

import org.kehao.lems.entity.Role;
import org.kehao.lems.service.RoleService;
import org.kehao.lems.utils.LEMSResult;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

@Controller
@RequestMapping("/role")
public class RoleController {
	@Resource
	private RoleService roleService;

    /**
     * 添加角色
     * @param role
     * @return
     */
	@RequestMapping("/roleadd.do")
	@ResponseBody
	public LEMSResult roleAdd(Role role){
        return roleService.roleAdd(role);
	}

    /**
     * 添加角色中角色名校验
     * @param rname
     * @return
     */
    @RequestMapping("/roleadd_validation.do")
	@ResponseBody
	public LEMSResult roleaddValidation(String rname){
		return roleService.roleaddValidation(rname);
	}

}
