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
     * @param laboratoryEx
     * @return
     */
    LEMSResult labGet(Integer page, Integer rows, String order, String sort, LaboratoryEx laboratoryEx);

    /**
     * 获得条件查询的记录总数
     * @param laboratoryEx
     * @return
     */
    Long labGetCount(LaboratoryEx laboratoryEx);

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

    /**
     * 搜索到的结果数量
     * @param laboratoryEx
     * @return
     */
    Long searchLabCount( LaboratoryEx laboratoryEx);

    /**
     * 可预约实验室列表
     * @param page
     * @param rows
     * @param order
     * @param sort
     * @param laboratoryEx
     * @return
     */
    LEMSResult enOrderLab(Integer page, Integer rows, String order, String sort, LaboratoryEx laboratoryEx);

    /**
     * 可预约实验室数量
     * @param laboratoryEx
     * @return
     */
    Long enOrderLabCount(LaboratoryEx laboratoryEx);
}
