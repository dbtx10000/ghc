package com.alidao.balance.entity;

import com.alidao.jxe.model.LpkModel;


public class Withdrawals extends LpkModel  {

    private static final long serialVersionUID = 1L;
    
    /** 提交申请 **/
    public static final int STATUS_SUBMIT_APPLY = 1;
    /** 处理中 **/
    public static final int STATUS_DISPOSEING = 2;
    /** 处理成功 **/
    public static final int STATUS_DISPOSE_SUCCESS = 3;
    /** 处理失败 **/
    public static final int STATUS_DISPOSE_FAIL = 4;

    private String userId;

    private String username;

    private String realname;

    private Double money;

    private Integer status;

    private String note;

    private Double beforeBalance;

    private Double afterBalance;

    private String serial;

    private String openBankId;

    private String openBankName;

    private String bankCardNo;

    private String bankCertId;

    private String bankUserName;

    private String bankCertType;

    private String bankUserProv;

    private String bankUserCity;

    public void beforeInsert() {

    }

    public void beforeUpdate() {

    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname == null ? null : realname.trim();
    }

    public Double getMoney() {
        return money;
    }

    public void setMoney(Double money) {
        this.money = money;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note == null ? null : note.trim();
    }

    public Double getBeforeBalance() {
        return beforeBalance;
    }

    public void setBeforeBalance(Double beforeBalance) {
        this.beforeBalance = beforeBalance;
    }

    public Double getAfterBalance() {
        return afterBalance;
    }

    public void setAfterBalance(Double afterBalance) {
        this.afterBalance = afterBalance;
    }

    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial == null ? null : serial.trim();
    }

    public String getOpenBankId() {
        return openBankId;
    }

    public void setOpenBankId(String openBankId) {
        this.openBankId = openBankId == null ? null : openBankId.trim();
    }

    public String getOpenBankName() {
        return openBankName;
    }

    public void setOpenBankName(String openBankName) {
        this.openBankName = openBankName == null ? null : openBankName.trim();
    }

    public String getBankCardNo() {
        return bankCardNo;
    }

    public void setBankCardNo(String bankCardNo) {
        this.bankCardNo = bankCardNo == null ? null : bankCardNo.trim();
    }

    public String getBankCertId() {
        return bankCertId;
    }

    public void setBankCertId(String bankCertId) {
        this.bankCertId = bankCertId == null ? null : bankCertId.trim();
    }

    public String getBankUserName() {
        return bankUserName;
    }

    public void setBankUserName(String bankUserName) {
        this.bankUserName = bankUserName == null ? null : bankUserName.trim();
    }

    public String getBankCertType() {
        return bankCertType;
    }

    public void setBankCertType(String bankCertType) {
        this.bankCertType = bankCertType == null ? null : bankCertType.trim();
    }

    public String getBankUserProv() {
        return bankUserProv;
    }

    public void setBankUserProv(String bankUserProv) {
        this.bankUserProv = bankUserProv == null ? null : bankUserProv.trim();
    }

    public String getBankUserCity() {
        return bankUserCity;
    }

    public void setBankUserCity(String bankUserCity) {
        this.bankUserCity = bankUserCity == null ? null : bankUserCity.trim();
    }
}