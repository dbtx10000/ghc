package com.alidao.cnpay.util;


public class UsrOpenInfo {

	/*
	1	接入方机构号	字符型	定长，15位	必填字段，取值同基金公司商户号
	2	基金公司商户号	字符型	定长，15位	必填字段，15位，基金公司商户号，由ChinaPay给基金公司分配的15位定长的唯一代号。
	3	交易类型	字符型	定长，4位	必填字段，1010:开户下单
	4	基金公司交易日期	字符型	定长，8位	必填字段，YYYYMMDD
	5	基金公司交易时间	字符型	定长，6位	必填字段，HHmmss
	6	基金公司流水号	字符型	变长，20位	必填字段，取值当日不可重复
	7	定投协议号	字符型	变长，30位	条件字段，如果为定投签约交易时此域必填，非定投签约交易此域填空
	8	持卡人卡号	字符型	变长，50位	必填字段，个人客户为卡号最长19位，企业客户最长50位
	9	持卡人姓名	字符型	变长，20位	必填字段
	10	用户类型	字符型	定长，1位	必填字段，用户类型 ‘8’为CD卡高级用户，’9’为普通用户，’0’为企业客户
	11	证件类型	字符型	定长，2位	必填字段，证件类型，证件类型的定义参见【数据字典 证件类型】
	12	证件号	字符型	变长，23位	必填字段，
	13	开户行名称	字符型	变长，50位	可为空字段
	14	支行名称	字符型	变长，50位	可为空字段
	15	开户行省份名称	字符型	变长，20位	可为空字段
	16	开户行城市名称	字符型	变长，40位	可为空字段
	17	性别	字符型	定长，1位	必填字段，客户性别，‘F’ – 女   ‘M’ – 男
	18	邮箱	字符型	变长，40位	可为空字段
	19	手机号	数字型	定长，11位	可为空字段
	20	基金类型	字符型	定长，1位	条件字段，开户时此字段可为空，定投签约/解约必填。基金类型，基金类型定义如下：’0’—股票基金，’1’—货币基金，’2’—债券基金定投签约/解约
	21	基金代码	字符型	定长，6位	条件字段，开户时此字段可为空，定投签约/解约必填。基金业务品种，具体代号含义由基金公司确定（限制：业务品种代号不允许定义为“000000”）。例如：162201  合丰成长基金
	*/
	
	private String instuId;
	private String fundMerId;
	private String transType;
	private String fundTransDate;
	private String fundTransTime;
	private String fundTransSerial;
	private String protocol;
	private String cardNo;
	private String userName;
	private String userType;
	private String certType;
	private String certId;
	private String openBankName;
	private String subOpenBankName;
	private String openBankProvince;
	private String openBankCity;
	private String gender;
	private String email;
	private String mobile;
	private String fundType;
	private String fundCode;
	private String resv1;
	private String resv2;
	private String resv3;
	private String resv4;
	
	
	public String serial() {
		StringBuilder builder = new StringBuilder();
		builder.append(this.instuId + "|");
		builder.append(this.fundMerId + "|");
		builder.append(this.transType + "|");
		builder.append(this.fundTransDate + "|");
		builder.append(this.fundTransTime + "|");
		builder.append(this.fundTransSerial + "|");
		builder.append(this.protocol + "|");
		builder.append(this.cardNo + "|");
		builder.append(this.userName + "|");
		builder.append(this.userType + "|");
		builder.append(this.certType + "|");
		builder.append(this.certId + "|");
		builder.append(this.openBankName + "|");
		builder.append(this.subOpenBankName + "|");
		builder.append(this.openBankProvince + "|");
		builder.append(this.openBankCity + "|");
		builder.append(this.gender + "|");
		builder.append(this.email + "|");
		builder.append(this.mobile + "|");
		builder.append(this.fundType + "|");
		builder.append(this.fundCode + "|");
		builder.append(this.resv1 + "|");
		builder.append(this.resv2 + "|");
		builder.append(this.resv3 + "|");
		builder.append(this.resv4);
		return builder.toString();
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
	public String getFundTransDate() {
		return fundTransDate;
	}
	public void setFundTransDate(String fundTransDate) {
		this.fundTransDate = fundTransDate;
	}
	public String getFundTransTime() {
		return fundTransTime;
	}
	public void setFundTransTime(String fundTransTime) {
		this.fundTransTime = fundTransTime;
	}
	public String getFundTransSerial() {
		return fundTransSerial;
	}
	public void setFundTransSerial(String fundTransSerial) {
		this.fundTransSerial = fundTransSerial;
	}
	public String getProtocol() {
		return protocol;
	}
	public void setProtocol(String protocol) {
		this.protocol = protocol;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
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
	public String getOpenBankName() {
		return openBankName;
	}
	public void setOpenBankName(String openBankName) {
		this.openBankName = openBankName;
	}
	public String getSubOpenBankName() {
		return subOpenBankName;
	}
	public void setSubOpenBankName(String subOpenBankName) {
		this.subOpenBankName = subOpenBankName;
	}
	public String getOpenBankProvince() {
		return openBankProvince;
	}
	public void setOpenBankProvince(String openBankProvince) {
		this.openBankProvince = openBankProvince;
	}
	public String getOpenBankCity() {
		return openBankCity;
	}
	public void setOpenBankCity(String openBankCity) {
		this.openBankCity = openBankCity;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getFundType() {
		return fundType;
	}
	public void setFundType(String fundType) {
		this.fundType = fundType;
	}
	public String getFundCode() {
		return fundCode;
	}
	public void setFundCode(String fundCode) {
		this.fundCode = fundCode;
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
