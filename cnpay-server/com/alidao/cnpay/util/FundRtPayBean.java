package com.alidao.cnpay.util;

import java.text.SimpleDateFormat;
import java.util.Date;

import chinapay.Base64;

public class FundRtPayBean {
	
	/*
	merId	商户号	数字	定长，15位
	merDate	商户日期	数字	定长，8位
	merSeqId 商户流水号  数字    变长，16位
	cardNo	卡号/折号	字符	变长，32位
	usrName	持卡人姓名	字符	变长，100位
	openBank 开户行号名称	数字	定长，50位
	prov	 收款人开户行所在省   字符   变长 ，20位
	city	 收款人开户行所在地区   字符   变长 ，40位
	transAmt	金额	数字	定长，12位
	purpose		存款用途   字符     变长，99位
	subBank     开户支行名称   字符   变长，80位   选填
	flag		付款标志     字符  定长，2位    选填
	version	版本号	数字	定长，8位
	signFlag  签名标志   字符   定长，1位
	chkValue	签名值	字符	定长，256位
	*/

	private String merId;
	private String merDate;
	private String merSeqId;
	private String cardNo;
	private String usrName;
	private String openBank;
	private String prov;
	private String city;
	private String transAmt;
	private String purpose;
	private String subBank;
	private String flag;
	private String version;
	private String signFlag;
	private String chkValue;
	
	

	public String message() {
		this.defaults();
		StringBuilder sber = new StringBuilder();
		sber.append(this.merId).append(this.merDate).append(this.merSeqId).append(this.cardNo)
		.append(this.usrName).append(this.openBank).append(this.prov).append(this.city)
		.append(this.transAmt).append(this.purpose).append(this.subBank).append(this.flag).append(this.version);
		return new String(Base64.encode(sber.toString().getBytes()));
	}
	
	private void defaults() {
		if (this.merDate == null) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			this.merDate = sdf.format(new Date());
		}
		if (this.transAmt.length() != 12) {
			int count = 12 - this.transAmt.length();
			for (int i = 0; i < count; i++) {
				this.transAmt = "0" + this.transAmt;
			}
		}
		if (this.version == null) {
			this.version = "20090501";
		}
		if(this.signFlag == null) {
			this.signFlag = "1";
		}
		if(this.flag == null) {
			this.flag = "00";
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
	
	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getSignFlag() {
		return signFlag;
	}

	public void setSignFlag(String signFlag) {
		this.signFlag = signFlag;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getSubBank() {
		return subBank;
	}

	public void setSubBank(String subBank) {
		this.subBank = subBank;
	}

	public String getOpenBank() {
		return openBank;
	}

	public void setOpenBank(String openBank) {
		this.openBank = openBank;
	}

	public String getProv() {
		return prov;
	}

	public void setProv(String prov) {
		this.prov = prov;
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

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public String getChkValue() {
		return chkValue;
	}

	public void setChkValue(String chkValue) {
		this.chkValue = chkValue;
	}

}
