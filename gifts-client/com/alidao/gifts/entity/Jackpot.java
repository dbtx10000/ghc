package com.alidao.gifts.entity;

import com.alidao.jxe.model.SpkModel;



/**
 * 奖池实体类
 * @author
 * 2015-05-27
 */
public class Jackpot extends SpkModel {
	
	private static final long serialVersionUID = 1L;
	
	/** 红包 **/
	public static final int TYPE_RED_PACKET = 1;
	/** 奖品**/
	public static final int TYPE_AWARD = 2;
	
	private Integer jackpotType;//奖池类型， 1.红包 2.抢购
	
	private String relateId;
    
    private Integer relateType;

    private Integer count;
    
    private Integer winCount;
    
	private Integer basic;
    
	private Integer integral;
	
	private Object relate;
    
    private double winProbability;	//中奖机率
    
    private String productId;
    
    public Integer getWinCount() {
		return winCount;
	}

	public void setWinCount(Integer winCount) {
		this.winCount = winCount;
	}

    public Integer getBasic() {
		return basic;
	}

	public void setBasic(Integer basic) {
		this.basic = basic;
	}
	
	public double getWinProbability() {
		return winProbability;
	}

	public void setWinProbability(double winProbability) {
		this.winProbability = winProbability;
	}

	public Object getRelate() {
		return relate;
	}

	public void setRelate(Object relate) {
		this.relate = relate;
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

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public Integer getJackpotType() {
		return jackpotType;
	}

	public void setJackpotType(Integer jackpotType) {
		this.jackpotType = jackpotType;
	}

	public Integer getIntegral() {
		return integral;
	}

	public void setIntegral(Integer integral) {
		this.integral = integral;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}
    
}