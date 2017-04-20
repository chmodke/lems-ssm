package org.kehao.lems.dao;

import org.kehao.lems.entity.LabSchedule;

public interface LabScheduleMapper {
    int deleteByPrimaryKey(String slid);

    int insert(LabSchedule record);

    int insertSelective(LabSchedule record);

    LabSchedule selectByPrimaryKey(String slid);

    int updateByPrimaryKeySelective(LabSchedule record);

    int updateByPrimaryKey(LabSchedule record);
}