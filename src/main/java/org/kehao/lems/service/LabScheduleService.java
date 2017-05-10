package org.kehao.lems.service;

import org.kehao.lems.entity.LabSchedule;
import org.kehao.lems.utils.LEMSResult;

/**
 * Created by hao on 2017/05/10.
 */
public interface LabScheduleService {
    LEMSResult addOrderLab(LabSchedule labSchedule);
}
