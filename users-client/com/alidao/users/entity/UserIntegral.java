package com.alidao.users.entity;

import java.util.Date;

import com.alidao.jxe.model.LpkModel;

/**
 * 积分消费实体类
 * @author 曹晓峰
 * 2014-10-11
 */
public class UserIntegral extends LpkModel {
	
	private static final long serialVersionUID = -225520178451942569L;
	
	/** 用户注册 **/
	public static final int TYPE_GET_USEROWN_REG = 0;
	
	/** 被邀注册 **/
	public static final int TYPE_GET_INVITED_REG = 1;
	
	/** 邀请注册 **/
	public static final int TYPE_GET_INVITES_REG = 2;
	
	/** 购买产品 **/
	public static final int TYPE_GET_BUY_PRODUCT = 3;
	
	/** 本人注册并认购缴款 **/
	public static final int TYPE_GET_BUY_INTEGRAL = 4;
	
	/** 邀请他们注册且该人认购成功缴款  **/
	public static final int TYPE_GET_INVITE_BUY_INTEGRAL = 5;
	
	/** 系统赠送金币**/
	public static final int TYPE_GET_BACKGROUND = 6; 
	
	/** 抽奖金币**/
	public static final int TYPE_GET_JACKPOT = 7; 
	
	/** 问卷获取金币**/
	public static final int TYPE_GET_QUESTION = 8; 
	
	/** 签到获得金币 **/
	public static final int SIGN_IN_GET_QUESTION = 9;
	
	/** 签到获得金币 **/
	public static final int TYPE_GET_RED_PACK = 10;
	
	/** 未查看 **/
	public static final int STATUS_UN_READ = 0;
	
	/** 已查看 **/
	public static final int STATUS_READ_ED = 1;
	
	private String userId;

	private Integer type;
	
	private Integer integral;
	
	private Integer status;
	
	private String relate;
	
	private String note;
	
	private Integer sellIntegral;
	
	private Date vaildEndTime;
	
	private Long integralTypeId;
	
	public Integer getSellIntegral() {
		return sellIntegral;
	}

	public void setSellIntegral(Integer sellIntegral) {
		this.sellIntegral = sellIntegral;
	}

	public Date getVaildEndTime() {
		return vaildEndTime;
	}

	public void setVaildEndTime(Date vaildEndTime) {
		this.vaildEndTime = vaildEndTime;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getIntegral() {
		return integral;
	}

	public void setIntegral(Integer integral) {
		this.integral = integral;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
	public String getRelate() {
		return relate;
	}

	public void setRelate(String relate) {
		this.relate = relate;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public Long getIntegralTypeId() {
		return integralTypeId;
	}

	public void setIntegralTypeId(Long integralTypeId) {
		this.integralTypeId = integralTypeId;
	}
	
}
