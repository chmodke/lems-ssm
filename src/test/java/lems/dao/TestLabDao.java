package lems.dao;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kehao.lems.dao.EquipmentMapper;
import org.kehao.lems.dao.LaboratoryMapper;
import org.kehao.lems.entity.EquLab;
import org.kehao.lems.entity.Equipment;
import org.kehao.lems.entity.Laboratory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class TestLabDao {
    @Resource
    LaboratoryMapper laboratoryMapper;
    @Test
    public void testselectLabEquUserByLid(){
        Laboratory laboratory=laboratoryMapper.selectLabEquUserByLid("0b1533555c0748b4a8e985f7b9e52897");
        List<EquLab> equLabList=laboratory.getEquLab();
        for(EquLab equLab:equLabList){
            System.out.println(equLab.getEquipment().getEquPurchase().getUser().getUname());
        }
    }
    @Test
    public void selectLabUserByLid(){
        Laboratory laboratory=laboratoryMapper.selectLabUserByLid("0b1533555c0748b4a8e985f7b9e52897");
        System.out.println(laboratory.getUser().getUname());
    }
}
