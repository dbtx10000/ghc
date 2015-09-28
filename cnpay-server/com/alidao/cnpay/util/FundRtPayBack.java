package com.alidao.cnpay.util;

public class FundRtPayBack {

	/*
	responseCode	应答信息	数字	定长，2位
	merId	商户号	数字	定长，15位
	merDate	商户日期	数字	定长，8位
	merSeqId  商户流水号   字符 变长，16位
	cpDate  ChinaPay接收到交易的日期   8位
	cpSeqId  ChinaPay系统内部流水     6位
	transAmt	金额	数字	定长，12位
	stat  交易状态码   1位
	cardNo	卡号/折号	字符	变长，32位
	chkValue	签名值	字符	定长，256位
	*/
	
	private String responseCode;
	private String merId;
	private String merDate;
	private String merSeqId;
	private String cpDate;
	private String cpSeqId;
	private String transAmt;
	private String stat;
	private String cardNo;
	private String chkValue;
	
	
	public String getResponseCode() {
		return responseCode;
	}
	public void setResponseCode(String responseCode) {
		this.responseCode = responseCode;
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
	public String getCpDate() {
		return cpDate;
	}
	public void setCpDate(String cpDate) {
		this.cpDate = cpDate;
	}
	public String getCpSeqId() {
		return cpSeqId;
	}
	public void setCpSeqId(String cpSeqId) {
		this.cpSeqId = cpSeqId;
	}
	public String getTransAmt() {
		return transAmt;
	}
	public void setTransAmt(String transAmt) {
		this.transAmt = transAmt;
	}
	public String getStat() {
		return stat;
	}
	public void setStat(String stat) {
		this.stat = stat;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public String getChkValue() {
		return chkValue;
	}
	public void setChkValue(String chkValue) {
		this.chkValue = chkValue;
	}


}
