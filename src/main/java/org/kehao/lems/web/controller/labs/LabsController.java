package org.kehao.lems.web.controller.labs;

import org.kehao.lems.entity.extend.LabScheduleEx;
import org.kehao.lems.service.LabScheduleService;
import org.kehao.lems.utils.LEMSResult;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by kehao on 2017/5/10.
 */
@Controller
@RequestMapping("/labs")
public class LabsController {
    @Resource
    LabScheduleService labScheduleService;
    @RequestMapping("/ordered_lab_list.do")
    @ResponseBody
    public Map<String,Object> orderLab(Integer page, Integer rows, String order, String sort, LabScheduleEx labScheduleEx){
        Map<String,Object> data = new HashMap<String,Object>();
        data.put("total", labScheduleService.getLabSchInfoCount(labScheduleEx));
        LEMSResult result=labScheduleService.getLabSchInfo(page,rows,order,sort,labScheduleEx);
        data.put("rows", result.getData());
        data.put("status",result.getStatus());
        data.put("message",result.getMessage());
        return data;
    }
}
