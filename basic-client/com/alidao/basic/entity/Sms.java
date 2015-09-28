package com.alidao.basic.entity;

import java.util.Date;

import com.alidao.jxe.model.LpkModel;

public class Sms extends LpkModel {

	private static final long serialVersionUID = 3707448950748567533L;

	/** 用户注册 **/
	public static final int TYPE_REGIST = 1;
	/** 找回密码 **/
	public static final int TYPE_REPSWD = 2;
	
	/** 未使用 **/
	public static final int STATUS_UN_USE = 0;
	/** 已使用 **/
	public static final int STATUS_USE_ED = 1;
	
	private Integer type;
	 
	private String verifyCode;
	 
	private String mobile;
	
	private Integer status;

	private String token;
	
	private Date exceedTime;
	
	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getVerifyCode() {
		return verifyCode;
	}

	public void setVerifyCode(String verifyCode) {
		this.verifyCode = verifyCode;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public Date getExceedTime() {
		return exceedTime;
	}

	public void setExceedTime(Date exceedTime) {
		this.exceedTime = exceedTime;
	}

}
