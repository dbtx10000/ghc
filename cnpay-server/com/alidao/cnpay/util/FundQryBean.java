package com.alidao.cnpay.util;

import chinapay.Base64;

public class FundQryBean {
	
	/*
	merId	商户号	数字	定长，15位
	transType	交易类型	数字	定长，4位
	orderNo	订单号	数字	定长，16位
	transDate	商户日期	数字	定长，8位
	version	版本号	数字	定长，8位
	priv1	私有域	字符	变长，60位
	chkValue	签名值	字符	定长，256位
	*/

	private String merId;
	private String transType;
	private String orderNo;
	private String transDate;
	private String version;
	private String priv1;
	private String chkValue;
	
	public String message() {
		this.defaults();
		StringBuilder sber = new StringBuilder(this.merId);
		sber.append(this.transDate).append(this.orderNo)
			.append(this.transType).append(this.version);
		return String.valueOf(
			Base64.encode(
				sber.toString().getBytes()
			)
		);
	}
	
	private void defaults() {
		if (this.transType == null) {
			this.transType = "0003";
		}
		if (this.version == null) {
			this.version = "20100831";
		}
		if (this.priv1 == null) {
			this.priv1 = "";
		}
	}

	public String getMerId() {
		return merId;
	}

	public void setMerId(String merId) {
		this.merId = merId;
	}

	public String getTransType() {
		return transType;
	}

	public void setTransType(String transType) {
		this.transType = transType;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getTransDate() {
		return transDate;
	}

	public void setTransDate(String transDate) {
		this.transDate = transDate;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public String getPriv1() {
		return priv1;
	}

	public void setPriv1(String priv1) {
		this.priv1 = priv1;
	}

	public String getChkValue() {
		return chkValue;
	}

	public void setChkValue(String chkValue) {
		this.chkValue = chkValue;
	}
	
}
