package org.kehao.lems.service;

import org.kehao.lems.entity.Laboratory;
import org.kehao.lems.entity.User;
import org.kehao.lems.entity.extend.LaboratoryEx;
import org.kehao.lems.utils.LEMSResult;

import java.util.List;

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

    /**
     * 批量禁用实验室
     * @param delList
     * @return
     */
    LEMSResult labDel(List<String> delList);

    /**
     * 搜索实验室信息
     * @param page 页码
     * @param rows 页面行数
     * @param order 排序方式
     * @param sort 排序字段
     * @param laboratoryEx 搜索条件
     * @return
     */
    LEMSResult searchLab(Integer page, Integer rows, String order, String sort, LaboratoryEx laboratoryEx);
    Long searchLabCount( LaboratoryEx laboratoryEx);
}
