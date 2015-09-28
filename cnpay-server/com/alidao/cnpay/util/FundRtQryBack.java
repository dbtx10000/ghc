package com.alidao.cnpay.util;

public class FundRtQryBack {
	
	/*
	code	应答信息	数字	定长，2位
	merId	商户号	数字	定长，15位
	merDate	商户日期	数字	定长，8位
	merSeqId  流水号   数字   变长，16位
	cpDate  ChinaPay接收到交易的日期    数字	定长，8位
	cpSeqId  ChinaPay系统内部流水   数字	定长，6位
	bankName  原始订单参数中的开户银行    字符   变长，50位
	cardNo   原始订单参数中的收款账号，仅显示后5位    
	usrName    收款人姓名    字符   变长，100位
	transAmt	金额	数字	变长，12位
	feeAmt    手续费     数字	变长，12位
	prov     省份     符   变长，20位
	city     省份     符   变长，40位
	purpose  用途     字符   变长，99位
	stat     交易状态    数字	定长，1位
	backDate  退单日期   数字	定长，8位
	chkValue	签名值	字符	定长，256位
	*/

	private String code;
	private String merId;
	private String merDate;
	private String merSeqId;
	private String cpDate;
	private String cpSeqId;
	private String bankName;
	private String cardNo;
	private String usrName;
	private String transAmt;
	private String feeAmt;
	private String prov;
	private String city;
	private String purpose;
	private String stat;
	private String backDate;
	private String chkValue;
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
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
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
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
	public String getFeeAmt() {
		return feeAmt;
	}
	public void setFeeAmt(String feeAmt) {
		this.feeAmt = feeAmt;
	}
	public String getProv() {
		return prov;
	}
	public void setProv(String prov) {
		this.prov = prov;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	public String getStat() {
		return stat;
	}
	public void setStat(String stat) {
		this.stat = stat;
	}
	public String getBackDate() {
		return backDate;
	}
	public void setBackDate(String backDate) {
		this.backDate = backDate;
	}
	public String getChkValue() {
		return chkValue;
	}
	public void setChkValue(String chkValue) {
		this.chkValue = chkValue;
	}

	
}
