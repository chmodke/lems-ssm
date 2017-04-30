package lems.dao;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kehao.lems.dao.EquPurchaseMapper;
import org.kehao.lems.entity.EquPurchase;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class TestPurcDao {
    @Resource
    EquPurchaseMapper equPurchaseMapper;
    @Test
    public void testGetSelectPurcJionEquByEid(){
        EquPurchase equPurchase=equPurchaseMapper.selectEquPurcJionPurcByPcid("79e142a75ba3492ca528c390863f3b93");
        System.out.println(equPurchase.getEquipment().getEname());
    }
}
