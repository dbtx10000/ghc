package com.alidao.users.dao4mybatis;

import com.alidao.jxe.ibatis.BaseDao;
import com.alidao.users.entity.Saler;

import org.springframework.stereotype.Repository;

@Repository
public class SalerDao extends BaseDao<Saler> {
	
	//修改拉进来的用户数
	public int modifyCounts(Saler object) {
		return super.update("modifyCounts", object);
	}

}