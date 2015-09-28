package com.alidao.basic.entity;

import com.alidao.jxe.model.LpkModel;

public class SmsBlack extends LpkModel {

	private static final long serialVersionUID = 1L;

	private Integer type;

	private String mobile;

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile == null ? null : mobile.trim();
	}

}