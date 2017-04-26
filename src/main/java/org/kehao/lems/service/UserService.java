package org.kehao.lems.service;

import org.kehao.lems.entity.User;
import org.kehao.lems.utils.LEMSResult;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;

/**
 * Created by kehao on 2017/4/20.
 */
public interface UserService {
    /**
     * 通过用户id获取用户信息
     * @param uid
     * @return
     */
    LEMSResult getUserByUid(String uid);

    /**
     * 通过用户名获取用户信息
     * @param name
     * @return
     */
    LEMSResult getUserByName(String name);

    /**
     * 登录检查方法
     * @param auther
     * @return
     * @throws UnsupportedEncodingException
     */
    LEMSResult checkLogin(String auther)throws UnsupportedEncodingException;

    /**
     * 添加用户方法
     * @param auther
     * @return
     */
    LEMSResult userAdd(String auther)throws UnsupportedEncodingException;

    /**
     * 校验用户名是否存在
     * @param uname
     * @return
     */
    LEMSResult useraddValidation(String uname);
}
