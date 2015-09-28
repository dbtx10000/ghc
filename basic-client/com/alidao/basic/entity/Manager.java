package com.alidao.basic.entity;

import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.model.SpkModel;

public class Manager extends SpkModel {

	private static final long serialVersionUID = 1L;
	
	/** 正常 **/
	public static final int NORMAL = 1;
	/** 禁用 **/
	public static final int PAUSED = 2;
	
	public static final String[] VERIFY_FIELDS = { 
		"code", "username", "password", "linkman", "telephone"
	};
	
	private String code;

    private String username;

    private String password;

    private String linkman;

    private String telephone;

    private Integer status;
    
    public void beforeInsert() {
		if (this.status == null) {
			this.status = NORMAL;
		}
	}
    
    public void beforeUpdate() {
    	if (StringUtil.isEmpty(this.password)) {
			this.password = null;
		}
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code == null ? null : code.trim();
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

    public String getLinkman() {
        return linkman;
    }

    public void setLinkman(String linkman) {
        this.linkman = linkman == null ? null : linkman.trim();
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone == null ? null : telephone.trim();
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

}