package com.alidao.basic.entity;

import java.util.Date;
import java.util.List;

import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.model.SpkModel;

public class Product extends SpkModel implements Comparable<Product> {
	
	private static final long serialVersionUID = 1L;
	
	/** 开放购买 **/
	public static final int OPEN_BUY = 1;
	/** F码购买 **/
	public static final int FCODE_BUY = 2;
	
	/** 开放购买 **/
	public static final int CTRL_STAT_BUY_OPEN = 1;
	/** 关闭购买 **/
	public static final int CTRL_STAT_BUY_QUIT = 2;
	/** 到期退出 **/
	public static final int CTRL_STAT_DUE_QUIT = 3;
	
	/** 固定日期.**/
	public static final int INCOME_TYPE_FIXED = 1;
	/** 浮动日期.**/
	public static final int INCOME_TYPE_FLOAT = 2;
	
	
	/** 产品类型 **/
	public static final int TYPE_COMMON = 1;//普通产品
	public static final int TYPE_SPECIAL = 2;//特权本金
	
	/** 是否仅线上支付 **/
	public static final int PAY_TYPE_TRUE = 1;//仅线上支付
	public static final int PAY_TYPE_FALSE = 0;
	
    private String name;

    private Integer buyType;
    
    private Integer controlStatus;

    private String typeId;

    private Date incomeStartTime;

    private Date incomeEndTime;

    private Date subscribeStartTime;

    private Date subscribeEndTime;

    private String logo;

    private Integer totalMoney;

    private Double income;
    
    private Integer incomeFloat;

    private Integer flingMoney;

    private Integer increaseMoney;

    private Integer maxMoney;

    private String allotType;

    private Integer allotTypeShow;

    private String startTime;

    private Integer startTimeShow;

    private String endTime;

    private Integer endTimeShow;
    
    private String expectIncome;
    
    private Integer expectIncomeShow;

    private String bankName;

    private String accountName;

    private String account;
    
    private Integer integral;
    
    private String intro;
    
    private String productNote;

    private String allotNote;

    private String contractNote;
    
    private Date contractTime;
    
    private Integer jackpot;
    
    private Integer gainByScale;
    
    private Integer integralLimit;
    
    private Integer canUseCoupon;
    
    private Integer incomeType;
    
    private Integer incomeDays;
    
    private Long useIntegralType;
    
    private ProductType productType;
    
    private Integer status;		//状态
    
    private Integer surplusMoney;	//	剩余可投
    
    private String progress;	//进度
    
    private Integer orderCount;		//定购订单数
    
    private List<ProductProject> productProjects;	//自定义项目
    
    private Integer buyStatus;
    
    private Integer smallProduct;
    
    private Integer subscribeMoney;//认购金额
    
    private Integer actualPayMoney;//实际支付金额
    
    private Integer game;
    
    private Integer payType;//是否仅线上支付 
    
    /** 产品类型 **/
    private Integer type;
    
    public void beforeInsert() {
		if(this.type==TYPE_SPECIAL){
			if(this.buyType==null){
				this.buyType = OPEN_BUY;
			}
			if(this.incomeType==null){
				this.incomeType=INCOME_TYPE_FLOAT;
			}
			if(this.canUseCoupon==null){
				this.canUseCoupon=0;
			}
			if(StringUtil.isEmpty(this.bankName)){
				this.bankName="";
			}
			if(StringUtil.isEmpty(this.accountName)){
				this.accountName="";
			}
			if(StringUtil.isEmpty(this.account)){
				this.account="";
			}
			this.totalMoney=0;
			this.flingMoney=0;
			this.increaseMoney=0;
			this.maxMoney=0;
			this.smallProduct=1;
			this.jackpot=0;
			this.game=0;
			this.payType=1;
		}
	}
    
    public Integer getGame() {
		return game;
	}

	public void setGame(Integer game) {
		this.game = game;
	}

	public int compareTo(Product that) {
    	int result = this.buyStatus.compareTo(that.buyStatus);
    	if (result == 0) {
    		if (this.getBuyStatus() != 4) {
    			result = that.subscribeEndTime.
    				compareTo(this.subscribeEndTime);
    		} else {
    			result = that.subscribeStartTime.
    				compareTo(this.subscribeStartTime);
    		}
    	}
		return result;
	}
    
	public Integer getSmallProduct() {
		return smallProduct;
	}

