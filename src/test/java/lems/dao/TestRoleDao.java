package lems.dao;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kehao.lems.dao.RoleMapper;
import org.kehao.lems.entity.Role;
import org.kehao.lems.entity.UserRole;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class TestRoleDao {
	@Resource
    RoleMapper roleMapper;
	@Test
    public void selectURloeByRid(){
	    Role role = roleMapper.selectURloeByRid("405230015");
        for(UserRole uRole : role.getUserRole()){
            System.out.println(uRole.getUid());
        }
    }
    @Test
    public void selectUserByRid(){
	    Role role=roleMapper.selectUserByRid("405230015");
	    for(UserRole uRole : role.getUserRole()){
            System.out.println(uRole.getUser().getUname());
        }
    }
}
