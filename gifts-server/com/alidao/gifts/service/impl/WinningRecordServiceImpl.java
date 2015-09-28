package com.alidao.gifts.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alidao.gifts.dao4mybatis.WinningRecordDao;
import com.alidao.gifts.entity.WinningRecord;
import com.alidao.gifts.service.WinningRecordService;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.users.dao4mybatis.UserDao;

@Service
public class WinningRecordServiceImpl implements WinningRecordService {

	@Autowired
	private WinningRecordDao winningRecordDao;
	
	@Autowired
	private UserDao userInfoDao;

	public int save(WinningRecord object) {
		return winningRecordDao.insert(object);
	}

	public int mdfy(WinningRecord object) {
		return winningRecordDao.update(object);
	}

	public int lose(String id) {
		return winningRecordDao.deleteByPrimaryKey(id);
	}

	public int lose(WinningRecord object) {
		return winningRecordDao.delete(object);
	}

	public WinningRecord find(String id) {
		return winningRecordDao.selectByPrimaryKey(id);
	}

	public WinningRecord find(WinningRecord object) {
		return winningRecordDao.select(object);
	}

	public Page<WinningRecord> page(PageParam pageParam, WinningRecord object) {
		Page<WinningRecord> page = winningRecordDao.queryForPage(pageParam, object);
		List<WinningRecord> list = page.getTableList();
		for (int i = 0; list != null && i < list.size(); i++) {	
			WinningRecord winningRecord = list.get(i);
			if(winningRecord != null){
				// 关联用户信息
				winningRecord.setUserInfo(userInfoDao.selectByPrimaryKey(winningRecord.getUserId()));
			}
		}
		return page;
	}

	
	public List<WinningRecord> list(WinningRecord object) {
		return winningRecordDao.queryForList(object);
	}
}
