package org.kehao.lems.dao;

import org.kehao.lems.entity.EquSchedule;

import java.util.List;
import java.util.Map;

public interface EquScheduleMapper {
    int deleteByPrimaryKey(String seid);

    int insert(EquSchedule record);

    int insertSelective(EquSchedule record);

    EquSchedule selectByPrimaryKey(String seid);

    int updateByPrimaryKeySelective(EquSchedule record);

    int updateByPrimaryKey(EquSchedule record);

    List<EquSchedule> selectEquSchInfoByCondition(Map map);

    Long selectEquSchInfoByConditionCount(Map map);
}