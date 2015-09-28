package com.alidao.users.entity;

import com.alidao.jxe.model.LpkModel;

public class UserBind extends LpkModel {

	private static final long serialVersionUID = -239950706243690839L;

	private String userId;

    private String account;

    private Integer accountType;
    
    private String sessionKey;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account == null ? null : account.trim();
    }

    public Integer getAccountType() {
        return accountType;
    }

    public void setAccountType(Integer accountType) {
        this.accountType = accountType;
    }

	public String getSessionKey() {
		return sessionKey;
	}

	public void setSessionKey(String sessionKey) {
		this.sessionKey = sessionKey == null ? null : sessionKey.trim();
	}

}