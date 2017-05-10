package org.kehao.lems.service;

import org.kehao.lems.entity.Equipment;
import org.kehao.lems.entity.extend.EquipmentEx;
import org.kehao.lems.utils.LEMSResult;

import java.util.List;

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

    /**
     * 获得条件查询的记录
     * @param page
     * @param rows
     * @param order
     * @param sort
     * @param equipmentEx
     * @return
     */
    LEMSResult labGet(Integer page, Integer rows, String order, String sort, EquipmentEx equipmentEx);

    /**
     * 获得条件查询的记录总数
     * @param equipmentEx
     * @return
     */
    Long labGetCount(EquipmentEx equipmentEx);

    /**
     * 批量删除设备
     * @param delList
     * @return
     */
    LEMSResult equDel(List<String> delList);
}
