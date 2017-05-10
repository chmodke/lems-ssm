package org.kehao.lems.web.controller.equ;

import javax.annotation.Resource;

import org.kehao.lems.entity.EquPurchase;
import org.kehao.lems.entity.Equipment;
import org.kehao.lems.entity.extend.EquipmentEx;
import org.kehao.lems.entity.extend.LaboratoryEx;
import org.kehao.lems.service.EquPurcService;
import org.kehao.lems.service.EquService;
import org.kehao.lems.utils.LEMSResult;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


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
        //此方法设计逻辑有问题，不应该在控制层处理逻辑
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
    @RequestMapping("/equ_list.do")
    @ResponseBody
    public Map<String,Object> getEquList(Integer page, Integer rows, String order, String sort, EquipmentEx equipmentEx){
        Map<String,Object> data = new HashMap<String,Object>();
        data.put("total", equService.labGetCount(equipmentEx));
        data.put("rows", equService.labGet(page, rows, order, sort, equipmentEx).getData());
        return data;
    }
    @RequestMapping("/equdel.do")
    @ResponseBody
    public LEMSResult labDel(String delList){
        String[] arr=delList.split(" ");
        List<String> list= Arrays.asList(arr);
        return equService.equDel(list);
    }
}
