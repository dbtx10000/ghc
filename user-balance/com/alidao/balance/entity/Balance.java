package com.alidao.balance.entity;

import com.alidao.jxe.model.LpkModel;

public class Balance extends LpkModel  {

    private static final long serialVersionUID = 1L;

    private String userId;

    private Double totalBalance;

    private Double freezingBalance;

    private Double surplusBalance;

    private Long lastModify;

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

    public Double getTotalBalance() {
        return totalBalance==null?0:this.totalBalance;
    }

    public void setTotalBalance(Double totalBalance) {
        this.totalBalance = totalBalance;
    }

    public Double getFreezingBalance() {
        return freezingBalance == null?0:this.freezingBalance;
    }

    public void setFreezingBalance(Double freezingBalance) {
        this.freezingBalance = freezingBalance;
    }

    public Double getSurplusBalance() {
        return surplusBalance == null?0:this.surplusBalance;
    }

    public void setSurplusBalance(Double surplusBalance) {
        this.surplusBalance = surplusBalance;
    }

    public Long getLastModify() {
        return lastModify;
    }

    public void setLastModify(Long lastModify) {
        this.lastModify = lastModify;
    }
}