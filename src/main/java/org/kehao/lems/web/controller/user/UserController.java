package org.kehao.lems.web.controller.user;

import javax.annotation.Resource;

import org.kehao.lems.service.UserService;
import org.kehao.lems.utils.LEMSResult;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/user")
public class UserController {
	@Resource
	private UserService userService;
	@RequestMapping("/login.do")
	@ResponseBody
	public LEMSResult login(String id){
		LEMSResult result=new LEMSResult();
		result.setData(userService.getUserByUid(id));
		result.setStatus(0);
		result.setMessage("success");
		return result;
	}
}
