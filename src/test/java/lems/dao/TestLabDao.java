package lems.dao;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kehao.lems.dao.LaboratoryMapper;
import org.kehao.lems.entity.EquLab;
import org.kehao.lems.entity.Laboratory;
import org.kehao.lems.entity.extend.LaboratoryEx;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class TestLabDao {
    @Resource
    LaboratoryMapper laboratoryMapper;

    @Test
    public void testSelectLabEquUserByCondition() {
        Map map = new HashMap();

        LaboratoryEx laboratoryEx = new LaboratoryEx();
        laboratoryEx.setLname("6");

        map.put("laboratoryEx", laboratoryEx);
        map.put("startRec",0);//5*(1-1)=0,,5*(2-1)=5
        map.put("recCount",5);
        //排序
        map.put("order","asc");
        map.put("sort","lab.lname");
        List<Laboratory> laboratoryList = laboratoryMapper.selectLabEquUserByCondition(map);
        for(Laboratory laboratory:laboratoryList){
            List<EquLab> equLabList = laboratory.getEquLab();
            for (EquLab equLab : equLabList) {
                System.out.println(equLab.getEquipment().getEquPurchase().getUser().getUname());
            }
        }
    }

    /**
     * Test
     */
    @Test
    public void testSelectLabEquByCondition() {
        Laboratory laboratory = laboratoryMapper.selectLabEquByCondition("5370735eff1f4a25ba5b046baa873c3c");
        List<EquLab> equLabList = laboratory.getEquLab();
        for (EquLab equLab : equLabList) {
            System.out.println(equLab.getLid() + ":" + equLab.getEid());
            System.out.println(equLab.getEquipment().getEname() + ":" + equLab.getEquipment().getRemark());
        }
    }

    @Test
    public void testSelectLabEquUserByConditionCount() {
        LaboratoryEx laboratoryEx = new LaboratoryEx();
        laboratoryEx.setLid("0b1533555c0748b4a8e985f7b9e52897");
        Map<String,Object> map=new HashMap<String, Object>(8);
        //查询条件
        map.put("laboratoryEx",laboratoryEx);
        Long count = laboratoryMapper.selectLabEquUserByConditionCount(map);
        System.out.println(count);
    }

    @Test
    public void selectLabUserByLid() {
        Laboratory laboratory = laboratoryMapper.selectLabUserByLid("0b1533555c0748b4a8e985f7b9e52897");
        System.out.println(laboratory.getUser().getUname());
    }
}
