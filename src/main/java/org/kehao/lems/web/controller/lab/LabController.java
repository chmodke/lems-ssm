package org.kehao.lems.web.controller.lab;

import org.kehao.lems.entity.LabSchedule;
import org.kehao.lems.entity.Laboratory;
import org.kehao.lems.entity.User;
import org.kehao.lems.entity.extend.LabScheduleEx;
import org.kehao.lems.entity.extend.LaboratoryEx;
import org.kehao.lems.service.LabService;
import org.kehao.lems.utils.LEMSResult;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.*;

/**
 * Created by kehao on 2017/4/26.
 */
@Controller
@RequestMapping("/lab")
public class LabController {
    @Resource
    private LabService labService;
    /**
     * 添加实验室
     * @param laboratory
     * @return
     */
    @RequestMapping("/labadd.do")
    @ResponseBody
    public LEMSResult labAdd(Laboratory laboratory){
        return labService.labAdd(laboratory);
    }

    /**
     * 获取实验室
     * @param page
     * @param rows
     * @param order
     * @param sort
     * @param laboratoryEx 查询条件
     * @return
     */
    @RequestMapping("/lab_list.do")
    @ResponseBody
    public Map<String,Object> getLib(Integer page, Integer rows, String order, String sort, LaboratoryEx laboratoryEx){
        Map<String,Object> data = new HashMap<String,Object>();
        data.put("total", labService.labGetCount(laboratoryEx));
        LEMSResult result=labService.labGet(page,rows,order,sort,laboratoryEx);
        data.put("rows", result.getData());
        data.put("status",result.getStatus());
        data.put("message",result.getMessage());
        return data;
    }
    @RequestMapping("/labdel.do")
    @ResponseBody
    public LEMSResult labDel(String delList){
        String[] arr=delList.split(" ");
        List<String> list= Arrays.asList(arr);
        return labService.labDel(list);
    }
    @RequestMapping("/labsearch.do")
    @ResponseBody
    public Map<String,Object> searchLab(Integer page, Integer rows, String order, String sort, LaboratoryEx laboratoryEx){
        Map<String,Object> data = new HashMap<String,Object>();
        data.put("total", labService.searchLabCount(laboratoryEx));
        LEMSResult result=labService.searchLab(page, rows, order, sort, laboratoryEx);
        data.put("rows", result.getData());
        data.put("status",result.getStatus());
        data.put("message",result.getMessage());
        return data;
    }
    @RequestMapping("/lab_mgr_list.do")
    @ResponseBody
    public Map<String,Object> mgrGetLib(Integer page, Integer rows, String order, String sort, LaboratoryEx laboratoryEx){
        Map<String,Object> data = new HashMap<String,Object>();
        data.put("total", labService.labGetCount(laboratoryEx));
        LEMSResult result=labService.labGet(page,rows,order,sort,laboratoryEx);
        data.put("rows", result.getData());
        data.put("status",result.getStatus());
        data.put("message",result.getMessage());
        return data;
    }
    @RequestMapping("/enorder_lab_list.do")
    @ResponseBody
    public Map<String,Object> enorderLib(Integer page, Integer rows, String order, String sort, LaboratoryEx laboratoryEx){
        Map<String,Object> data = new HashMap<String,Object>();
        data.put("total", labService.enOrderLabCount(laboratoryEx));
        LEMSResult result=labService.enOrderLab(page,rows,order,sort,laboratoryEx);
        data.put("rows", result.getData());
        data.put("status",result.getStatus());
        data.put("message",result.getMessage());
        return data;
    }
    @RequestMapping("/order_lab.do")
    @ResponseBody
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    public LEMSResult orderLab(LabSchedule labSchedule){
        return labService.orderLab(labSchedule);
    }

    @RequestMapping("/mod_mgr_lab.do")
    @ResponseBody
    public LEMSResult modMgrLab(String lid,String uid){
        return labService.modMgrLab(lid,uid);
    }

    @RequestMapping("/get_all_lab.do")
    @ResponseBody
    public LEMSResult getAllLab(){
        return labService.getAllLab();
    }
}
