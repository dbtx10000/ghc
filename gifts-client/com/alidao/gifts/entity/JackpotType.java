package com.alidao.gifts.entity;

import com.alidao.jxe.model.SpkModel;


public class JackpotType extends SpkModel  {

    private static final long serialVersionUID = 1L;

    private String productId;

    private String name;

    private Integer jackpotCount;

    public void beforeInsert() {
    	if(this.jackpotCount==null){
    		this.jackpotCount=0;
    	}
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

    public Integer getJackpotCount() {
        return jackpotCount;
    }

    public void setJackpotCount(Integer jackpotCount) {
        this.jackpotCount = jackpotCount;
    }
}