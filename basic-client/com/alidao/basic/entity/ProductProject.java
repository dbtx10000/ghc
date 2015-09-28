package com.alidao.basic.entity;

import com.alidao.jxe.model.SpkModel;

public class ProductProject extends SpkModel {

	private static final long serialVersionUID = 1L;
	
	private String productId;

    private String name;

    private String note;

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}
    
}