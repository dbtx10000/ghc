package com.alidao.users.entity;


import com.alidao.jxe.model.SpkModel;

public class User extends SpkModel {

private static final long serialVersionUID = 625021968049174984L;
	
	/** APP **/
	public static final int SOURCE_APP = 1;
	/** 微信 **/
	public static final int SOURCE_WECHAT = 2;
	/** WAP **/
	public static final int SOURCE_WAP = 3;
	/** PC **/
	public static final int SOURCE_PC = 4;
	/** 分配 **/
	public static final int SOURCE_ALLOT = 5;
	
	/** 绑定微信 **/
	public static final int BINDED_WECHAT = 1;
	
	/** 未激活 **/
	public static final int STATUS_NEWREG = 0;
	/** 待审核 **/
	public static final int STATUS_WAITED = 1;
	/** 使用中 **/
	public static final int STATUS_NORMAL = 2;
	/** 已禁用 **/
	public static final int STATUS_PAUSED = 3;
	
	/** 身份证 **/
	public static final String C_TYPE_01 = "01";
	/** 军官证 **/
	public static final String C_TYPE_02 = "02";
	/** 护照 **/
	public static final String C_TYPE_03 = "03";
	/** 户口簿 **/
	public static final String C_TYPE_04 = "04";
	/** 回乡证 **/
	public static final String C_TYPE_05 = "05";
	/** 其他证 **/
	public static final String C_TYPE_06 = "06";
	
	/** VIP用户 **/
	public static final int U_TYPE_VIPPER = 1;
	/** 普通用户 **/
	public static final int U_TYPE_COMMON = 2;
	/** 销售人员 **/
	public static final int U_TYPE_SELLER = 3;
	
	private String pid;

    private Integer type;

    private Integer source;

    private Integer status;

    private String mobile;

    private String username;

    private String password;

    private String realname;

    private String credentialsType;

    private String credentialsCode;

    private String avatar;

    private String email;

    private String address;

    private String intro;

    private Integer integral;	// 金币数

    private Integer assets;		// 总投资

    private Double income;		// 总收益

    private Integer orders;		// 订单数

    private Integer friend;		// 好友数
    
    private Integer cards;		// 银行卡数
    
    private Integer cashCoupons;

    private String payPassword;
    
    private String touchsPassword;
    
    private String sessionKey;
    
    private String parentName;
    
    private String salerId;
    
    private String isSaler;

    public void beforeInsert() {
    	if (this.integral == null) {
    		this.integral = 0;
    	}
    	if (this.assets == null) {
    		this.assets = 0;
    	}
    	if (this.income == null) {
    		this.income = 0D;
    	}
    	if (this.orders == null) {
    		this.orders = 0;
    	}
    	if (this.friend == null) {
    		this.friend = 0;
    	}
    	if (this.cards == null) {
    		this.cards = 0;
    	}
    }
    
    
    public String getIsSaler() {
		return isSaler;
	}

	public void setIsSaler(String isSaler) {
		this.isSaler = isSaler;
	}

	public String getSalerId() {
		return salerId;
	}

	public void setSalerId(String salerId) {
		this.salerId = salerId;
	}

	public Integer getCards() {
		return cards;
	}

	public void setCards(Integer cards) {
		this.cards = cards;
	}

	public Integer getCashCoupons() {
		return cashCoupons;
	}

	public void setCashCoupons(Integer cashCoupons) {
		this.cashCoupons = cashCoupons;
	}

	public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid == null ? null : pid.trim();
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getSource() {
        return source;
    }

    public void setSource(Integer source) {
        this.source = source;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile == null ? null : mobile.trim();
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname == null ? null : realname.trim();
    }

    public String getCredentialsType() {
        return credentialsType;
    }

    public void setCredentialsType(String credentialsType) {
        this.credentialsType = credentialsType;
    }

    public String getCredentialsCode() {
        return credentialsCode;
    }

    public void setCredentialsCode(String credentialsCode) {
        this.credentialsCode = credentialsCode == null ? null : credentialsCode.trim();
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar == null ? null : avatar.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getIntro() {
        return intro;
    }

    public void setIntro(String intro) {
        this.intro = intro == null ? null : intro.trim();
    }

    public Integer getIntegral() {
        return integral;
    }

    public void setIntegral(Integer integral) {
        this.integral = integral;
    }

    public Integer getAssets() {
        return assets;
    }

    public void setAssets(Integer assets) {
        this.assets = assets;
    }

    public Double getIncome() {
        return income;
    }

    public void setIncome(Double income) {
        this.income = income;
    }

    public Integer getOrders() {
        return orders;
    }

    public void setOrders(Integer orders) {
        this.orders = orders;
    }

    public Integer getFriend() {
        return friend;
    }

    public void setFriend(Integer friend) {
        this.friend = friend;
    }

    public String getPayPassword() {
        return payPassword;
    }

    public void setPayPassword(String payPassword) {
        this.payPassword = payPassword == null ? null : payPassword.trim();
    }

	public String getTouchsPassword() {
		return touchsPassword;
	}

	public void setTouchsPassword(String touchsPassword) {
		this.touchsPassword = touchsPassword == null ? null : touchsPassword.trim();
	}

	public String getSessionKey() {
		return sessionKey;
	}

	public void setSessionKey(String sessionKey) {
		this.sessionKey = sessionKey == null ? null : sessionKey.trim();
	}

	public String getParentName() {
		return parentName;
	}

	public void setParentName(String parentName) {
		this.parentName = parentName;
	}
	
}