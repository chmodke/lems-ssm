package lems.utils;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kehao.lems.service.UserService;
import org.kehao.lems.utils.JsonUtil;
import org.kehao.lems.utils.LEMSResult;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by kehao on 17-5-17.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class TestJsonUtil {
    @Resource
    UserService userService;
    @Test
    public void testObjectToJson(){
        LEMSResult result=userService.getUserByUid("30e5ec73716746bf8e6520c5d5c93d6f");
        String json=JsonUtil.objectToJson(result);
        System.out.println(json);
    }

    @Test
    public void testStringToJson(){
        Map map=new HashMap();
        map.put("total",0);
        map.put("rows","");
        map.put("status",9);
        map.put("message","503,您没有登录");
        String json=JsonUtil.objectToJson(map);
        System.out.println(json);
    }
}
