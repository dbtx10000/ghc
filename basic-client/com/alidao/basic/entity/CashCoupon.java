package com.alidao.basic.entity;

import java.util.Date;

import com.alidao.jxe.model.SpkModel;

public class CashCoupon extends SpkModel {

	private static final long serialVersionUID = 2380685445570945977L;
	
	/** 未获取 **/
	public static Integer STATUS_NOT_GET = 0;
	/** 以获取 **/
	public static Integer STATUS_GET_YES = 1;
	/** 已使用 **/
	public static Integer STATUS_USE_YES = 2;
	/** 已过期 **/
	public static Integer STATUS_EXPIRED = 3;
	
	/** 未读 **/
	public static Integer READ_NO = 0;
	/** 已读 **/
	public static Integer READ_YES = 1;

    private String userId;

    private String name;

    private Date vaildStartTime;

    private Date vaildEndTime;

    private Integer useCondition;

    private Integer money;
    
    private Integer status;
    
    private Integer readed;
    
    private Date useTime;

    private String productId;

    private String productName;
    
    private String userName;
    
	public Date getUseTime() {
		return useTime;
	}

	public void setUseTime(Date useTime) {
		this.useTime = useTime;
	}

	public Integer getReaded() {
		return readed;
	}

	public void setReaded(Integer readed) {
		this.readed = readed;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getVaildStartTime() {
		return vaildStartTime;
	}

	public void setVaildStartTime(Date vaildStartTime) {
		this.vaildStartTime = vaildStartTime;
	}

	public Date getVaildEndTime() {
		return vaildEndTime;
	}

	public void setVaildEndTime(Date vaildEndTime) {
		this.vaildEndTime = vaildEndTime;
	}

	public Integer getUseCondition() {
		return useCondition;
	}

	public void setUseCondition(Integer useCondition) {
		this.useCondition = useCondition;
	}

	public Integer getMoney() {
		return money;
	}

	public void setMoney(Integer money) {
		this.money = money;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
    
}