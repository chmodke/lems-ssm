package org.kehao.lems.service;

import org.kehao.lems.entity.Laboratory;
import org.kehao.lems.utils.LEMSResult;

/**
 * Created by kehao on 2017/4/26.
 */
public interface LabService {
    /**
     * 添加实验室
     * @param laboratory
     * @return
     */
    LEMSResult labAdd(Laboratory laboratory);
}
