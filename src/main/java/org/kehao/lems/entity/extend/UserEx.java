package org.kehao.lems.entity.extend;

import java.util.Date;

public class UserEx{
    private String uid;

    private String uname;

    private String tureName;

    private String passwd;

    private String salt;

    private String officeAddress;

    private String officePhone;

    private String email;

    private String masterid;

    private Date createtime;

    private String token;
    private Integer status;

    //------------------

    private String rname;
    private Date createtimeStart;
    private Date createtimeEnd;
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getTureName() {
		return tureName;
	}
	public void setTureName(String tureName) {
		this.tureName = tureName;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getSalt() {
		return salt;
	}
	public void setSalt(String salt) {
		this.salt = salt;
	}
	public String getOfficeAddress() {
		return officeAddress;
	}
	public void setOfficeAddress(String officeAddress) {
		this.officeAddress = officeAddress;
	}
	public String getOfficePhone() {
		return officePhone;
	}
	public void setOfficePhone(String officePhone) {
		this.officePhone = officePhone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMasterid() {
		return masterid;
	}
	public void setMasterid(String masterid) {
		this.masterid = masterid;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getRname() {
		return rname;
	}
	public void setRname(String rname) {
		this.rname = rname;
	}
	public Date getCreatetimeStart() {
		return createtimeStart;
	}
	public void setCreatetimeStart(Date createtimeStart) {
		this.createtimeStart = createtimeStart;
	}
	public Date getCreatetimeEnd() {
		return createtimeEnd;
	}
	public void setCreatetimeEnd(Date createtimeEnd) {
		this.createtimeEnd = createtimeEnd;
	}

}