package org.kehao.lems.entity.extend;

import java.util.Date;

public class EquipmentEx{
    private String eid;

    private String id;

    private String ename;

    private String type;

    private Date addtime;

    private Integer status;

    private String remark;

    private String pcid;

    //--------------------------

    private String uname;//采购员用户名
    private Date pctime;//采购时间
	public String getEid() {
		return eid;
	}
	public void setEid(String eid) {
		this.eid = eid;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
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
		this.remark = remark;
	}
	public String getPcid() {
		return pcid;
	}
	public void setPcid(String pcid) {
		this.pcid = pcid;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public Date getPctime() {
		return pctime;
	}
	public void setPctime(Date pctime) {
		this.pctime = pctime;
	}
    
    
}