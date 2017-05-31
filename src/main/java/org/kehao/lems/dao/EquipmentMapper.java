package org.kehao.lems.dao;

import org.kehao.lems.entity.Equipment;

import java.util.List;
import java.util.Map;

public interface EquipmentMapper {
    int deleteByPrimaryKey(String eid);

    int insert(Equipment record);

    int insertSelective(Equipment record);

    Equipment selectByPrimaryKey(String eid);

    int updateByPrimaryKeySelective(Equipment record);

    int updateByPrimaryKey(Equipment record);

    /**
     * 查询设备信息及采购信息
     * @param eid
     * @return
     */
    Equipment selectEquJionPurcByEid(String eid);

    /**
     * 条件查询设备
     * @param map Map[sort,order,startRec,endRec,EquipmentEx]
     * @return
     */
    List<Equipment> selectEquipmentCondition(Map map);

    /**
     * 条件查询设备数量
     * @param map Map[EquipmentEx]
     * @return
     */
    Long selectEquipmentConditionCount(Map map);

    /**
     * 更新设备状态
     * @param map Map [status,list]
     * @return
     */
    int updateEquStatusByEidBatch(Map map);

    /**
     * 获取可预约设备数量
     * @param map
     * @return
     */
    Long selectEnOrderEquConditionCount(Map map);

    /**
     * 获取可预约设备列表
     * @param map
     * @return
     */
    List<Equipment> selectEnOrderEquCondition(Map map);

    /**
     * 更新设备状态
     * @param map
     * @return
     */
    int updateEquStatusByEid(Map map);
}