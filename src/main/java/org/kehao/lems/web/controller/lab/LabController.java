package org.kehao.lems.web.controller.lab;

import org.kehao.lems.entity.Laboratory;
import org.kehao.lems.service.LabService;
import org.kehao.lems.utils.LEMSResult;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;



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
}
