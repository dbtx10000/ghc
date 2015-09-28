package com.alidao.balance.dao4mybatis;

import com.alidao.balance.entity.Balance;
import com.alidao.jxe.ibatis.BaseDao;
import org.springframework.stereotype.Repository;

@Repository
public class BalanceDao extends BaseDao<Balance> {
	
	public int updateMoney(Balance object) {
		return update("updateMoney", object);
	}

}