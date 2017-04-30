package lems.dao;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kehao.lems.dao.UserRoleMapper;
import org.kehao.lems.entity.UserRole;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class TestUserRoleDao {
	@Resource
	UserRoleMapper userRoleMapper;
    @Test
    public void selectURloeByUid (){
        List<UserRole> userRoleList = userRoleMapper.selectUserByURId("405230015");
        for(UserRole userRole:userRoleList){
            System.out.println(userRole.getUser().getUname());
        }

    }
    @Test
    public void selectRloeByUid(){
		List<UserRole> userRoleList=userRoleMapper.selectRloeByURId("405230015");
        for(UserRole userRole:userRoleList){
            System.out.println(userRole.getRole().getRname());
        }
    }
}
