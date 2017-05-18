package org.kehao.lems.web.interceptor;

import org.kehao.lems.utils.JsonUtil;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by kehao on 2017/05/17 .
 * Class AuthIntercepter
 * Description:
 */
public class AuthIntercepter implements HandlerInterceptor {
    //TODO  request controller interceptor
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
       HttpSession session=request.getSession();
       Object uid=session.getAttribute("uid");
       String path=request.getContextPath();
       List<String> resources=null/*userService.getUserResources(String uid)*/;
       if(-1==resources.indexOf(path)){
           Writer out=response.getWriter();
           Map map=new HashMap();
           map.put("total",0);
           map.put("rows",null);
           map.put("status",9);
           map.put("message","503,您没有访问权限");
           out.write(JsonUtil.objectToJson(map));
           //TODO response ObjectToJson
           return false;
       }else{
           return true;
       }
    }

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}