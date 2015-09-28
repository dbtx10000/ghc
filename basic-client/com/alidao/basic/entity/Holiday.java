package com.alidao.basic.entity;

import java.util.Date;
import com.alidao.jxe.model.SpkModel;

public class Holiday extends SpkModel  {

    private static final long serialVersionUID = 1L;

    private String name;

    private Date startTime;

    private Date endTime;
    
    private Integer year;

    public void beforeInsert() {

    }

    public void beforeUpdate() {

    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

	public Integer getYear() {
		return year;
	}

	public void setYear(Integer year) {
		this.year = year;
	}

	
    
}