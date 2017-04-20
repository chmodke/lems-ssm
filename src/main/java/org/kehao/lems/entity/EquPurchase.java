package org.kehao.lems.entity;

import java.util.Date;

public class EquPurchase {
    private String epid;

    private String pcid;

    private String uid;

    private Date pctime;

    public String getEpid() {
        return epid;
    }

    public void setEpid(String epid) {
        this.epid = epid == null ? null : epid.trim();
    }

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
}