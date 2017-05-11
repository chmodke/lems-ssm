package org.kehao.lems.dao;

import org.kehao.lems.entity.EquBreak;

import java.util.List;
import java.util.Map;

public interface EquBreakMapper {
    int deleteByPrimaryKey(String bid);

    int insert(EquBreak record);

    int insertSelective(EquBreak record);

    EquBreak selectByPrimaryKey(String bid);

    int updateByPrimaryKeySelective(EquBreak record);

    int updateByPrimaryKey(EquBreak record);

    List<EquBreak> selectEquBreakByCondition(Map map);

    Long selectEquBreakByConditionCount(Map map);

    int updateBrkStatusByBid(Map map);
}