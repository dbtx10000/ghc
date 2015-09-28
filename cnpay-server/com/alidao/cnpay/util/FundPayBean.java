package com.alidao.cnpay.util;

import java.text.SimpleDateFormat;
import java.util.Date;

import chinapay.Base64;

public class FundPayBean {
	
	/*
	merId	商户号	数字	定长，15位
	transDate	商户日期	数字	定长，8位
	orderNo	订单号	数字	定长，16位
	transType	交易类型	数字	定长，4位
	openBankId	开户行号	数字	定长，4位
	cardType	卡折标志	数字	定长，1位
	cardNo	卡号/折号	字符	变长，32位
	usrName	持卡人姓名	字符	变长，100位
	certType	证件类型	字符	定长，2位
	certId	证件号	字符	变长，25位
	curyId	币种	数字	定长，3位
	transAmt	金额	数字	定长，12位
	purpose	用途	字符	变长，25位
	priv1	私有域	字符	变长，60位
	version	版本号	数字	定长，8位
	gateId	网关号	数字	定长，4位
	chkValue	签名值	字符	定长，256位
	*/

	private String merId;
	private String transDate;
	private String orderNo;
	private String transType;
	private String openBankId;
	private String cardType;
	private String cardNo;
	private String usrName;
	private String certType;
	private String certId;
	private String curyId;
	private String transAmt;
	private String purpose;
	private String priv1;
	private String version;
	private String gateId;
	private String chkValue;

	public String message() {
		this.defaults();
		StringBuilder sber = new StringBuilder();
		sber.append(this.merId).append(this.transDate).append(this.orderNo)
			.append(this.transType).append(this.openBankId).append(this.cardType)
			.append(this.cardNo).append(this.usrName).append(this.certType)
			.append(this.certId).append(this.curyId).append(this.transAmt)
			.append(this.priv1).append(this.version).append(this.gateId);
		return new String(Base64.encode(sber.toString().getBytes()));
	}
	
	private void defaults() {
		if (this.transDate == null) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			this.transDate = sdf.format(new Date());
		}
		if (this.transType == null) {
			this.transType = "0003";
		}
		if (this.cardType == null) {
			this.cardType = "0";
		}
		if (this.curyId == null) {
			this.curyId = "156";
		}
		if (this.transAmt.length() != 12) {
			int count = 12 - this.transAmt.length();
			for (int i = 0; i < count; i++) {
				this.transAmt = "0" + this.transAmt;
			}
		}
		if (this.priv1 == null) {
			this.priv1 = "\\u57fa\\u91d1\\u4ee3\\u6263";
		}
		if (this.version == null) {
			this.version = "20100831";
		}
		if (this.gateId == null) {
			this.gateId = "7008";
		}
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

	public String getTransType() {
		return transType;
	}

	public void setTransType(String transType) {
		this.transType = transType;
	}

	public String getOpenBankId() {
		return openBankId;
	}

	public void setOpenBankId(String openBankId) {
		this.openBankId = openBankId;
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

	public String getUsrName() {
		return usrName;
	}

	public void setUsrName(String usrName) {
		this.usrName = usrName;
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

	public String getCuryId() {
		return curyId;
	}

	public void setCuryId(String curyId) {
		this.curyId = curyId;
	}

	public String getTransAmt() {
		return transAmt;
	}

	public void setTransAmt(String transAmt) {
		this.transAmt = transAmt;
	}

	public String getPurpose() {
		return purpose;
	}

	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}

	public String getPriv1() {
		return priv1;
	}

	public void setPriv1(String priv1) {
		this.priv1 = priv1;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public String getGateId() {
		return gateId;
	}

	public void setGateId(String gateId) {
		this.gateId = gateId;
	}

	public String getChkValue() {
		return chkValue;
	}

	public void setChkValue(String chkValue) {
		this.chkValue = chkValue;
	}

}
