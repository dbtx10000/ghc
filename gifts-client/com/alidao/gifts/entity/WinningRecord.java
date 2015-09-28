package com.alidao.gifts.entity;

import com.alidao.jxe.model.SpkModel;
import com.alidao.users.entity.User;

/**
 * 中奖记录实体类
 * @author 曹晓峰
 * 2014-12-22
 */
public class WinningRecord extends SpkModel {
	
	private static final long serialVersionUID = 1L;
	
	/** 红包 **/
	public static final int TYPE_REDPACKET = 1;
	/** 奖品 **/
	public static final int TYPE_AWARD = 2;
	
	private String userId;

	private String relateId;
    
    private Integer relateType;
    
    private String relateName;

    private String sncode;
    
    private Double lng;
    
    private Double lat;
    
    private User userInfo;

	public User getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(User userInfo) {
		this.userInfo = userInfo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getRelateId() {
		return relateId;
	}

	public void setRelateId(String relateId) {
		this.relateId = relateId;
	}

	public Integer getRelateType() {
		return relateType;
	}

	public void setRelateType(Integer relateType) {
		this.relateType = relateType;
	}

	public String getRelateName() {
		return relateName;
	}

	public void setRelateName(String relateName) {
		this.relateName = relateName;
	}

	public String getSncode() {
		return sncode;
	}

	public void setSncode(String sncode) {
		this.sncode = sncode;
	}

	public Double getLng() {
		return lng;
	}

	public void setLng(Double lng) {
		this.lng = lng;
	}

	public Double getLat() {
		return lat;
	}

	public void setLat(Double lat) {
		this.lat = lat;
	}

	
}