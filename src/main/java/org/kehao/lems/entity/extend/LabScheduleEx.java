package org.kehao.lems.entity.extend;

import org.kehao.lems.entity.LabSchedule;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class LabScheduleEx{
    private String slid;

    private String lid;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date starttime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date endtime;

    private String sname;

    private String stel;
}