package org.kehao.lems.web.controller.lab;

import org.kehao.lems.entity.Laboratory;
import org.kehao.lems.entity.User;
import org.kehao.lems.service.LabService;
import org.kehao.lems.utils.LEMSResult;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
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
     * @param laboratory 查询条件
     * @return
     */
    @RequestMapping("/lab_list.do")
    @ResponseBody
    public Map<String,Object> getLib(Integer page, Integer rows, String order, String sort, Laboratory laboratory){
        Map<String,Object> data = new HashMap<String,Object>();
        data.put("rows", labService.labGet(page,rows,order,sort,laboratory).getData());
        data.put("total", labService.labGetCount(laboratory));
        return data;
    }
}
