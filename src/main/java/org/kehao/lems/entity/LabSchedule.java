package org.kehao.lems.entity;

import java.util.Date;

public class LabSchedule {
    private String slid;

    private String lid;

    private Date starttime;

    private Date endtime;

    private String sname;

    public String getSlid() {
        return slid;
    }

    public void setSlid(String slid) {
        this.slid = slid == null ? null : slid.trim();
    }

    public String getLid() {
        return lid;
    }

    public void setLid(String lid) {
        this.lid = lid == null ? null : lid.trim();
    }

    public Date getStarttime() {
        return starttime;
    }

    public void setStarttime(Date starttime) {
        this.starttime = starttime;
    }

    public Date getEndtime() {
        return endtime;
    }

    public void setEndtime(Date endtime) {
        this.endtime = endtime;
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname == null ? null : sname.trim();
    }
}