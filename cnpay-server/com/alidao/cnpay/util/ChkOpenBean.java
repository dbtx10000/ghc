package com.alidao.cnpay.util;

public class ChkOpenBean {

	/*
	1	merchantId	字符型	定长，15位	必填字段，15位，基金公司商户号，由ChinaPay给基金公司分配的15位定长的唯一代号
	2	merchantOrderId	数字型	变长	必填字段，取值当日不可重复
	3	merchantOrderTime	字符型	定长，14位	必填字段，YYYYMMDDHHmmss
	4	orderKey	字符型	变长 	必填字段，下单操作后返回的订单特征码
	5	pgRetUrl	字符型	变长	必填字段，支付结果页面返回商户页面url
	6	sign	字符型	变长	必填字段，商户用私钥对merchantId,merchantOrderId,merchantOrderTime,orderKey 作签名
	*/
	
	private String merchantId;
	private String merchantOrderId;
	private String merchantOrderTime;
	private String orderKey;
	private String pgRetUrl;
	private String sign;
	
	public String getMerchantId() {
		return merchantId;
	}
	public void setMerchantId(String merchantId) {
		this.merchantId = merchantId;
	}
	public String getMerchantOrderId() {
		return merchantOrderId;
	}
	public void setMerchantOrderId(String merchantOrderId) {
		this.merchantOrderId = merchantOrderId;
	}
	public String getMerchantOrderTime() {
		return merchantOrderTime;
	}
	public void setMerchantOrderTime(String merchantOrderTime) {
		this.merchantOrderTime = merchantOrderTime;
	}
	public String getOrderKey() {
		return orderKey;
	}
	public void setOrderKey(String orderKey) {
		this.orderKey = orderKey;
	}
	public String getPgRetUrl() {
		return pgRetUrl;
	}
	public void setPgRetUrl(String pgRetUrl) {
		this.pgRetUrl = pgRetUrl;
	}
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}
	
}
