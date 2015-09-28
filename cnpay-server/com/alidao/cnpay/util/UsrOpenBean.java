package com.alidao.cnpay.util;

public class UsrOpenBean {

	/*
	1	version			字符型	定长，8位		版本号，必填字段，对于3.0版本，要求是8位版本号，填“20040616”；对于3.1或以上版本，要求是8位版本号，填“20051001”；
	2	fundTransTime	数字型	定长，14位	基金公司交易时间，必填字段，14位，基金发送给ChinaPay的日期时间戳，其格式为yyyyMMddHHmmss。
	3	instuId			字符型	定长，15位	接入机构代码，必填字段，15位，由ChinaPay给基金公司分配的15位定长的唯一代号。如非机构方式接入取值必须和基金公司商户号相同
	4	fundMerId		字符型	定长，15位	基金公司商户号，必填字段，15位，由ChinaPay给基金公司分配的15位定长的唯一代号。
	5	transType		字符型	定长，4位		交易类型，必填字段。1010：开户下单
	6	returnUrl		字符型	变长，256位	开户成功后的返回地址,必填字段，变长，开户成功后向基金公司回送交易结果，回送的地址由本域指定。
	7	encMsg			字符型	变长，4096位	密文交易数据，必填字段，变长。调用ChinaPay的安全加密函数对明码报文（各数据项需严格按照【表5.1.2】序号顺序拼接，注：各字段用“|”隔开，最后一个字段后不能有“|”。例如：字段1+|+字段2+|+字段3+|+…+|+字段N）生成的一串密文。明码报文数据项的格式参见【表5.1.2】；加密函数的接口参见《企业客户端安全接口规范V2.0》；使用“银联通“公钥进行加密。
	8	signMsg			字符型	定长，256位	交易数据签名，必填字段，调用ChinaPay的安全签名函数对明码报文（各数据项需严格按照【表5.1.2】序号顺序拼接，注：各字段用“|”隔开，最后一个字段后不能有“|”。例如：字段1+|+字段2+|+字段3+|+…+|+字段N）生成的一串签名。明码报文数据项的格式参见【表5.1.2】；签名函数的接口参见《企业客户端安全接口规范V2.0》；需要使用基金公司私钥进行签名。
	*/
	
	private String version;
	private String fundTransTime;
	private String instuId;
	private String fundMerId;
	private String transType;
	private String returnUrl;
	private String encMsg;
	private String signMsg;
	private String resv1;
	private String resv2;
	private String resv3;
	private String resv4;
	
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getFundTransTime() {
		return fundTransTime;
	}
	public void setFundTransTime(String fundTransTime) {
		this.fundTransTime = fundTransTime;
	}
	public String getInstuId() {
		return instuId;
	}
	public void setInstuId(String instuId) {
		this.instuId = instuId;
	}
	public String getFundMerId() {
		return fundMerId;
	}
	public void setFundMerId(String fundMerId) {
		this.fundMerId = fundMerId;
	}
	public String getTransType() {
		return transType;
	}
	public void setTransType(String transType) {
		this.transType = transType;
	}
	public String getReturnUrl() {
		return returnUrl;
	}
	public void setReturnUrl(String returnUrl) {
		this.returnUrl = returnUrl;
	}
	public String getEncMsg() {
		return encMsg;
	}
	public void setEncMsg(String encMsg) {
		this.encMsg = encMsg;
	}
	public String getSignMsg() {
		return signMsg;
	}
	public void setSignMsg(String signMsg) {
		this.signMsg = signMsg;
	}
	public String getResv1() {
		return resv1;
	}
	public void setResv1(String resv1) {
		this.resv1 = resv1;
	}
	public String getResv2() {
		return resv2;
	}
	public void setResv2(String resv2) {
		this.resv2 = resv2;
	}
	public String getResv3() {
		return resv3;
	}
	public void setResv3(String resv3) {
		this.resv3 = resv3;
	}
	public String getResv4() {
		return resv4;
	}
	public void setResv4(String resv4) {
		this.resv4 = resv4;
	}
	
}
