package com.alidao.basic.entity;

import com.alidao.jxe.model.SpkModel;

public class ProductType extends SpkModel {
	
	private static final long serialVersionUID = 1L;
	
    private String name;

    private String logo;

    private Integer seq;

    private String note;
    
    private Long productCount;	//产品数量

	public Long getProductCount() {
		return productCount;
	}

	public void setProductCount(Long productCount) {
		this.productCount = productCount;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLogo() {
		return logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}
    
}