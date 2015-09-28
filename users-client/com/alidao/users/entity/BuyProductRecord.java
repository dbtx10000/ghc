package com.alidao.users.entity;

import com.alidao.jxe.model.SpkModel;

public class BuyProductRecord extends SpkModel  {

    private static final long serialVersionUID = 1L;

    private String userId;

    private String productId;
    
    private String orderId;

    private Integer costMoney;
    
    private Integer scale;
    
    private String sncode;

    private Integer status;
    
    private Integer readed;

    public void beforeInsert() {

    }

    public void beforeUpdate() {

    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId == null ? null : productId.trim();
    }
    
	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId == null ? null : orderId.trim();
	}

	public Integer getCostMoney() {
		return costMoney;
	}

	public void setCostMoney(Integer costMoney) {
		this.costMoney = costMoney;
	}

	public Integer getScale() {
		return scale;
	}

	public void setScale(Integer scale) {
		this.scale = scale;
	}

	public String getSncode() {
        return sncode;
    }

    public void setSncode(String sncode) {
        this.sncode = sncode == null ? null : sncode.trim();
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

	public Integer getReaded() {
		return readed;
	}

	public void setReaded(Integer readed) {
		this.readed = readed;
	}
    
}