package org.kehao.lems.entity;

import java.util.Date;

public class Equipment {
    private String eid;

    private String id;

    private String ename;

    private String type;

    private Date addtime;

    private Integer status;

    private String remark;

    private String pcid;

    private EquPurchase equPurchase;

    private EquLab equLab;

    public String getEid() {
        return eid;
    }

    public void setEid(String eid) {
        this.eid = eid == null ? null : eid.trim();
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getEname() {
        return ename;
    }

    public void setEname(String ename) {
        this.ename = ename == null ? null : ename.trim();
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
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

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public String getPcid() {
        return pcid;
    }

    public void setPcid(String pcid) {
        this.pcid = pcid == null ? null : pcid.trim();
    }

    public EquPurchase getEquPurchase() {
        return equPurchase;
    }

    public void setEquPurchase(EquPurchase equPurchase) {
        this.equPurchase = equPurchase;
    }

    public void setEquLab(EquLab equLab) {
        this.equLab = equLab;
    }

    public EquLab getEquLab() {
        return equLab;
    }
}