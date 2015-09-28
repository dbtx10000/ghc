package com.alidao.cnpay.util;

public class FundPayBack {

	/*
	responseCode	应答信息	数字	定长，2位
	merId	商户号	数字	定长，15位
	transDate	商户日期	数字	定长，8位
	orderNo	订单号	数字	定长，16位
	transAmt	金额	数字	定长，12位
	curyId	币种	数字	定长，3位
	transType	交易类型	数字	定长，4位
	priv1	私有域	字符	变长，60位
	transStat	代扣状态	数字	定长，4位
	gateId	网关号	数字	定长，4位
	cardType	卡折标志	数字	定长，1位
	cardNo	卡号/折号	字符	变长，25位
	userNme	持卡人姓名	字符	变长，20位
	certType	证件类型	字符	定长，2位
	certId	证件号	字符	变长，25位
	message	描述	字符	变长，256位
	chkValue	签名值	字符	定长，256位
	*/
	
	private String responseCode;
	private String merId;
	private String transDate;
	private String orderNo;
	private String transAmt;
	private String curyId;
	private String transType;
	private String priv1;
	private String transStat;
	private String gateId;
	private String cardType;
	private String cardNo;
	private String userNme;
	private String certType;
	private String certId;
	private String message;
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

	public String getTransDate() {
		return transDate;
	}

	public void setTransDate(String transDate) {
		this.transDate = transDate;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getTransAmt() {
		return transAmt;
	}

	public void setTransAmt(String transAmt) {
		this.transAmt = transAmt;
	}

	public String getCuryId() {
		return curyId;
	}

	public void setCuryId(String curyId) {
		this.curyId = curyId;
	}

	public String getTransType() {
		return transType;
	}

	public void setTransType(String transType) {
		this.transType = transType;
	}

	public String getPriv1() {
		return priv1;
	}

	public void setPriv1(String priv1) {
		this.priv1 = priv1;
	}

	public String getTransStat() {
		return transStat;
	}

	public void setTransStat(String transStat) {
		this.transStat = transStat;
	}

	public String getGateId() {
		return gateId;
	}

	public void setGateId(String gateId) {
		this.gateId = gateId;
	}

	public String getCardType() {
		return cardType;
	}

	public void setCardType(String cardType) {
		this.cardType = cardType;
	}

	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public String getUserNme() {
		return userNme;
	}

	public void setUserNme(String userNme) {
		this.userNme = userNme;
	}

	public String getCertType() {
		return certType;
	}

	public void setCertType(String certType) {
		this.certType = certType;
	}

	public String getCertId() {
		return certId;
	}

	public void setCertId(String certId) {
		this.certId = certId;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getChkValue() {
		return chkValue;
	}

	public void setChkValue(String chkValue) {
		this.chkValue = chkValue;
	}

}
