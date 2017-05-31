package org.kehao.lems.web.interceptor;

import org.apache.log4j.Logger;
import org.kehao.lems.annotation.EnableLog;
import org.kehao.lems.entity.User;
import org.kehao.lems.service.UserService;
import org.kehao.lems.utils.JsonUtil;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;


/**
 * Created by kehao on 17-5-17.
 */
public class LoginIntercepter implements HandlerInterceptor {
    @Resource
    UserService userService;
    @EnableLog
    private Logger logger;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String uid = request.getParameter("auth_uid");
        String token = request.getParameter("auth_token");
        User user = (User) userService.getUserByUid(uid).getData();
        if (user != null && token.equals(user.getToken())) {
            logger.info(uid + "：" + "200:" + request.getRequestURI());
            return true;
        } else {
            Writer out = response.getWriter();
            Map map = new HashMap(8);
            map.put("total", 0);
            map.put("rows", "");
            map.put("status", 9);
            map.put("message", "530,您没有登录");
            out.write(JsonUtil.objectToJson(map));
            logger.info(uid + "：" + "530:" + request.getRequestURI());
            return false;
        }
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
