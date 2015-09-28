package com.alidao.balance.entity;

import com.alidao.jxe.model.LpkModel;


public class BalanceRecord extends LpkModel  {

    private static final long serialVersionUID = 1L;
    
    /** 充值 **/
    public static final int TYPE_RECHARGE = 1;
    /** 提现 **/
    public static final int TYPE_WITHDRAWALS = 2;
    /** 收款--收益 **/
    public static final int TYPE_GATHERING_INCOME = 3;
    /** 收款--本金 **/
    public static final int TYPE_GATHERING_PRINCIPAL = 4;
    /** 购买产品 **/
    public static final int TYPE_BUY_PRODUCT = 5;
    
    
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

    private Integer type;

    private Double money;

    private Integer status;

    private String note;

    private Double beforeBalance;

    private Double afterBalance;

    private String relateId;

    private String relateName;

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

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
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

    public String getRelateId() {
        return relateId;
    }

    public void setRelateId(String relateId) {
        this.relateId = relateId == null ? null : relateId.trim();
    }

    public String getRelateName() {
        return relateName;
    }

    public void setRelateName(String relateName) {
        this.relateName = relateName == null ? null : relateName.trim();
    }
}