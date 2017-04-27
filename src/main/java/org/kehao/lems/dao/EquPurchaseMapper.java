package org.kehao.lems.dao;

import org.kehao.lems.entity.EquPurchase;

public interface EquPurchaseMapper {
    int deleteByPrimaryKey(String pcid);

    int insert(EquPurchase record);

    int insertSelective(EquPurchase record);

    EquPurchase selectByPrimaryKey(String pcid);

    int updateByPrimaryKeySelective(EquPurchase record);

    int updateByPrimaryKey(EquPurchase record);

    EquPurchase selectEquPurcJionPurcByPcid(String pcid);
}