package com.alidao.basic.entity;

import com.alidao.jxe.model.SpkModel;


public class GameBuyRecord extends SpkModel  {

    private static final long serialVersionUID = 1L;

    private String userId;

    private String productId;

    private String orderId;

    private Integer status;

    public static final int STATUS_TYPE_NOT_USED = 0;
    
    public static final int STATUS_TYPE_USED = 1;
    
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

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}