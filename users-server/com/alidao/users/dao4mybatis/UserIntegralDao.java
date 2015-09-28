package com.alidao.users.dao4mybatis;

import java.util.Date;

import org.springframework.stereotype.Repository;

import com.alidao.jse.util.DateUtil;
import com.alidao.jxe.ibatis.BaseDao;
import com.alidao.users.entity.UserIntegral;

@Repository
public class UserIntegralDao extends BaseDao<UserIntegral> {

	// 扩展方法写下面
	
	public int sumOfIntegral(UserIntegral object) {
		Integer isum = (Integer) queryForObject("sumOfIntegral", object);
		return ((isum == null) ? 0 : isum);
	}
	
	public int setUserStatus(UserIntegral object) {
		return update("setUserStatus", object);
	}
	
	public int insert(UserIntegral object){
		object.setSellIntegral(object.getIntegral());
		if(object.getVaildEndTime()==null){
			object.setVaildEndTime(DateUtil.monthAddMonth(new Date(), 3));
		}
		return super.insert(object);
	}
	
}
