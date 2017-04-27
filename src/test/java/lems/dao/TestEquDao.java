package lems.dao;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kehao.lems.dao.EquipmentMapper;
import org.kehao.lems.entity.Equipment;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class TestEquDao {
    @Resource
    EquipmentMapper equipmentMapper;
    @Test
    public void testGetSelectEquJionPurcByEid(){
        Equipment equipment=equipmentMapper.selectEquJionPurcByEid("9999");
        System.out.println(equipment.getEquPurchase().getUid());
    }
}
