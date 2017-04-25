package lems.dao;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kehao.lems.dao.UserMapper;
import org.kehao.lems.entity.User;
import org.kehao.lems.utils.CodeUtil;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class TestUserDao {
	@Resource
	UserMapper userMapper;
	@Test
	public void testGetUserByUid(){
		User user=userMapper.selectByPrimaryKey("99999");
		System.out.println(user.getTureName());
	}

	@Test
	public void testGetUserByUname(){
		User user=userMapper.selectByName("admin");
		System.out.println(user.getTureName());
	}
	@Test
	public void testUpdateTokenByUid(){
        Map data=new HashMap();
        String temp=CodeUtil.createId();
        System.out.println(temp);
        data.put("uid","9999");
        data.put("token",temp);
		int ststus=userMapper.updateTokenByUid(data);
	}
	@Test
	public void testSelectUserByEmail(){
	    User user=userMapper.selectByEmail("admin@xx.com");
        System.out.println(user.getUid());
    }
}
