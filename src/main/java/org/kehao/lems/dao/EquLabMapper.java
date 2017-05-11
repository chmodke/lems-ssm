package org.kehao.lems.dao;

import org.kehao.lems.entity.EquLab;

public interface EquLabMapper {
    int insert(EquLab record);

    int insertSelective(EquLab record);

    EquLab selectEquLabByEid(String eid);

    EquLab selectEquLabByLid(String lid);

    int updateEquLabLidByEid(EquLab equLab);
}