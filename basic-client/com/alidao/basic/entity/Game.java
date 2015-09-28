package com.alidao.basic.entity;

import java.util.Date;

import com.alidao.jxe.model.SpkModel;


public class Game extends SpkModel  {

    private static final long serialVersionUID = 1L;

    private String productId;

    private String name;

    private Date startTime;

    private Date endTime;

    public void beforeInsert() {

    }

    public void beforeUpdate() {

    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId == null ? null : productId.trim();
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
}