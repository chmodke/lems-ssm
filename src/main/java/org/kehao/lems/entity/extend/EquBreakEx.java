package org.kehao.lems.entity.extend;

public class EquBreakEx{
    private String bid;

    private String eid;//设备编号

    private Integer id;//故障编号

    private String breason;//故障原因

    private Integer status;//报修状态


    private String ename;//设备名称

    private String etype;//设备类型

    private String lname;//所属实验室

    private String e_id;//设备编号

    public String getBid() {
        return bid;
    }

    public void setBid(String bid) {
        this.bid = bid;
    }

    public String getEid() {
        return eid;
    }

    public void setEid(String eid) {
        this.eid = eid;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getBreason() {
        return breason;
    }

    public void setBreason(String breason) {
        this.breason = breason;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getEname() {
        return ename;
    }

    public void setEname(String ename) {
        this.ename = ename;
    }

    public String getEtype() {
        return etype;
    }

    public void setEtype(String etype) {
        this.etype = etype;
    }

    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    public String getE_id() {
        return e_id;
    }

    public void setE_id(String e_id) {
        this.e_id = e_id;
    }
}