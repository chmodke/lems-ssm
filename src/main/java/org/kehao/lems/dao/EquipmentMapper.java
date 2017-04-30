package org.kehao.lems.dao;

import org.kehao.lems.entity.Equipment;

public interface EquipmentMapper {
    int deleteByPrimaryKey(String eid);

    int insert(Equipment record);

    int insertSelective(Equipment record);

    Equipment selectByPrimaryKey(String eid);

    int updateByPrimaryKeySelective(Equipment record);

    int updateByPrimaryKey(Equipment record);

    Equipment selectEquJionPurcByEid(String eid);
}