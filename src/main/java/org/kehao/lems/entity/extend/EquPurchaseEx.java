package org.kehao.lems.entity.extend;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;


public class EquPurchaseEx{
    private String pcid;

    private String uid;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date pctime;

    private Double price;

	public String getPcid() {
		return pcid;
	}

	public void setPcid(String pcid) {
		this.pcid = pcid;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
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
    
    

}