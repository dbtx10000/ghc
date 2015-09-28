package com.alidao.users.entity;

import java.util.Date;

import com.alidao.basic.entity.Order;
import com.alidao.basic.entity.Product;
import com.alidao.jxe.model.LpkModel;

public class UserInvest extends LpkModel {

	private static final long serialVersionUID = 75312709299390428L;
	
	public static final int STATUS_APPLY_ED = 1;

	public static final int STATUS_HOLD_ING = 2;
	
	public static final int STATUS_HAS_OVER = 3;
	
	public static final int SOURCE_ORDER = 1;

	public static final int SOURCE_INPUT = 2;
	
	private String userId;

    private String productId;

    private String productName;

    private Double income;

    private Integer incomeFloat;
    
    private Integer incomeType;
    
    private Date incomeStartTime;

    private Date incomeEndTime;
    
    private Integer incomeDays;

	private Integer investMoney;

    private Double incomeMoney;

    private Date investTime;
    
    private Integer status;
    
    private Integer source;
    
    private String orderId;
    
    private Double current;
    
    private Integer readed;
    
    private Order order;
    
    private Double doubleIncomeMoney;
    
    private Integer jackpot;
    
    private String productType;//产品分类
    
    private Date repayTime;
    
    public void beforeInsert() {
    	if (this.incomeMoney == null) {
    		this.incomeMoney = _calcAllIncomeMoney();
    	}
    	if (this.readed == null) {
    		this.readed = 0;
    	}
    }
    
    public void beforeUpdate() {
    	if (this.incomeMoney == null) {
    		this.incomeMoney = _calcAllIncomeMoney();
    	}
	}
    
    /*
    public int calcAllIncomeMoney() {
    	int days = 0;
    	if (this.incomeType == Product.INCOME_TYPE_FIXED) {
    		long time = this.incomeEndTime.getTime();
    		time = time - this.incomeStartTime.getTime();
    		days = (int) ((time) / (24 * 60 * 60 * 1000)) + 1;
    	} else {
    		days = this.incomeDays;
    	}
		Double yearIncome = (this.income / 100) * this.investMoney;
		return (int) Math.round(yearIncome * days / 365);
    }
    */
    
    public double _calcAllIncomeMoney() {
    	int days = 0;
    	if (this.incomeType == Product.INCOME_TYPE_FIXED) {
    		long time = this.incomeEndTime.getTime();
    		time = time - this.incomeStartTime.getTime();
    		days = (int) ((time) / (24 * 60 * 60 * 1000)) + 1;
    	} else {
    		days = this.incomeDays;
    	}
		Double yearIncome = (this.income / 100) * this.investMoney;
		return yearIncome * days / 365;
    }
    
    public double calcDayIncomeMoney() {
		Double yearIncome = (this.income / 100);
		yearIncome = yearIncome * this.investMoney;
		return yearIncome / 365;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId == null ? null : productId.trim();
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName == null ? null : productName.trim();
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

	public Integer getIncomeType() {
		return incomeType;
	}

	public void setIncomeType(Integer incomeType) {
		this.incomeType = incomeType;
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

    public Integer getIncomeDays() {
		return incomeDays;
	}

	public void setIncomeDays(Integer incomeDays) {
		this.incomeDays = incomeDays;
	}

	public Integer getInvestMoney() {
        return investMoney;
    }

    public void setInvestMoney(Integer investMoney) {
        this.investMoney = investMoney;
    }

    public Double getIncomeMoney() {
        return incomeMoney;
    }

    public void setIncomeMoney(Double incomeMoney) {
        this.incomeMoney = incomeMoney;
    }

    public Date getInvestTime() {
        return investTime;
    }

    public void setInvestTime(Date investTime) {
        this.investTime = investTime;
    }

	public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

	public Integer getSource() {
		return source;
	}

	public void setSource(Integer source) {
		this.source = source;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public Double getCurrent() {
		return current;
	}

	public void setCurrent(Double current) {
		this.current = current;
	}

	public Integer getReaded() {
		return readed;
	}

	public void setReaded(Integer readed) {
		this.readed = readed;
	}
	
	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public Double getDoubleIncomeMoney() {
		return doubleIncomeMoney;
	}

	public void setDoubleIncomeMoney(Double doubleIncomeMoney) {
		this.doubleIncomeMoney = doubleIncomeMoney;
	}

	public Integer getJackpot() {
		return jackpot;
	}

	public void setJackpot(Integer jackpot) {
		this.jackpot = jackpot;
	}

	public String getProductType() {
		return productType;
	}

	public void setProductType(String productType) {
		this.productType = productType;
	}

	public Date getRepayTime() {
		return repayTime;
	}

	public void setRepayTime(Date repayTime) {
		this.repayTime = repayTime;
	}
	
	
}