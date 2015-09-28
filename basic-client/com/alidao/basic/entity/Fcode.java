package com.alidao.basic.entity;

import java.util.Date;
import java.util.Random;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.model.SpkModel;
import com.alidao.users.entity.User;

public class Fcode extends SpkModel {
	
	private static final long serialVersionUID = 1L;
	
	/** 未使用 **/
	public static final int STATUS_NOT_USE = 0;
	/** 已使用 **/
	public static final int STATUS_BE_USED = 1;
	
    private String fcode;

    private Date endTime;

	private Integer status;

    private String userId;
    
    private String productId;
    
    private Manager manager;
    
    private Product product;
    
    private User user;
    
    public void beforeInsert() {
    	if (this.status == null) {
    		this.status = STATUS_NOT_USE;
    	}
    	int rand = new Random().nextInt(9000) + 1000;
    	if (StringUtil.isEmpty(this.fcode)) {
			char _fir = (char) (new Random().nextInt(26) + 65);
			char _sec = (char) (new Random().nextInt(26) + 65);
			char _3rd = (char) (new Random().nextInt(26) + 65);
    		this.fcode = _fir + _sec + _3rd + rand + "";
    	} else {
    		this.fcode += rand + "";
    	}
    }
    
    public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Manager getManager() {
		return manager;
	}

	public void setManager(Manager manager) {
		this.manager = manager;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public String getFcode() {
		return fcode;
	}

	public void setFcode(String fcode) {
		this.fcode = fcode;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}
}