package org.kehao.lems.entity;

import java.util.Date;

public class EquPurchase {
    private String pcid;

    private String uid;

    private Date pctime;

    private Double price;
    private Equipment equipment;

    public String getPcid() {
        return pcid;
    }

    public void setPcid(String pcid) {
        this.pcid = pcid == null ? null : pcid.trim();
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid == null ? null : uid.trim();
    }

    public Date getPctime() {
        return pctime;
    }

    public void setPctime(Date pctime) {
        this.pctime = pctime;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Equipment getEquipment() {
        return equipment;
    }

    public void setEquipment(Equipment equipment) {
        this.equipment = equipment;
    }
}