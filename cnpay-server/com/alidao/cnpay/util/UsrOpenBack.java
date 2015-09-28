package com.alidao.cnpay.util;

public class UsrOpenBack {

	/*
	1	接入方机构号	字符型	定长，15位	必填字段，15位，机构代码，由ChinaPay给基金公司分配的15位定长的唯一代号。如非机构方式接入取值必须和基金公司商户号相同
	2	基金公司商户号	字符型	定长，15位	必填字段，15位，基金公司商户号，由ChinaPay给基金公司分配的15位定长的唯一代号。
	3	交易类型	字符型	定长，4位	必填字段 	1010:开户下单3010:申购下单
	4	基金公司交易日期	字符型	定长，8位	必填字段,YYYYMMDD
	5	基金公司交易时间	字符型	定长，6位	必填字段,HHmmss
	6	基金公司流水号	字符型	变长，20位	必填字段
	7	银联通交易日期	字符型	定长，8位	必填字段,YYYYMMDD
	8	银联通交易时间	字符型	定长，6位	必填字段,HHmmss
	9	银联通流水号	字符型	定长，6位	必填字段,
	10	响应码	字符型	定长，3位	必填字段,000：下单成功，其它响应码下单失败，如下单失败无异步开户结果通知。
	11	响应码描述	字符型	变长，50位	可为空字段
	12	订单特征码	字符型	变长,50位	条件字段，由订单系统生成响应码为“000”时，此域不为空，取值为订单系统生成的调用支付插件的特征码
	13	Resv1	字符型	变长，256位	可为空字段，保留项，固定填空，用于以后扩展。
	14	Resv2	字符型	变长，256位	可为空字段，保留项，固定填空，用于以后扩展。
	15	Resv3	字符型	变长，256位	可为空字段，保留项，固定填空，用于以后扩展。
	16	Resv4	字符型	变长，256位	可为空字段，保留项，固定填空，用于以后扩展。
	*/
	
	private String instuId;
	private String fundMerId;
	private String transType;
	private String fundTransDate;
	private String fundTransTime;
	private String fundTransSerial;
	private String cpTransDate;
	private String cpTransTime;
	private String cpTransSerial;
	private String responseCode;
	private String message;
	private String orderKey;
	private String resv1;
	private String resv2;
	private String resv3;
	private String resv4;
	
	public static UsrOpenBack entity(String msg) {
		UsrOpenBack back = new UsrOpenBack();
		String[] params = msg.split("\\|");
		back.setInstuId(params[0]);
		back.setFundMerId(params[1]);
		back.setTransType(params[2]);
		back.setFundTransDate(params[3]);
		back.setFundTransTime(params[4]);
		back.setFundTransSerial(params[5]);
		back.setCpTransDate(params[6]);
		back.setCpTransTime(params[7]);
		back.setCpTransSerial(params[8]);
		back.setResponseCode(params[9]);
		back.setMessage(params[10]);
		if (params.length >= 12) {
			back.setOrderKey(params[11]);
			/*back.setResv1(params[12]);
			back.setResv2(params[13]);
			back.setResv3(params[14]);
			back.setResv4(params[15]);*/
		}
		return back;
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
	public String getCpTransDate() {
		return cpTransDate;
	}
	public void setCpTransDate(String cpTransDate) {
		this.cpTransDate = cpTransDate;
	}
	public String getCpTransTime() {
		return cpTransTime;
	}
	public void setCpTransTime(String cpTransTime) {
		this.cpTransTime = cpTransTime;
	}
	public String getCpTransSerial() {
		return cpTransSerial;
	}
	public void setCpTransSerial(String cpTransSerial) {
		this.cpTransSerial = cpTransSerial;
	}
	public String getResponseCode() {
		return responseCode;
	}
	public void setResponseCode(String responseCode) {
		this.responseCode = responseCode;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getOrderKey() {
		return orderKey;
	}
	public void setOrderKey(String orderKey) {
		this.orderKey = orderKey;
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
