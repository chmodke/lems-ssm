package org.kehao.lems.entity;

import java.util.Date;

public class Laboratory {
    private String lid;

    private String id;

    private String lname;

    private Integer lsize;

    private Date addtime;

    private Integer status;

    private String type;

    private String remark;

    private String uid;

    private Integer equcount;

    public String getLid() {
        return lid;
    }

    public void setLid(String lid) {
        this.lid = lid == null ? null : lid.trim();
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname == null ? null : lname.trim();
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
        this.type = type == null ? null : type.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid == null ? null : uid.trim();
    }

    public Integer getEqucount() {
        return equcount;
    }

    public void setEqucount(Integer equcount) {
        this.equcount = equcount;
    }
}