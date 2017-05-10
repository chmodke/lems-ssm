package org.kehao.lems.entity;

import org.kehao.lems.entity.extend.EquLabEx;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

public class Laboratory {
    private String lid;

    private String id;

    private String lname;

    private Integer lsize;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date addtime;

    private Integer status;

    private String type;

    private String remark;

    private String uid;

    private Integer equcount;

    private List<EquLab> equLab;

    private User user;

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

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public Integer getEqucount() {
        return equcount;
    }

    public void setEqucount(Integer equcount) {
        this.equcount = equcount;
    }

    public List<EquLab> getEquLab() {
        return equLab;
    }

    public void setEquLab(List<EquLab> equLab) {
        this.equLab = equLab;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}