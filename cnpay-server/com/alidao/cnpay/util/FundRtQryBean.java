package com.alidao.cnpay.util;

import chinapay.Base64;

public class FundRtQryBean {
	
	/*
	merId	商户号	数字	定长，15位
	merDate	商户日期	数字	定长，8位
	merSeqId   流水号    数字	变长，16位
	version	版本号	数字	定长，8位
	signFlag   签名标志  字符  定长，1位
	chkValue	签名值	字符	定长，256位
	*/

	private String merId;
	private String merDate;
	private String merSeqId;
	private String version;
	private String signFlag;
	private String chkValue;
	
	public String message() {
		this.defaults();
		StringBuilder sber = new StringBuilder(this.merId);
		sber.append(this.merDate).append(this.merSeqId)
			.append(this.version);
		return String.valueOf(
			Base64.encode(
				sber.toString().getBytes()
			)
		);
	}
	
	private void defaults() {
		if (this.version == null) {
			this.version = "20090501";
		}
		if (this.signFlag == null) {
			this.signFlag = "1";
		}
	}

	public String getMerId() {
		return merId;
	}

	public void setMerId(String merId) {
		this.merId = merId;
	}

	public String getMerDate() {
		return merDate;
	}

	public void setMerDate(String merDate) {
		this.merDate = merDate;
	}

	public String getMerSeqId() {
		return merSeqId;
	}

	public void setMerSeqId(String merSeqId) {
		this.merSeqId = merSeqId;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public String getSignFlag() {
		return signFlag;
	}

	public void setSignFlag(String signFlag) {
		this.signFlag = signFlag;
	}

	public String getChkValue() {
		return chkValue;
	}

	public void setChkValue(String chkValue) {
		this.chkValue = chkValue;
	}

}
