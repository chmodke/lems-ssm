package org.kehao.lems.dao;

import org.kehao.lems.entity.Laboratory;

import java.util.List;
import java.util.Map;

public interface LaboratoryMapper {
    int deleteByPrimaryKey(String lid);

    int insert(Laboratory record);

    int insertSelective(Laboratory record);

    Laboratory selectByPrimaryKey(String lid);

    int updateByPrimaryKeySelective(Laboratory record);

    int updateByPrimaryKey(Laboratory record);

    /**
     * 查询实验室，搜索功能接口
     * @param map
     * @return
     */
    List<Laboratory> selectLaboratoryCondition(Map map);

    /**
     * 查询实验室，搜索功能接口
     * @param map
     * @return
     */
    Long selectLaboratoryConditionCount(Map map);

    /**
     * 更新实验室状态为删除
     * @param map
     * @return
     */
    int updateLabStatusByLid(Map map);

    Laboratory selectLabEquUserByLid(String lid);

    Laboratory selectLabUserByLid(String lid);
}