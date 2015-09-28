package com.alidao.basic.entity;

import java.util.Date;

import com.alidao.jxe.model.LpkModel;

public class IntegralType extends LpkModel  {

    private static final long serialVersionUID = 1L;

    private String name;

    private Integer type;

    private Date validStartTime;

    private Date validEndTime;

    private Integer time;

    private Integer unit;

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

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Date getValidStartTime() {
        return validStartTime;
    }

    public void setValidStartTime(Date validStartTime) {
        this.validStartTime = validStartTime;
    }

    public Date getValidEndTime() {
        return validEndTime;
    }

    public void setValidEndTime(Date validEndTime) {
        this.validEndTime = validEndTime;
    }

    public Integer getTime() {
        return time;
    }

    public void setTime(Integer time) {
        this.time = time;
    }

    public Integer getUnit() {
        return unit;
    }

    public void setUnit(Integer unit) {
        this.unit = unit;
    }
}