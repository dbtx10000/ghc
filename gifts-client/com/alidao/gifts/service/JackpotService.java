package com.alidao.gifts.service;

import java.util.List;
import java.util.Map;

import com.alidao.gifts.entity.Jackpot;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;




public interface JackpotService {
	
	/** 添加 **/
	public abstract int save(Jackpot object);
	
	/** 修改 **/
	public abstract int mdfy(Jackpot object);
	
	/** 删除 **/
	public abstract int lose(Jackpot object);
	
	/** 推荐 **/
	public abstract int hot(Jackpot object);
	
	/** 查找 **/
	public abstract Jackpot find(Jackpot object);
	
	/** 查找 **/
	public abstract Jackpot find(String id);
	
	/** 分页 **/
	public abstract Page<Jackpot> page(PageParam pageParam, Jackpot object);
	
	/** 红包导入保存 **/
	public abstract int redPacketSave(String[] ids,Integer[] integral,Integer[] count,Integer[] basic,String productId);
	
	/** 根据类型获取所有的奖池里存在的关联ID,用于导入的时候显示列表排除已经在奖池里的数据 **/
	public abstract String getAllJackpotRelateIdByRelateType(Integer relateType,String productId);
	
	public abstract List<Jackpot> list(Jackpot object);

	public abstract Map<String,Object>luckyDraw(String uid,String productId);

	public abstract int awardSave(String[] ids, Integer[] count,Integer[] basic, String productId);
	
}
