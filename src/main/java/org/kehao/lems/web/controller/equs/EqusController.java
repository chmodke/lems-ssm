package org.kehao.lems.web.controller.equs;

import org.kehao.lems.entity.extend.EquScheduleEx;
import org.kehao.lems.entity.extend.LabScheduleEx;
import org.kehao.lems.service.EquScheduleService;
import org.kehao.lems.service.LabScheduleService;
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
@RequestMapping("/equs")
public class EqusController {
    @Resource
    EquScheduleService equScheduleService;
    @RequestMapping("/ordered_equ_list.do")
    @ResponseBody
    public Map<String,Object> orderLab(Integer page, Integer rows, String order, String sort, EquScheduleEx equScheduleEx){
        Map<String,Object> data = new HashMap<String,Object>();
        data.put("total", equScheduleService.getEquSchInfoCount(equScheduleEx));
        data.put("rows", equScheduleService.getEquSchInfo(page,rows,order,sort,equScheduleEx).getData());
        return data;
    }

}
