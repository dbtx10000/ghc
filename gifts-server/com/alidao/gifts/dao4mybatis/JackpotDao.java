package com.alidao.gifts.dao4mybatis;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.alidao.gifts.entity.Jackpot;
import com.alidao.jxe.ibatis.BaseDao;



@Repository
public class JackpotDao extends BaseDao<Jackpot> {

	// 扩展方法写下面
	
	public int modifyCounts(Jackpot object) {
		return super.update("modifyCounts", object);
	}
	
	/**
	 * 根据类型获取所有的奖池里存在的关联ID,用于导入的时候显示列表排除已经在奖池里的数据
	 * @param relateType
	 * @param productId
	 * @return
	 */
	public List<Jackpot> getAllJackpotRelateIdByRelateType(Integer relateType,String productId){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("relateType", relateType);
		map.put("productId", productId);
		return super.queryForList("getAllJackpotRelateIdByRelateType", map);
	}
	
	/**
	 * 根据关联类型和奖池类型动态获取数据(排除剩余数为0的数据,除了图文),用于摇一摇接口
	 * @param relateType
	 * @param productId
	 * @return
	 */
	public List<Jackpot> getAllJackpotByShake(Integer relateType,String productId){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("relateType", relateType);
		map.put("productId", productId);
		return super.queryForList("getAllJackpotByShake", map);
	}
}
