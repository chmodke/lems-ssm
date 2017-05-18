package org.kehao.lems.web.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by kehao on 2016/11/28 22:35.
 * Class LoginInterceptor
 * Description:
 */
public class AuthInterceptor implements HandlerInterceptor {
    //TODO :访问拦截器
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
       HttpSession session=request.getSession();
       String uid=session.getAttribute("uid");
       String path=request.get...();
       List<String> resources=userService.getUserResources(String uid);
       LEMSResult result=new LEMSResult();
       if(-1==resources.indexOf(path)){
           Writer out=response.getWriter();
           result.setStatus(9);
           result.setMessage("您无权操作");
           out.write(result.toJSON());
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