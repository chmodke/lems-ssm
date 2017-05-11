package org.kehao.lems.dao;

import org.kehao.lems.entity.LabSchedule;

import java.util.List;
import java.util.Map;

public interface LabScheduleMapper {
    int deleteByPrimaryKey(String slid);

    int insert(LabSchedule record);

    int insertSelective(LabSchedule record);

    LabSchedule selectByPrimaryKey(String slid);

    int updateByPrimaryKeySelective(LabSchedule record);

    int updateByPrimaryKey(LabSchedule record);

    /**
     * 预约实验室列表
     * @param map
     * @return
     */
    List<LabSchedule> selectLabSchInfoByCondition(Map map);
    /**
     * 预约实验室数量
     * @param map
     * @return
     */
    Long selectLabSchInfoByConditionCount(Map map);
}