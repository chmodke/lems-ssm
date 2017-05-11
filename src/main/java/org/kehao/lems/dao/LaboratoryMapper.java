package org.kehao.lems.dao;

import org.kehao.lems.entity.Laboratory;
import org.kehao.lems.entity.extend.LaboratoryEx;

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
     * 查询实验室，列表功能接口
     *
     * @param map
     * @return
     */
    List<Laboratory> selectLaboratoryCondition(Map map);

    /**
     * 查询实验室，搜索功能接口
     *
     * @param map
     * @return
     */
    Long selectLaboratoryConditionCount(Map map);

    /**
     * 更新实验室状态
     *
     * @param map Map[statsus,list]
     * @return
     */
    int updateLabStatusByLidBatch(Map map);


    /**
     * Test
     */
    Laboratory selectLabEquByCondition(String lid);

    /**
     * 查询实验室设备状态
     *
     * @param map
     * @return
     */
    List<Laboratory> selectLabEquUserByCondition(Map map);

    /**
     * 查询实验室设备状态记录数量
     *
     * @param map
     * @return
     */
    Long selectLabEquUserByConditionCount(Map map);

    /**
     * 查询实验室负责人
     *
     * @param lid
     * @return
     */
    Laboratory selectLabUserByLid(String lid);

    /**
     * 可预约实验室列表
     * @param map
     * @return
     */
    List<Laboratory> selectEnOrderLabCondition(Map map);

    /**
     * 可预约实验室数量
     * @param map
     * @return
     */
    Long selectEnOrderLabConditionCount(Map map);

    /**
     * 更新实验室状态
     * @param map Map[status,lid]
     * @return
     */
    int updateLabStatusByLid(Map<String,String > map);

    /**
     * @param map Map[lid,uid]
     * @return
     */
    int updateLabUidByLid(Map<String,String > map);

    /**
     * @return
     */
    List<Laboratory>selectAllLab();
}