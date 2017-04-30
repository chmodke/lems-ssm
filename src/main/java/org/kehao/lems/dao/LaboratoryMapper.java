package org.kehao.lems.dao;

import org.kehao.lems.entity.Laboratory;

public interface LaboratoryMapper {
    int deleteByPrimaryKey(String lid);

    int insert(Laboratory record);

    int insertSelective(Laboratory record);

    Laboratory selectByPrimaryKey(String lid);

    int updateByPrimaryKeySelective(Laboratory record);

    int updateByPrimaryKey(Laboratory record);
}