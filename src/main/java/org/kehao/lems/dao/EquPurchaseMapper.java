package org.kehao.lems.dao;

import org.kehao.lems.entity.EquPurchase;

public interface EquPurchaseMapper {
    int deleteByPrimaryKey(String epid);

    int insert(EquPurchase record);

    int insertSelective(EquPurchase record);

    EquPurchase selectByPrimaryKey(String epid);

    int updateByPrimaryKeySelective(EquPurchase record);

    int updateByPrimaryKey(EquPurchase record);
}