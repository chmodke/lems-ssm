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
import java.util.List;
import java.util.Map;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class TestUserDao {
	@Resource
	UserMapper userMapper;
	@Test
	public void testGetUserByUid(){
		User user=userMapper.selectByPrimaryKey("9999");
		System.out.println(user.getTureName());
	}

	@Test
	public void testGetUserByUname(){
		User user=userMapper.selectByName("admin");
		System.out.println(user.getTureName());
	}
	@Test
	public void testUpdateTokenByUid(){
        Map<String,Object> data=new HashMap<String ,Object>();
        String temp=CodeUtil.createId();
        System.out.println(temp);
        data.put("uid","9999");
        data.put("token",temp);
		int ststus=userMapper.updateTokenByUid(data);
		System.out.println(ststus);
	}
	@Test
	public void testSelectUserByEmail(){
	    User user=userMapper.selectByEmail("admin@xx.com");
        System.out.println(user.getUid());
    }
    @Test
    public void selectURloeByUid (){
        User user = userMapper.selectURloeByUid("9999");
        System.out.println(user.getUserRole().getRid());
    }
    @Test
    public void selectRloeByUid(){
	    User user=userMapper.selectRloeByUid("9999");
        System.out.println(user.getUserRole().getRole().getRname());
    }
    @Test
	public void selectUserCondition (){
        Map map=new HashMap();
        map.put("startRec",0);
        map.put("recCount",5);
        map.put("sort","uname");
        map.put("order","asc");
        List<User> userList=userMapper.selectUserCondition(map);
        for(User u:userList){
            System.out.println(u.getUname());
        }
    }
}
