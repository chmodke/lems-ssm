package org.kehao.lems.service;

import org.kehao.lems.entity.EquPurchase;
import org.kehao.lems.utils.LEMSResult;

/**
 * Created by hao on 2017/04/27.
 */
public interface EquPurcService {
    /**
     * 设备采购采购表部分
     * @return
     */
    LEMSResult equPurcAdd(EquPurchase equPurchase);

    /**
     * 设备采购采购表部分_删除
     * @param pcid
     * @return
     */
    LEMSResult equPurcDel(String pcid);
}
