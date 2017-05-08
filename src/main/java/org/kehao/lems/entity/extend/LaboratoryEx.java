package org.kehao.lems.entity.extend;


import java.util.Date;

/**
 * 用于实验室查询的扩展类
 */
public class LaboratoryEx{

    private String lid;

    private String id;

    private String lname;

    private Integer lsize;

    private Date addtime;

    private Integer status;

    private String type;

    private String remark;

    private Integer equcount;

    //------------extend

    private String lab_uname;//实验室负责人

    private String lab_uid;//实验室负责人id

    private String equ_id;

    private String equ_ename;

    private String equ_type;

    private Date equ_addtime;

    private Integer equ_status;

    private String equ_remark;

    private Double purc_price;//设备价格

    private String equ_uname;//设备采购人

    public String getLid() {
        return lid;
    }

    public void setLid(String lid) {
        this.lid = lid;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    public Integer getLsize() {
        return lsize;
    }

    public void setLsize(Integer lsize) {
        this.lsize = lsize;
    }

    public Date getAddtime() {
        return addtime;
    }

    public void setAddtime(Date addtime) {
        this.addtime = addtime;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Integer getEqucount() {
        return equcount;
    }

    public void setEqucount(Integer equcount) {
        this.equcount = equcount;
    }

    public String getLab_uname() {
        return lab_uname;
    }

    public void setLab_uname(String lab_uname) {
        this.lab_uname = lab_uname;
    }

    public String getEqu_id() {
        return equ_id;
    }

    public void setEqu_id(String equ_id) {
        this.equ_id = equ_id;
    }

    public String getEqu_ename() {
        return equ_ename;
    }

    public void setEqu_ename(String equ_ename) {
        this.equ_ename = equ_ename;
    }

    public String getEqu_type() {
        return equ_type;
    }

    public void setEqu_type(String equ_type) {
        this.equ_type = equ_type;
    }

    public Date getEqu_addtime() {
        return equ_addtime;
    }

    public void setEqu_addtime(Date equ_addtime) {
        this.equ_addtime = equ_addtime;
    }

    public Integer getEqu_status() {
        return equ_status;
    }

    public void setEqu_status(Integer equ_status) {
        this.equ_status = equ_status;
    }

    public String getEqu_remark() {
        return equ_remark;
    }

    public void setEqu_remark(String equ_remark) {
        this.equ_remark = equ_remark;
    }

    public Double getPurc_price() {
        return purc_price;
    }

    public void setPurc_price(Double purc_price) {
        this.purc_price = purc_price;
    }

    public String getEqu_uname() {
        return equ_uname;
    }

    public void setEqu_uname(String equ_uname) {
        this.equ_uname = equ_uname;
    }

    public String getLab_uid() {
        return lab_uid;
    }

    public void setLab_uid(String lab_uid) {
        this.lab_uid = lab_uid;
    }
}