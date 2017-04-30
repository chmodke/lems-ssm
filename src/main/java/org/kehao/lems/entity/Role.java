package org.kehao.lems.entity;

import java.util.List;

public class Role {
    private Integer rid;

    private String rname;

    private String remark;

    private List<UserRole> userRole;

    public Integer getRid() {
        return rid;
    }

    public void setRid(Integer rid) {
        this.rid = rid;
    }

    public String getRname() {
        return rname;
    }

    public void setRname(String rname) {
        this.rname = rname == null ? null : rname.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public void setUserRole(List<UserRole> userRole) {
        this.userRole = userRole;
    }

    public List<UserRole> getUserRole() {
        return userRole;
    }
}