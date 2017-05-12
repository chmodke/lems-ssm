package org.kehao.lems.service;

import org.kehao.lems.entity.EquSchedule;
import org.kehao.lems.entity.LabSchedule;
import org.kehao.lems.entity.extend.EquScheduleEx;
import org.kehao.lems.entity.extend.LabScheduleEx;
import org.kehao.lems.utils.LEMSResult;

/**
 * Created by hao on 2017/05/10.
 */
public interface EquScheduleService {
    /**
     * 预约设备
     * @param equSchedule
     * @return
     */
    LEMSResult addOrderEqu(EquSchedule equSchedule);

    /**
     * 已预约设备列表
     * @param page
     * @param pageSize
     * @param order
     * @param sort
     * @param equScheduleEx
     * @return
     */
    LEMSResult getEquSchInfo(Integer page, Integer pageSize, String order, String sort, EquScheduleEx equScheduleEx);

    /**
     * 已预约设备数量
     * @param equScheduleEx
     * @return
     */
    Long getEquSchInfoCount(EquScheduleEx equScheduleEx);
}
