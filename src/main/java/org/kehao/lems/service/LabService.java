package org.kehao.lems.service;

import org.kehao.lems.entity.Laboratory;
import org.kehao.lems.entity.User;
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

    /**
     * 获得条件查询的记录
     * @param page
     * @param rows
     * @param user
     * @param order
     * @param sort
     * @param laboratory
     * @return
     */
    LEMSResult labGet(Integer page, Integer rows, String order, String sort, Laboratory laboratory);

    /**
     * 获得条件查询的记录总数
     * @param laboratory
     * @return
     */
    Long labGetCount(Laboratory laboratory);
}
