package org.kehao.lems.web.controller.lab;

import org.kehao.lems.entity.Laboratory;
import org.kehao.lems.entity.User;
import org.kehao.lems.entity.extend.LaboratoryEx;
import org.kehao.lems.service.LabService;
import org.kehao.lems.utils.LEMSResult;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
        data.put("rows", labService.labGet(page,rows,order,sort,laboratoryEx).getData());
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
        data.put("rows", labService.searchLab(page, rows, order, sort, laboratoryEx).getData());
        return data;
    }
    @RequestMapping("/lab_mgr_list.do")
    @ResponseBody
    public Map<String,Object> mgr_get_Lib(Integer page, Integer rows, String order, String sort, LaboratoryEx laboratoryEx){
        Map<String,Object> data = new HashMap<String,Object>();
        data.put("total", labService.labGetCount(laboratoryEx));
        data.put("rows", labService.labGet(page,rows,order,sort,laboratoryEx).getData());
        return data;
    }
}
