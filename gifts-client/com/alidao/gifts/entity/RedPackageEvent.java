package com.alidao.gifts.entity;

import java.util.Date;

import com.alidao.jxe.model.SpkModel;
public class RedPackageEvent extends SpkModel  {

    private static final long serialVersionUID = 1L;

    private String name;

    private Integer sourceType;

    private String sourceId;

    private String userId;

    private Integer type;

    private Integer totalNums;

    private Integer gogetNums;

    private Integer totalIntegrals;

    private Integer gogetIntegrals;

    private Long integralTypeId;

    private Integer minIntegral;

    private Integer maxIntegral;

    private Date startTime;

    private Date endTime;

    private Integer status; 
    
    public Integer getGetCount() {
		return getCount;
	}

	public void setGetCount(Integer getCount) {
		this.getCount = getCount;
	}

	public Integer getForwardCount() {
		return forwardCount;
	}

	public void setForwardCount(Integer forwardCount) {
		this.forwardCount = forwardCount;
	}

	private Integer getCount;

    private Integer forwardCount;
    
    public static final int STATUS_EVENT_BEGIN = 1;
    
    public static final int STATUS_EVENT_END = 2;
    
    public void beforeInsert() {
    	this.sourceType=1;
    	this.type=1;
    	this.integralTypeId=2L;
    	this.gogetIntegrals=0;
    	this.status=STATUS_EVENT_END;
    	this.forwardCount=0;
    	this.getCount=0;
    }

    public void beforeUpdate() {

    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public Integer getSourceType() {
        return sourceType;
    }

    public void setSourceType(Integer sourceType) {
        this.sourceType = sourceType;
    }

    public String getSourceId() {
        return sourceId;
    }

    public void setSourceId(String sourceId) {
        this.sourceId = sourceId == null ? null : sourceId.trim();
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getTotalNums() {
        return totalNums;
    }

    public void setTotalNums(Integer totalNums) {
        this.totalNums = totalNums;
    }

    public Integer getGogetNums() {
        return gogetNums;
    }

    public void setGogetNums(Integer gogetNums) {
        this.gogetNums = gogetNums;
    }

    public Integer getTotalIntegrals() {
        return totalIntegrals;
    }

    public void setTotalIntegrals(Integer totalIntegrals) {
        this.totalIntegrals = totalIntegrals;
    }

    public Integer getGogetIntegrals() {
        return gogetIntegrals;
    }

    public void setGogetIntegrals(Integer gogetIntegrals) {
        this.gogetIntegrals = gogetIntegrals;
    }

    public Long getIntegralTypeId() {
        return integralTypeId;
    }

    public void setIntegralTypeId(Long integralTypeId) {
        this.integralTypeId = integralTypeId;
    }

    public Integer getMinIntegral() {
        return minIntegral;
    }

    public void setMinIntegral(Integer minIntegral) {
        this.minIntegral = minIntegral;
    }

    public Integer getMaxIntegral() {
        return maxIntegral;
    }

    public void setMaxIntegral(Integer maxIntegral) {
        this.maxIntegral = maxIntegral;
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

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}