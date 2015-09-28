package com.alidao.basic.dao4mybatis;

import org.springframework.stereotype.Repository;

import com.alidao.basic.entity.CashCoupon;
import com.alidao.jxe.ibatis.BaseDao;

@Repository
public class CashCouponDao extends BaseDao<CashCoupon> {

	// 扩展方法写下面
	
	public int setUserStatus(CashCoupon object) {
		return update("setUserStatus", object);
	}
	
	public int timeoutCheck(CashCoupon object) {
		return update("timeoutCheck", object);
	}
}
