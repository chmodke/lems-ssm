package lems.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kehao.lems.entity.User;
import org.kehao.lems.service.UserService;
import org.kehao.lems.utils.LEMSResult;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

/**
 * Created by kehao on 2017/4/20.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class TestUserService {
    @Resource
    private UserService userService;

    @Test
    public void testGetUserByUid(){
        LEMSResult result=userService.getUserByUid("9999");
        System.out.println(((User)result.getData()).getTureName());
    }
    @Test
    public void testGetUserByName(){
        LEMSResult result=userService.getUserByName("admin");
        System.out.println(((User)result.getData()).getTureName());
    }

    @Test
    public void testGetUserVali(){
        LEMSResult result=userService.validationUser("admin","123456");
        System.out.println(result.getMessage());
    }

}
