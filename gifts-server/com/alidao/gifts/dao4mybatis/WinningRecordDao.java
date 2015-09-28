package com.alidao.gifts.dao4mybatis;

import org.springframework.stereotype.Repository;

import com.alidao.gifts.entity.WinningRecord;
import com.alidao.jxe.ibatis.BaseDao;

@Repository
public class WinningRecordDao extends BaseDao<WinningRecord> {

	// 扩展方法写下面
	
	/**
	 * 查询用户今天的抽中奖品数，用于判断每人每天中奖最大数的逻辑处理
	 * @param userId
	 * @return
	 */
	public Integer getWinningCountByUidInThisday(String userId){
		return (Integer)super.queryForObject("getWinningCountByUidInThisday", userId);
	}
}
