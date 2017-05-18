package org.kehao.lems.web.controller.equ;

import javax.annotation.Resource;

import org.kehao.lems.entity.*;
import org.kehao.lems.entity.extend.EquBreakEx;
import org.kehao.lems.entity.extend.EquipmentEx;
import org.kehao.lems.service.EquPurcService;
import org.kehao.lems.service.EquScheduleService;
import org.kehao.lems.service.EquService;
import org.kehao.lems.utils.LEMSResult;
import org.springframework.format.annotation.DateTimeFormat;
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
     *
     * @param equipment
     * @return
     */
    @RequestMapping("/equadd.do")
    @ResponseBody
    public LEMSResult equAdd(Equipment equipment) {
        //此方法设计逻辑有问题，不应该在控制层处理逻辑
        LEMSResult result;

        EquPurchase equPurchase = new EquPurchase();
        equPurchase.setUid(equipment.getEquPurchase().getUid());
        equPurchase.setPrice(equipment.getEquPurchase().getPrice());
        equPurchase.setPctime(equipment.getEquPurchase().getPctime());

        result = equPurcService.equPurcAdd(equPurchase);
        String pcid = (String) result.getData();
        if (result.getStatus() != 0) {
            result.setStatus(1);
            result.setMessage("pc添加失败");
        } else {
            equipment.setPcid(pcid);
            result = equService.equAdd(equipment);
            if (result.getStatus() == 0) {
                result.setStatus(0);
                result.setMessage("添加成功");
            } else {
                equPurcService.equPurcDel(pcid);//如果添加设备失败，删除采购表中的记录
                result.setStatus(2);
                result.setMessage("equ添加失败");
            }
        }
        return result;
    }

    @RequestMapping("/equ_list.do")
    @ResponseBody
    public Map<String, Object> getEquList(Integer page, Integer rows, String order, String sort, EquipmentEx equipmentEx) {
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("total", equService.equGetCount(equipmentEx));
        LEMSResult result=equService.equGet(page, rows, order, sort, equipmentEx);
        data.put("rows", result.getData());
        data.put("status",result.getStatus());
        data.put("message",result.getMessage());
        return data;
    }

    @RequestMapping("/equdel.do")
    @ResponseBody
    public LEMSResult labDel(String delList) {
        String[] arr = delList.split(" ");
        List<String> list = Arrays.asList(arr);
        return equService.equDel(list);
    }

    @RequestMapping("/move_equ.do")
    @ResponseBody
    public LEMSResult moveEqu(EquLab equLab) {
        return equService.moveEqu(equLab);
    }

    @RequestMapping("/break_equ.do")
    @ResponseBody
    public LEMSResult breakEqu(EquBreak equBreak) {
        return equService.breakEqu(equBreak);
    }

    @RequestMapping("/break_equ_list.do")
    @ResponseBody
    public Map<String, Object> getBreakEquList(Integer page, Integer rows, String order, String sort, EquBreakEx equBreakEx) {
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("total", equService.labGetBreakCount(equBreakEx));
        LEMSResult result=equService.labGetBreak(page, rows, order, sort, equBreakEx);
        data.put("rows", result.getData());
        data.put("status",result.getStatus());
        data.put("message",result.getMessage());
        return data;
    }

    @RequestMapping("/fixed_equ.do")
    @ResponseBody
    public LEMSResult fixEqu(String bid, String eid) {
        return equService.fixEqu(bid, eid);
    }

    @RequestMapping("/fixed_equ_del.do")
    @ResponseBody
    public LEMSResult fixEquDel(String bid) {
        return equService.fixEquDel(bid);
    }

    @RequestMapping("/enorder_equ_list.do")
    @ResponseBody
    public Map<String,Object> enorderEqu(Integer page, Integer rows, String order, String sort, EquipmentEx equipmentEx) {
        Map<String,Object> data = new HashMap<String,Object>();
        data.put("total", equService.enOrderEquCount(equipmentEx));
        LEMSResult result=equService.enOrderEqu(page,rows,order,sort,equipmentEx);
        data.put("rows", result.getData());
        data.put("status",result.getStatus());
        data.put("message",result.getMessage());
        return data;
    }
    @RequestMapping("/order_equ.do")
    @ResponseBody
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    public LEMSResult orderEqu(EquSchedule equSchedule){
        return equService.orderEqu(equSchedule);
    }
}
