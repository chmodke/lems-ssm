package org.kehao.lems.service.impl;

import org.kehao.lems.dao.EquPurchaseMapper;
import org.kehao.lems.entity.EquPurchase;
import org.kehao.lems.service.EquPurcService;
import org.kehao.lems.utils.CodeUtil;
import org.kehao.lems.utils.LEMSResult;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by hao on 2017/04/27.
 */
@Service("equPurcService")
public class EquPurcServiceImpl implements EquPurcService {

    @Resource
    EquPurchaseMapper equPurchaseMapper;
    public LEMSResult equPurcAdd(EquPurchase equPurchase) {
        LEMSResult result=new LEMSResult();
        String pcid=CodeUtil.createId();
        equPurchase.setPcid(pcid);
        if(equPurchaseMapper.insertSelective(equPurchase)==1){
            result.setStatus(0);
            result.setMessage("采购部分完成");
            result.setData(pcid);
        }else {
            result.setData(pcid);
            result.setStatus(1);
            result.setMessage("采购部分失败");
        }
        return result;
    }

    public LEMSResult equPurcDel(String pcid) {
        LEMSResult result=new LEMSResult();
        if(equPurchaseMapper.deleteByPrimaryKey(pcid)==0){
            result.setStatus(0);
            result.setMessage("删除成功");
        }else{
            result.setStatus(1);
            result.setMessage("删除失败");
        }
        return result;
    }
}