	public void setSmallProduct(Integer smallProduct) {
		this.smallProduct = smallProduct;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getBuyType() {
		return buyType;
	}

	public void setBuyType(Integer buyType) {
		this.buyType = buyType;
	}
	
	public Integer getControlStatus() {
		return controlStatus;
	}

	public void setControlStatus(Integer controlStatus) {
		this.controlStatus = controlStatus;
	}

	public String getTypeId() {
		return typeId;
	}

	public void setTypeId(String typeId) {
		this.typeId = typeId;
	}

	public Date getIncomeStartTime() {
		return incomeStartTime;
	}

	public void setIncomeStartTime(Date incomeStartTime) {
		this.incomeStartTime = incomeStartTime;
	}

	public Date getIncomeEndTime() {
		return incomeEndTime;
	}

	public void setIncomeEndTime(Date incomeEndTime) {
		this.incomeEndTime = incomeEndTime;
	}

	public Date getSubscribeStartTime() {
		return subscribeStartTime;
	}

	public void setSubscribeStartTime(Date subscribeStartTime) {
		this.subscribeStartTime = subscribeStartTime;
	}

	public Date getSubscribeEndTime() {
		return subscribeEndTime;
	}

	public void setSubscribeEndTime(Date subscribeEndTime) {
		this.subscribeEndTime = subscribeEndTime;
	}

	public String getLogo() {
		return logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}

	public Integer getTotalMoney() {
		return totalMoney;
	}

	public void setTotalMoney(Integer totalMoney) {
		this.totalMoney = totalMoney;
	}

	public Double getIncome() {
		return income;
	}

	public void setIncome(Double income) {
		this.income = income;
	}
	
	public Integer getIncomeFloat() {
		return incomeFloat;
	}

	public void setIncomeFloat(Integer incomeFloat) {
		this.incomeFloat = incomeFloat;
	}

	public Integer getFlingMoney() {
		return flingMoney;
	}

	public void setFlingMoney(Integer flingMoney) {
		this.flingMoney = flingMoney;
	}

	public Integer getIncreaseMoney() {
		return increaseMoney;
	}

	public void setIncreaseMoney(Integer increaseMoney) {
		this.increaseMoney = increaseMoney;
	}

	public Integer getMaxMoney() {
		return maxMoney;
	}

	public void setMaxMoney(Integer maxMoney) {
		this.maxMoney = maxMoney;
	}

	public String getAllotType() {
		return allotType;
	}

	public void setAllotType(String allotType) {
		this.allotType = allotType;
	}

	public Integer getAllotTypeShow() {
		return allotTypeShow;
	}

	public void setAllotTypeShow(Integer allotTypeShow) {
		this.allotTypeShow = allotTypeShow;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public Integer getStartTimeShow() {
		return startTimeShow;
	}

	public void setStartTimeShow(Integer startTimeShow) {
		this.startTimeShow = startTimeShow;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public Integer getEndTimeShow() {
		return endTimeShow;
	}

	public void setEndTimeShow(Integer endTimeShow) {
		this.endTimeShow = endTimeShow;
	}

	public String getExpectIncome() {
		return expectIncome;
	}

	public void setExpectIncome(String expectIncome) {
		this.expectIncome = expectIncome;
	}

	public Integer getExpectIncomeShow() {
		return expectIncomeShow;
	}

	public void setExpectIncomeShow(Integer expectIncomeShow) {
		this.expectIncomeShow = expectIncomeShow;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getAccountName() {
		return accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public Integer getIntegral() {
		return integral;
	}

	public void setIntegral(Integer integral) {
		this.integral = integral;
	}
	
	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public String getProductNote() {
		return productNote;
	}

	public void setProductNote(String productNote) {
		this.productNote = productNote;
	}

	public String getAllotNote() {
		return allotNote;
	}

	public void setAllotNote(String allotNote) {
		this.allotNote = allotNote;
	}

	public String getContractNote() {
		return contractNote;
	}

	public void setContractNote(String contractNote) {
		this.contractNote = contractNote;
	}
	
	public Date getContractTime() {
		return contractTime;
	}

	public void setContractTime(Date contractTime) {
		this.contractTime = contractTime;
	}
	
	public Integer getJackpot() {
		return jackpot;
	}

	public void setJackpot(Integer jackpot) {
		this.jackpot = jackpot;
	}
	
	public Integer getGainByScale() {
		return gainByScale;
	}

	public void setGainByScale(Integer gainByScale) {
		this.gainByScale = gainByScale;
	}

	public Integer getIntegralLimit() {
		return integralLimit;
	}

	public void setIntegralLimit(Integer integralLimit) {
		this.integralLimit = integralLimit;
	}
	
	public Integer getCanUseCoupon() {
		return canUseCoupon;
	}

	public void setCanUseCoupon(Integer canUseCoupon) {
		this.canUseCoupon = canUseCoupon;
	}

	public Integer getIncomeType() {
		return incomeType;
	}

	public void setIncomeType(Integer incomeType) {
		this.incomeType = incomeType;
	}
	
	public Integer getIncomeDays() {
		return incomeDays;
	}

	public void setIncomeDays(Integer incomeDays) {
		this.incomeDays = incomeDays;
	}

	public Long getUseIntegralType() {
		return useIntegralType;
	}

	public void setUseIntegralType(Long useIntegralType) {
		this.useIntegralType = useIntegralType;
	}

	public ProductType getProductType() {
		return productType;
	}

	public void setProductType(ProductType productType) {
		this.productType = productType;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getSurplusMoney() {
		return surplusMoney;
	}

	public void setSurplusMoney(Integer surplusMoney) {
		this.surplusMoney = surplusMoney;
	}

	public String getProgress() {
		return progress;
	}

	public void setProgress(String progress) {
		this.progress = progress;
	}

	public Integer getOrderCount() {
		return orderCount;
	}

	public void setOrderCount(Integer orderCount) {
		this.orderCount = orderCount;
	}

	public List<ProductProject> getProductProjects() {
		return productProjects;
	}

	public void setProductProjects(List<ProductProject> productProjects) {
		this.productProjects = productProjects;
	}

	public Integer getBuyStatus() {
		return buyStatus;
	}

	public void setBuyStatus(Integer buyStatus) {
		this.buyStatus = buyStatus;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getSubscribeMoney() {
		return subscribeMoney;
	}

	public void setSubscribeMoney(Integer subscribeMoney) {
		this.subscribeMoney = subscribeMoney;
	}

	public Integer getActualPayMoney() {
		return actualPayMoney;
	}

	public void setActualPayMoney(Integer actualPayMoney) {
		this.actualPayMoney = actualPayMoney;
	}

	public Integer getPayType() {
		return payType;
	}

	public void setPayType(Integer payType) {
		this.payType = payType;
	}

}