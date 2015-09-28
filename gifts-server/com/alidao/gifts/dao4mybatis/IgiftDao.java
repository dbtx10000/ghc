package com.alidao.gifts.dao4mybatis;

import org.springframework.stereotype.Repository;

import com.alidao.gifts.entity.Igift;
import com.alidao.jxe.ibatis.BaseDao;

@Repository
public class IgiftDao extends BaseDao<Igift> {

	// 扩展方法写下面

	public int modifyCounts(Igift object) {
		return super.update("modifyCounts", object);
	}
	
}