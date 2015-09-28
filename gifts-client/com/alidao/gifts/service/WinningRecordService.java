package com.alidao.gifts.service;

import java.util.List;

import com.alidao.gifts.entity.WinningRecord;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

public interface WinningRecordService {
	
	/** 添加 **/
	public abstract int save(WinningRecord object);
	
	/** 修改 **/
	public abstract int mdfy(WinningRecord object);
	
	/** 删除 **/
	public abstract int lose(String id);
	
	/** 删除 **/
	public abstract int lose(WinningRecord object);
	
	/** 查找 **/
	public abstract WinningRecord find(String id);
	
	/** 查找 **/
	public abstract WinningRecord find(WinningRecord object);
	
	/** 分页 **/
	public abstract Page<WinningRecord> page(PageParam pageParam, WinningRecord object);
	
	/** 列举 **/
	public abstract List<WinningRecord> list(WinningRecord object);
	
}
