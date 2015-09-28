package com.alidao.basic.service.impl;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alidao.basic.dao4mybatis.ProverbDao;
import com.alidao.basic.dao4mybatis.SigninRecordDao;
import com.alidao.basic.entity.Proverb;
import com.alidao.basic.entity.SigninRecord;
import com.alidao.basic.service.SigninRecordService;
import com.alidao.common.Constants;
import com.alidao.jse.util.DateUtil;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.users.dao4mybatis.UserBindDao;
import com.alidao.users.dao4mybatis.UserDao;
import com.alidao.users.dao4mybatis.UserIntegralDao;
import com.alidao.users.entity.User;
import com.alidao.users.entity.UserBind;
import com.alidao.users.entity.UserIntegral;
import com.alidao.users.service.UserIntegralService;
import com.alidao.wxapi.bean.TokenForWxapis;
import com.alidao.wxapi.util.WxapiUtil;

@Service
public class SigninRecordServiceImpl implements SigninRecordService {
	private Log log = LogFactory.getLog(this.getClass());
	@Autowired
	private SigninRecordDao signinRecordDao;

	@Autowired
	private UserDao userDao;

	@Autowired
	private UserIntegralDao userIntegralDao;

	@Autowired
	private UserIntegralService userIntegralService;

	@Autowired
	private UserBindDao userBindDao;

	@Autowired
	private ProverbDao proverbDao;

	public int save(SigninRecord object) {
		return signinRecordDao.insert(object);
	}

	public int save(List<SigninRecord> objects) {
		int result = 0;
		for (SigninRecord object : objects) {
			result &= signinRecordDao.insert(object);
		}
		return result;
	}

	public int lose(String id) {
		return signinRecordDao.deleteByPrimaryKey(id);
	}

	public int lose(SigninRecord object) {
		return signinRecordDao.delete(object);
	}

	public int mdfy(SigninRecord object) {
		return signinRecordDao.update(object);
	}

	public SigninRecord find(String id) {
		return signinRecordDao.selectByPrimaryKey(id);
	}

	public SigninRecord find(SigninRecord object) {
		return signinRecordDao.select(object);
	}

	public Page<SigninRecord> page(PageParam pageParam, SigninRecord object) {
		return signinRecordDao.queryForPage(pageParam, object);
	}

	public List<SigninRecord> list(SigninRecord object) {
		return signinRecordDao.queryForList(object);
	}

	public Map<String, Object> signin(String userId) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (datePass()) {// 周二 20:30---00:00
			SigninRecord object = signinRecordDao.thisWeekSigninRecord(userId);
			if (object == null) {
				object = new SigninRecord();
				Random random = new Random();
				int signinIntegral = random.nextInt(7) + 1;// 随机生成金币 1-7
				User user = new User();
				user.setId(userId);
				user.setIntegral(signinIntegral);
				userDao.modifyCounts(user);// 用户积分增加

				user = userDao.selectByPrimaryKey(userId);
				object.setUserId(userId);
				object.setUserName(user.getRealname());
				object.setIntegral(signinIntegral);

				UserIntegral integral = new UserIntegral();
				integral.setUserId(userId);
				integral.setIntegral(signinIntegral);
				integral.setType(UserIntegral.SIGN_IN_GET_QUESTION);
				integral.setNote("签到获得" + signinIntegral + "金币");
				userIntegralDao.insert(integral);

				try {
					// 根据UID获取用户
					user = userDao.selectByPrimaryKey(userId);
					// 积分变动模版推送
					String json_data = "";
					// 组装json_data数据
					json_data = "{\"first\": {\"value\":\"亲爱的"
							+ user.getRealname()
							+ "，请查看您的金币变动。\",\"color\":\"#173177\"},"
							+ "\"time\":{\"value\":\""
							+ DateUtil.getDateSampleString(new Date(), "yyyy年MM月dd日 HH:mm")
							+ "\",\"color\":\"#173177\"},"
							+ "\"add_Jifen\": {\"value\":\""
							+ signinIntegral
							+ "个金币\",\"color\":\"#173177\"},"
							+ "\"consume_Jifen\": {\"value\":\"0个金币\",\"color\":\"#173177\"},"
							+ "\"jifen\": {\"value\":\""
							+ userIntegralService.getMyVaildIntegral(user.getId(), null)
							+ "个金币\",\"color\":\"#173177\"},"
							+ "\"remark\": {\"value\":\"如有疑问，请拨打高和畅客服热线400-6196-805。\",\"color\":\"#173177\"}}";
					String goldTemplateId = Constants.get("gold.templateId");
					TokenForWxapis tokenForWxapis = WxapiUtil.getWxapisToken(
							Constants.get("wxapi.appid"),
							Constants.get("wxapi.appsecret"));
					UserBind userBind = new UserBind();
					userBind.setUserId(user.getId());
					userBind = userBindDao.select(userBind);
					if (userBind != null) {
						// 推送消息模版
						WxapiUtil.sendTM2WxUser(
								tokenForWxapis.getAccess_token(),
								userBind.getAccount(), goldTemplateId, "",
								json_data);
					}
				} catch (Exception e) {
					log.error(e.getMessage(), e);
				}
				map.put("result", signinRecordDao.insert(object));
				map.put("integral", signinIntegral);
				return map;
			} else {
				map.put("result", -1);
				return map;// 本周已签到
			}

		} else {
			map.put("result", -2);
			return map;// 不是签到时间范围
		}
	}

	public int thisWeekSigninRecord(String userId) {
		SigninRecord object = null;
		if (StringUtil.isNotBlank(userId)) {
			object = signinRecordDao.thisWeekSigninRecord(userId);
		}
		if (object == null && datePass()) {
			return 1;
		} else {
			return 0;
		}
	}

	public Proverb findProverb() {
		Random random = new Random();
		List<Proverb> list = proverbDao.queryForList(new Proverb());
		Proverb object = new Proverb();
		if (list != null && list.size() > 0) {
			int num = random.nextInt(list.size());
			object = list.get(num);
		}
		return object;
	}

	public boolean datePass() {
		Calendar calendar = Calendar.getInstance();
		Date date = new Date();
		SimpleDateFormat simpleYMD = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat simpleYMDHM = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		calendar.setTime(date);
		int today = calendar.get(Calendar.DAY_OF_WEEK) - 1;
		calendar.add(Calendar.DATE, 1);
		Date dateTomorrow = calendar.getTime();
		boolean flagBefore = false;
		boolean flagAfter = false;
		try {
			String start = Constants.get("signin.start");
			String end = Constants.get("signin.end");
			if ("00:00".equals(end)) {
				flagBefore = date.before(simpleYMDHM.parse(
						simpleYMD.format(dateTomorrow) + " " + end));
			} else {
				flagBefore = date.before(simpleYMDHM.parse(
						simpleYMD.format(date) + " " + end));
			}
			flagAfter = date.after(simpleYMDHM.parse(
					simpleYMD.format(date) + " " + start));
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
		return flagBefore && flagAfter && (today == 
				Integer.parseInt(Constants.get("signin.weekday")));
	}
}