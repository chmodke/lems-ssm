package org.kehao.lems.web.controller.user;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.kehao.lems.entity.User;
import org.kehao.lems.entity.UserRole;
import org.kehao.lems.entity.extend.UserEx;
import org.kehao.lems.service.UserRoleService;
import org.kehao.lems.service.UserService;
import org.kehao.lems.utils.LEMSResult;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.UnsupportedEncodingException;
import java.util.*;

@Controller
@RequestMapping("/user")
public class UserController {
    @Resource
    private UserService userService;
    @Resource
    private UserRoleService userRoleService;

    /**
     * 通过id获取用户信息，测试使用
     *
     * @param uid
     * @return
     */
    @RequestMapping("/getuserinfo.do")
    @ResponseBody
    public LEMSResult login(String uid) {
        return userService.getUserByUid(uid);
    }

    /**
     * 用户登录，使用请求头传递数据
     *
     * @param request
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping("/login.do")
    @ResponseBody
    public LEMSResult login(HttpServletRequest request) throws UnsupportedEncodingException {
        return userService.checkLogin(request.getHeader("Authorization_login"));
    }

    /**
     * 添加用户
     *
     * @param request
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping("/useradd.do")
    @ResponseBody
    public LEMSResult useradd(HttpServletRequest request) throws UnsupportedEncodingException {
        return userService.userAdd(request.getHeader("Authorization_adduser"));
    }

    /**
     * 添加用户中用户名校验
     *
     * @param uname
     * @return
     */
    @RequestMapping("/useradd_validation.do")
    @ResponseBody
    public LEMSResult useraddValidation(String uname) {
        return userService.useraddValidation(uname);
    }

    /**
     * 修改用户信息
     *
     * @param user
     * @return
     */
    @RequestMapping("/modfifyuserinfo.do")
    @ResponseBody
    public LEMSResult modfifyUserInfo(User user) {
        return userService.modfifyUserInfo(user);
    }

    /**
     * 发送验证码
     *
     * @param uname
     * @return
     */
    @RequestMapping("/send_vali_code.do")
    @ResponseBody
    public LEMSResult sendValiCode(String uname) {
        return userService.sendValiCode(uname);
    }

    /**
     * 校验验证码
     *
     * @param valiCode
     * @return
     */
    @RequestMapping("/vali_vali_code.do")
    @ResponseBody
    public LEMSResult valiCodeValidation(String uname, String valiCode) {
        return userService.valiCodeValidation(uname, valiCode);
    }

    /**
     * 重置用户密码
     *
     * @param request
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping("/rep_user_pwd.do")
    @ResponseBody
    public LEMSResult modifyUserPasswd(HttpServletRequest request) throws UnsupportedEncodingException {
        return userService.modifyUserPasswd(request.getHeader("Authorization_rep_user_passwd"));
    }

    /**
     * 搜索用户
     *
     * @param userEx 搜索条件
     * @return 用户数据列表
     */
    @RequestMapping("/user_list.do")
    @ResponseBody
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    public Map<String,Object> getUserList(Integer page, Integer rows,String order,String sort, UserEx userEx) {
        Map<String,Object> data = new HashMap<String,Object>();
        data.put("total", userService.getUserCount(userEx));
        data.put("rows", userService.getUser(page, rows,order,sort, userEx).getData());
        return data;
    }

    /**
     * 禁用用户
     *
     * @param delList 待删除用户id列表
     * @return
     */
    @RequestMapping("/userdel.do")
    @ResponseBody
    public LEMSResult userDel(String delList) {
        String[] arr=delList.split(" ");
        List<String> list=Arrays.asList(arr);
        return userService.userDel(list);
    }

    @RequestMapping("/get_all_user.do")
    @ResponseBody
    public LEMSResult getAllUser() {
        return userService.getAllUser();
    }


    @RequestMapping("/mod_user_role.do")
    @ResponseBody
    public LEMSResult modUserRole(UserRole userRole) {
        return userRoleService.modUserRole(userRole);
    }

}

