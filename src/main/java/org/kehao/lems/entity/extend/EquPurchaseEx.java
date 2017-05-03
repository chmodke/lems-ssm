package org.kehao.lems.entity.extend;

import org.kehao.lems.entity.EquPurchase;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;


public class EquPurchaseEx{
    private String pcid;

    private String uid;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date pctime;

    private Double price;

}