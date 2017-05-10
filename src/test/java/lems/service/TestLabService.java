package lems.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kehao.lems.entity.User;
import org.kehao.lems.entity.extend.LaboratoryEx;
import org.kehao.lems.service.LabService;
import org.kehao.lems.service.UserService;
import org.kehao.lems.utils.LEMSResult;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by kehao on 2017/4/20.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class TestLabService {
    @Resource
    private LabService labService;

    @Test
    public void testSearchLab(){
        LaboratoryEx laboratoryEx=new LaboratoryEx();
        laboratoryEx.setLname("6");
        List<LaboratoryEx> laboratoryExList=(List<LaboratoryEx>) labService.searchLab(null,null,"asc","lab.lname",laboratoryEx).getData();
        for (LaboratoryEx lab:laboratoryExList){
            System.out.println(lab.getLname()+":"+lab.getLab_uname()+":"+lab.getEqu_uname());
        }
    }
    @Test
    public void searchLabCount(){
        LaboratoryEx laboratoryEx=new LaboratoryEx();
        laboratoryEx.setLname("6");
        Long count=(Long)labService.searchLabCount(laboratoryEx);
        System.out.println(count);
    }

}
