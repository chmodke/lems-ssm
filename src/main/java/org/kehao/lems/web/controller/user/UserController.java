package org.kehao.lems.web.controller.user;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.kehao.lems.entity.User;
import org.kehao.lems.service.UserService;
import org.kehao.lems.utils.LEMSResult;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.UnsupportedEncodingException;

@Controller
@RequestMapping("/user")
public class UserController {
	@Resource
	private UserService userService;

    /**
     * 通过id获取用户信息，测试使用
     * @param id
     * @return
     */
	@RequestMapping("/getuser.do")
	@ResponseBody
	public LEMSResult login(String id){
		LEMSResult result=new LEMSResult();
		result.setData(userService.getUserByUid(id));
		result.setStatus(0);
		result.setMessage("success");
		return result;
	}

    /**
     * 明文登录方法，测试使用
     * @param uname
     * @param passwd
     * @return
     */
	/*@RequestMapping("/login1.do")
	@ResponseBody
	public LEMSResult login(String uname,String passwd){
		return userService.validationUser(uname,passwd);
	}*/

    /**
     * 用户登录，使用请求头传递数据
     * @param request
     * @return
     * @throws UnsupportedEncodingException
     */
	@RequestMapping("/login.do")
	@ResponseBody
	public LEMSResult login(HttpServletRequest request) throws UnsupportedEncodingException {
        return userService.checkLogin(request.getHeader("Authorization"));
    }

    /**
     * 添加用户
     * @param request
     * @return
     * @throws UnsupportedEncodingException
     */
	@RequestMapping("/useradd.do")
	@ResponseBody
	public LEMSResult useradd(HttpServletRequest request) throws UnsupportedEncodingException {
		return userService.userAdd(request.getHeader("Authorization"));
	}
}
