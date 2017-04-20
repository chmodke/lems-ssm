package org.kehao.lems.dao;

import org.kehao.lems.entity.Resources;

public interface ResourcesMapper {
    int deleteByPrimaryKey(String rsid);

    int insert(Resources record);

    int insertSelective(Resources record);

    Resources selectByPrimaryKey(String rsid);

    int updateByPrimaryKeySelective(Resources record);

    int updateByPrimaryKey(Resources record);
}