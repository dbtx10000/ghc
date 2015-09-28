package com.alidao.basic.entity;

import java.util.Date;

import com.alidao.jxe.model.SpkModel;
import com.alidao.users.entity.User;

public class Order extends SpkModel {
	
	private static final long serialVersionUID = 1L;
	
	public static final int UNPAY = -1;
	
	public static final int PAYED = +1;
	
	public static final int CLOSE = +2;
	
	private String payNo;
	
    private String userId;

    private String userUsername;

    private String userLinkman;

    private String userContact;

    private String productId;

    private Integer investMoney;

    private Integer payType;

    private String serialNo;

    private Integer status;

    private Date payTime;
    
    private String cmerId;
    
    private String cardNo;
    
    private String openBankId;
    
    private String userName;
    
    private String certType;
    
    private String certId;
    
    private Integer useIntegral;
    
    private String sourceId;
    
    private Integer type;
    
    private String cashId;
    
    private Integer cashMoney;
    
    private Product product;
    
    private User user;
    /**
     * 产品类型
     */
    private Integer productType;
    
    private Integer actualMoney;//实际支付金额
    
    private Integer onlinePay;//是否线上支付 
    
    /** 普通产品 **/
	public static final int PRODUCT_TYPE_COMMON = 1;
	/** 特权本金 **/
	public static final int PRODUCT_TYPE_SPECIAL = 2;
	
	public String getPayNo() {
		return payNo;
	}

	public void setPayNo(String payNo) {
		this.payNo = payNo;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getCashId() {
		return cashId;
	}

	public void setCashId(String cashId) {
		this.cashId = cashId;
	}

	public Integer getCashMoney() {
		return cashMoney==null?0:this.cashMoney;
	}

	public void setCashMoney(Integer cashMoney) {
		this.cashMoney = cashMoney;
	}

	public String getSourceId() {
		return sourceId;
	}

	public void setSourceId(String sourceId) {
		this.sourceId = sourceId;
	}

	public Integer getUseIntegral() {
		return useIntegral==null?0:this.useIntegral;
	}

	public void setUseIntegral(Integer useIntegral) {
		this.useIntegral = useIntegral;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserUsername() {
		return userUsername;
	}

	public void setUserUsername(String userUsername) {
		this.userUsername = userUsername;
	}

	public String getUserLinkman() {
		return userLinkman;
	}

	public void setUserLinkman(String userLinkman) {
		this.userLinkman = userLinkman;
	}

	public String getUserContact() {
		return userContact;
	}

	public void setUserContact(String userContact) {
		this.userContact = userContact;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public Integer getInvestMoney() {
		return investMoney;
	}

	public void setInvestMoney(Integer investMoney) {
		this.investMoney = investMoney;
	}

	public Integer getPayType() {
		return payType;
	}

	public void setPayType(Integer payType) {
		this.payType = payType;
	}

	public String getSerialNo() {
		return serialNo;
	}

	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Date getPayTime() {
		return payTime;
	}

	public void setPayTime(Date payTime) {
		this.payTime = payTime;
	}

	public String getCmerId() {
		return cmerId;
	}

	public void setCmerId(String cmerId) {
		this.cmerId = cmerId;
	}

	public String getCardNo() {
		return cardNo==null?"":this.cardNo.trim();
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public String getOpenBankId() {
		return openBankId;
	}

	public void setOpenBankId(String openBankId) {
		this.openBankId = openBankId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
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
	
	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public User getUser() {
		return user;
	}

	public Integer getProductType() {
		return productType;
	}

	public void setProductType(Integer productType) {
		this.productType = productType;
	}

	public Integer getActualMoney() {
		return actualMoney==null?0:this.actualMoney;
	}

	public void setActualMoney(Integer actualMoney) {
		this.actualMoney = actualMoney;
	}

	public Integer getOnlinePay() {
		return onlinePay;
	}

	public void setOnlinePay(Integer onlinePay) {
		this.onlinePay = onlinePay;
	}
	
}