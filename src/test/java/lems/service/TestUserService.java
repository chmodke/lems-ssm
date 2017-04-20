package lems.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kehao.lems.entity.User;
import org.kehao.lems.service.UserService;
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
    public void testGetUser(){
        User user=userService.getUserByUid("9999");
        System.out.println(user.getTureName());
    }

}
