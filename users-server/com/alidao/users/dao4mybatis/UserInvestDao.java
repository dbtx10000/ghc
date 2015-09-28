package com.alidao.users.dao4mybatis;

import org.springframework.stereotype.Repository;

import com.alidao.jxe.ibatis.BaseDao;
import com.alidao.users.entity.UserInvest;

@Repository
public class UserInvestDao extends BaseDao<UserInvest> {

	// 扩展方法写下面
	
	public int sumOfInvMoney(UserInvest object) {
		Integer isum = (Integer) queryForObject("sumOfInvMoney", object);
		return ((isum == null) ? 0 : isum);
	}

	public Double sumOfIncMoney(UserInvest object) {
		Double gsum = (Double) queryForObject("sumOfIncMoney", object);
		return ((gsum == null) ? 0 : gsum);
	}
	
	public void updateReaded(UserInvest object) {
		update("updateReaded",object);
	}
	
}
