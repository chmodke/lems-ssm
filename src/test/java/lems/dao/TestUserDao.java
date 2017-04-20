package lems.dao;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kehao.lems.dao.UserMapper;
import org.kehao.lems.entity.User;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class TestUserDao {
	@Resource
	UserMapper userMapper;
	@Test
	public void testGetUser(){
		User user=userMapper.selectByPrimaryKey("9999");
		System.out.println(user.getTureName());
	}
}
