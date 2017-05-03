package org.kehao.lems.web.controller.equ;

import javax.annotation.Resource;

import org.kehao.lems.entity.EquPurchase;
import org.kehao.lems.entity.Equipment;
import org.kehao.lems.service.EquPurcService;
import org.kehao.lems.service.EquService;
import org.kehao.lems.utils.LEMSResult;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 * Created by kehao on 2017/4/26.
 */
@Controller
@RequestMapping("/equ")
public class EquController {
    @Resource
    private EquService equService;
    @Resource
    private EquPurcService equPurcService;
    /**
     * 添加设备
     * @param equipment
     * @return
     */
    @RequestMapping("/equadd.do")
    @ResponseBody
    public LEMSResult equAdd(Equipment equipment){
        LEMSResult result;

        EquPurchase equPurchase=new EquPurchase();
        equPurchase.setUid(equipment.getEquPurchase().getUid());
        equPurchase.setPrice(equipment.getEquPurchase().getPrice());
        equPurchase.setPctime(equipment.getEquPurchase().getPctime());

        result=equPurcService.equPurcAdd(equPurchase);
        String pcid=(String)result.getData();
        if(result.getStatus()!=0){
            result.setStatus(1);
            result.setMessage("pc添加失败");
        }else {
            equipment.setPcid(pcid);
            result=equService.equAdd(equipment);
            if(result.getStatus()==0){
                result.setStatus(0);
                result.setMessage("添加成功");
            }else{
                equPurcService.equPurcDel(pcid);//如果添加设备失败，删除采购表中的记录
                result.setStatus(2);
                result.setMessage("equ添加失败");
            }
        }
        return result;
    }
}
