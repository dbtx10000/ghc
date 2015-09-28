package com.alidao.users.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alidao.jse.util.DateUtil;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.model.Condition;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.users.dao4mybatis.UserIntegralDao;
import com.alidao.users.entity.UserIntegral;
import com.alidao.users.service.UserIntegralService;

@Service
public class UserIntegralServiceImpl implements UserIntegralService {

	@Autowired
	private UserIntegralDao userIntegralDao;
	
	public int save(UserIntegral object) {
		return userIntegralDao.insert(object);
	}
	
	public int mdfy(UserIntegral object) {
		return userIntegralDao.update(object);
	}
	
	public int lose(Long id) {
		return userIntegralDao.deleteByPrimaryKey(id);
	}

	public int lose(UserIntegral object) {
		return userIntegralDao.delete(object);
	}
	
	public UserIntegral find(Long id) {
		return userIntegralDao.selectByPrimaryKey(id);
	}
	
	public UserIntegral find(UserIntegral object) {
		return userIntegralDao.select(object);
	}

	public Page<UserIntegral> page(PageParam pageParam, UserIntegral object) {
		return userIntegralDao.queryForPage(pageParam, object);
	}

	public List<UserIntegral> list(UserIntegral object) {
		return userIntegralDao.queryForList(object);
	}

	public int isum(String userId, Integer type) {
		UserIntegral object = new UserIntegral();
		object.setUserId(userId);
		object.setType(type);
		return userIntegralDao.sumOfIntegral(object);
	}

	public int read(String userId) {
		UserIntegral object = new UserIntegral();
		object.setUserId(userId);
		object.setStatus(UserIntegral.STATUS_READ_ED);
		return userIntegralDao.setUserStatus(object);
	}

	public boolean lnum(String userId, String relate, Integer limit, Integer type) {
		if (limit == null || limit < 0) { return true; }
		UserIntegral object = new UserIntegral();
		object.setType(type);
		object.setUserId(userId);
		object.setRelate(relate);
		Long count = userIntegralDao.queryForCount(object);
		return ((count == null) || (count < limit));
	}
	
	public Integer getMyVaildIntegral(String uid, String types, Long integralTypeId) {
		UserIntegral object = new UserIntegral();
		object.setUserId(uid);
		if (StringUtil.isNotBlank(types)) {
			object.addCondition("type", Condition.CDT_IN, types, Condition.SEP_AND);
		}
		if (integralTypeId != null && integralTypeId != 0) {
			object.setIntegralTypeId(integralTypeId);
		}
		object.addCondition("vaild_end_time >= '" + DateUtil.formatDate(new Date(), "yyyy-MM-dd") + "'", Condition.SEP_AND);
		object.addCondition("sell_integral > 0", Condition.SEP_AND);
		Integer integral = 0;
		List<UserIntegral> list = userIntegralDao.queryForList(object);
		for (UserIntegral userIntegral : list) {
			integral += userIntegral.getSellIntegral();
		}
		return integral;
	}
	
	public Integer getMyVaildIntegral(String uid, String types) {
		return getMyVaildIntegral(uid, types, null);
	}
	
	public Integer getMyOverdueIntegral(String uid, String types) {
		UserIntegral object = new UserIntegral();
		object.setUserId(uid);
		if (StringUtil.isNotBlank(types)) {
			object.addCondition("type", Condition.CDT_IN, types, Condition.SEP_AND);
		}
		object.addCondition("vaild_end_time < '" + DateUtil.formatDate(new Date(), "yyyy-MM-dd") + "'", Condition.SEP_AND);
		object.addCondition("sell_integral > 0", Condition.SEP_AND);
		Integer integral = 0;
		List<UserIntegral> list = userIntegralDao.queryForList(object);
		for (UserIntegral userIntegral : list) {
			integral += userIntegral.getSellIntegral();
		}
		return integral;
	}

	public Integer getMySoonOverdueIntegral(String uid, String types) {
		UserIntegral object = new UserIntegral();
		object.setUserId(uid);
		if (StringUtil.isNotBlank(types)) {
			object.addCondition("type", Condition.CDT_IN, types, Condition.SEP_AND);
		}
		object.addCondition("vaild_end_time >= '" + DateUtil.formatDate(new Date(), "yyyy-MM-dd") + "'", Condition.SEP_AND);
		object.addCondition("sell_integral > 0", Condition.SEP_AND);
		object.addCondition("vaild_end_time < date_add('" + DateUtil.formatDate(new Date(), "yyyy-MM-dd") + "', interval 1 month)", Condition.SEP_AND);
		Integer integral = 0;
		List<UserIntegral> list = userIntegralDao.queryForList(object);
		for (UserIntegral userIntegral : list) {
			integral += userIntegral.getSellIntegral();
		}
		return integral;
	}
}
