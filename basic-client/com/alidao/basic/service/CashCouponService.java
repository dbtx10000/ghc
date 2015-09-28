package com.alidao.basic.service;

import java.util.List;

import com.alidao.basic.entity.CashCoupon;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

public interface CashCouponService {

	public abstract int save(CashCoupon object);
	
	public abstract int mdfy(CashCoupon object);
	
	public abstract int lose(String id);
	
	public abstract int lose(CashCoupon object);
	
	public abstract CashCoupon find(String id);
	
	public abstract CashCoupon find(CashCoupon object);
	
	public abstract Page<CashCoupon> page(PageParam pageParam, CashCoupon object);
	
	public abstract List<CashCoupon> list(CashCoupon object);
	
	public abstract int read(String userId);
	
	public abstract Integer getCashCoupons(String userId);
	
}
