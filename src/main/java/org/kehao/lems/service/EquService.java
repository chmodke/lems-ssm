package org.kehao.lems.service;

import org.kehao.lems.entity.Equipment;
import org.kehao.lems.utils.LEMSResult;

/**
 * Created by hao on 2017/04/27.
 */
public interface EquService {
    /**
     * 添加采购设备，设备表部分
     * @param equipment
     * @return
     */
    LEMSResult equAdd(Equipment equipment);
//    LEMSResult equDel(String eid);
}
