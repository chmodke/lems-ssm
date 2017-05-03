package org.kehao.lems.entity.extend;


import java.util.Date;

/**
 * 用于实验室查询的扩展类
 */
public class LaboratoryEx{

    private String lab_lid;

    private String lab_id;

    private String lab_lname;

    private Integer lab_lsize;

    private Date lab_addtime;

    private Integer lab_status;

    private String lab_type;

    private String lab_remark;

    private String lab_uname;//实验室负责人

    private Integer lab_equcount;

    private String equ_id;

    private String equ_ename;

    private String equ_type;

    private Date equ_addtime;

    private Integer equ_status;

    private String equ_remark;

    private String purc_price;//设备价格

    private String equ_uname;//设备采购人

}