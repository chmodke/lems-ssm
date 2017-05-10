package org.kehao.lems.entity.extend;

import org.kehao.lems.entity.EquSchedule;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class EquScheduleEx{
    private String seid;

    private String eid;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date starttime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date endtime;

    private String sname;
}