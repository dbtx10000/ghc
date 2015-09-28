package com.alidao.users.service.impl;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alidao.basic.entity.CashCoupon;
import com.alidao.basic.entity.Const;
import com.alidao.basic.service.CashCouponService;
import com.alidao.basic.service.ConstService;
import com.alidao.common.Constants;
import com.alidao.jse.util.DateUtil;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.users.dao4mybatis.UserBindDao;
import com.alidao.users.dao4mybatis.UserDao;
import com.alidao.users.dao4mybatis.UserIntegralDao;
import com.alidao.users.entity.Saler;
import com.alidao.users.entity.User;
import com.alidao.users.entity.UserBind;
import com.alidao.users.entity.UserIntegral;
import com.alidao.users.service.SalerService;
import com.alidao.users.service.UserIntegralService;
import com.alidao.users.service.UserService;
import com.alidao.wxapi.bean.TokenForWxapis;
import com.alidao.wxapi.util.OpenidTracker;
import com.alidao.wxapi.util.WxapiUtil;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private UserBindDao userBindDao;

	@Autowired
	private UserIntegralDao userIntegralDao;
	
	@Autowired
	private ConstService constService;
	
	@Autowired
	private CashCouponService cashCouponService;
	
	@Autowired
	private UserIntegralService userIntegralService;
	
	@Autowired
	private SalerService salerService;
	
	public int save(User object) throws Exception {
		object.beforeInsert();
		int result =  userDao.insert(object);
		if (result == 1) {
			String salerid = object.getSalerId();
			if (StringUtil.isNotBlank(salerid)) {
				// 处理销售逻辑
				// 销售用户数
				Saler saler = new Saler();
				saler.setId(object.getSalerId());
				saler.setUserCount(1);
				salerService.modifyCounts(saler);
			}
			//积分逻辑处理
			String pid = object.getPid();
			String cid = object.getId();
			User parent = null;
			if (StringUtil.isNotBlank(pid)) {
				parent = find(pid);
				if (parent != null) {
					parent = new User();
					parent.setId(pid);
					parent.setFriend(1);
					plus(parent);
					parent = find(pid);
				}
			}
			Const _const = constService.find(new Const());
			if (_const != null) {
				Integer integral = _const.getRegisIntegral();
				if (integral != null && integral > 0) {
					cGetIntegral(parent, cid, integral);
				}
			}
			//代金券逻辑处理
			CashCoupon cashCoupon = new CashCoupon();
			cashCoupon.setUserId(object.getId());
			Date now = new Date();
			cashCoupon.setVaildStartTime(now);
			cashCoupon.setVaildEndTime(DateUtil.monthAddMonth(now, 3));
			cashCoupon.setStatus(CashCoupon.STATUS_GET_YES);
			cashCoupon.setReaded(CashCoupon.READ_NO);
			cashCoupon.setMoney(200);//第一张代金券金额200元
			cashCoupon.setUseCondition(5);//5W才可使用
			cashCouponService.save(cashCoupon);
			cashCoupon.setId(null);
			cashCoupon.setMoney(250);//第二张代金券金额250元
			cashCoupon.setUseCondition(10);//10W才可使用
			cashCouponService.save(cashCoupon);
			cashCoupon.setId(null);
			cashCoupon.setMoney(550);//第三张代金券金额550元
			cashCoupon.setUseCondition(20);//20W才可使用
			cashCouponService.save(cashCoupon);
		}
		return result;
	}
	
	public int mdfy(User object) {
		return userDao.update(object);
	}
	
	public int lose(String id) {
		return userDao.deleteByPrimaryKey(id);
	}

	public int lose(User object) {
		return userDao.delete(object);
	}
	
	public User find(String id) {
		return userDao.selectByPrimaryKey(id);
	}
	
	public User find(User object) {
		return userDao.select(object);
	}

	public Page<User> page(PageParam pageParam, User object) {
		return userDao.queryForPage(pageParam, object);
	}

	public List<User> list(User object) {
		return userDao.queryForList(object);
	}
	
	public int send(String userId) {
		Const _const = constService.find(new Const());
		if (_const != null) {
			User user = find(userId);
			if (user != null && StringUtil.isNotBlank(user.getPid())) {
				Integer integral = _const.getInviteIntegral();
				User parent = find(user.getPid());
				if (parent != null && integral != null && integral > 0) {
					Integer limit = _const.getInviteIntegralLimit();
					if (!outOfLimit(user.getPid(), limit)) {
						UserIntegral pUserIntegral = new UserIntegral();
						pUserIntegral.setUserId(parent.getId());
						pUserIntegral.setType(UserIntegral.TYPE_GET_INVITES_REG);
						pUserIntegral.setRelate(userId);
						pUserIntegral = userIntegralService.find(pUserIntegral);
						if (pUserIntegral == null) {
							parent.setIntegral(integral);
							plus(parent);
							// 插入积分记录
							pUserIntegral = new UserIntegral();
							pUserIntegral.setUserId(parent.getId());
							pUserIntegral.setType(UserIntegral.TYPE_GET_INVITES_REG);
							pUserIntegral.setRelate(userId);
							pUserIntegral.setStatus(UserIntegral.STATUS_UN_READ);
							pUserIntegral.setIntegral(integral);
							String pNote = "邀请用户(" + user.getRealname() + ")注册得" + integral + "金币"; 
							pUserIntegral.setNote(pNote);
							userIntegralDao.insert(pUserIntegral);
							try {
								//积分变动模版推送
								String json_data = "";
								//组装json_data数据
								json_data = "{\"first\": {\"value\":\"亲爱的" + parent.getRealname() + "，请查看您的金币变动。\",\"color\":\"#173177\"}," +
											"\"time\":{\"value\":\"" + DateUtil.getDateSampleString(new Date(), "yyyy年MM月dd日 HH:mm") + "\",\"color\":\"#173177\"}," +
											"\"add_Jifen\": {\"value\":\"" + integral + "个金币\",\"color\":\"#173177\"}," +
											"\"consume_Jifen\": {\"value\":\"0个金币\",\"color\":\"#173177\"}," +
											"\"jifen\": {\"value\":\"" + userIntegralService.getMyVaildIntegral(parent.getId(), null) + "个金币\",\"color\":\"#173177\"}," +
											"\"remark\": {\"value\":\"如有疑问，请拨打高和畅客服热线400-6196-805。\",\"color\":\"#173177\"}}";
								String goldTemplateId = Constants.get("gold.templateId");
								TokenForWxapis tokenForWxapis = WxapiUtil.getWxapisToken(Constants.get("wxapi.appid"), Constants.get("wxapi.appsecret"));
								UserBind userBind = new UserBind();
								userBind.setUserId(parent.getId());
								userBind = userBindDao.select(userBind);
								if (userBind != null) {
									//推送消息模版
									WxapiUtil.sendTM2WxUser(tokenForWxapis.getAccess_token(), userBind.getAccount(), goldTemplateId, "", json_data);
								}
							} catch (Exception e) {
								;
							}
							return 1;
						}
					}
				}
			}
		}
		return 0;
	}
	
	public int plus(User object) {
		return userDao.modifyCounts(object);
	}
	
	public int bind(String id, String openid, Integer type, Boolean login) {
		UserBind del_cdt_1 = new UserBind();
		del_cdt_1.setUserId(id);
		del_cdt_1.setAccountType(type);
		userBindDao.delete(del_cdt_1);
		UserBind del_cdt_2 = new UserBind();
		del_cdt_2.setAccount(openid);
		del_cdt_2.setAccountType(type);
		userBindDao.delete(del_cdt_2);
		UserBind object = new UserBind();
		object.setUserId(id);
		object.setAccountType(type);
		object.setAccount(openid);
		if (login) {
			object.setSessionKey(UUID.randomUUID().toString());
		}
		return userBindDao.insert(object);
	}
	
	public int bind(String id, String openid, Integer type) {
		return bind(id, openid, type, true);
	}
	
	public int drop(String id, String openid, Integer type) {
		UserBind object = new UserBind();
		object.setUserId(id);
		object.setAccountType(type);
		object.setAccount(openid);
		return userBindDao.delete(object);
	}

	public User find(String openid, Integer type) {
		UserBind object = new UserBind();
		object.setAccount(openid);
		object.setAccountType(type);
		object = userBindDao.select(object);
		if (object != null) {
			User user = find(object.getUserId());
			if (user != null) {
				user.setSessionKey(object.getSessionKey());
			}
			return user;
		}
		return null;
	}

	public int give(User object) {
		User user = userDao.selectByPrimaryKey(object.getId());
		if (user != null) {
			try {
				//积分变动模版推送
				String json_data = "";
				//组装json_data数据
				json_data = "{\"first\": {\"value\":\"亲爱的" + user.getRealname() + "，请查看您的金币变动。\",\"color\":\"#173177\"}," +
							"\"time\":{\"value\":\"" + DateUtil.getDateSampleString(new Date(), "yyyy年MM月dd日 HH:mm") + "\",\"color\":\"#173177\"}," +
							"\"add_Jifen\": {\"value\":\"" + object.getIntegral() + "个金币\",\"color\":\"#173177\"}," +
							"\"consume_Jifen\": {\"value\":\"0个金币\",\"color\":\"#173177\"}," +
							"\"jifen\": {\"value\":\"" + (userIntegralService.getMyVaildIntegral(user.getId(), null) + object.getIntegral()) + "个金币\",\"color\":\"#173177\"}," +
							"\"remark\": {\"value\":\"如有疑问，请拨打高和畅客服热线400-6196-805。\",\"color\":\"#173177\"}}";
				String goldTemplateId = Constants.get("gold.templateId");
				TokenForWxapis tokenForWxapis = WxapiUtil.getWxapisToken(Constants.get("wxapi.appid"), Constants.get("wxapi.appsecret"));
				UserBind userBind = new UserBind();
				userBind.setUserId(user.getId());
				userBind = userBindDao.select(userBind);
				if (userBind != null) {
					//推送消息模版
					WxapiUtil.sendTM2WxUser(tokenForWxapis.getAccess_token(), userBind.getAccount(), goldTemplateId, "", json_data);
				}
			} catch (Exception e) {
				;
			}
		}
		userDao.modifyCounts(object);
		UserIntegral integral = new UserIntegral();
		integral.setUserId(object.getId());
		integral.setIntegral(object.getIntegral());
		integral.setType(UserIntegral.TYPE_GET_BACKGROUND);
		integral.setNote("系统赠送");
		return userIntegralDao.insert(integral);
	}

	public int over(String id, String openid, Integer type) {
		UserBind object = new UserBind();
		object.setUserId(id);
		object.setAccountType(type);
		object.setAccount(openid);
		object = userBindDao.select(object);
		if (object != null) {
			object.setSessionKey("");
			return userBindDao.update(object);
		} else {
			return 0;
		}
	}
	
	private boolean outOfLimit(String pid, Integer limit) {
		if (limit == null || limit < 0) { return false; }
		UserIntegral object = new UserIntegral();
		object.setUserId(pid);
		object.setType(UserIntegral.TYPE_GET_INVITES_REG);
		Long count = userIntegralDao.queryForCount(object);
		return ((count != null) && (count >= limit));
	}

	private void cGetIntegral(User parent, String cid, Integer integral) throws Exception {
		User cUser = new User();
		cUser.setId(cid);
		cUser.setIntegral(integral);
		plus(cUser);
		
		UserIntegral cUserIntegral = new UserIntegral();
		cUserIntegral.setUserId(cid);
		cUserIntegral.setType(UserIntegral.TYPE_GET_USEROWN_REG);
		cUserIntegral.setIntegral(integral);
		cUserIntegral.setStatus(UserIntegral.STATUS_UN_READ);
		String cNote = "注册成功得" + integral + "金币";
		if (parent != null) {
			String pName = parent.getRealname();
			cNote = "你的朋友'" + pName + "'赠送你" + integral + "金币";
		}
		cUserIntegral.setNote(cNote);
		userIntegralDao.insert(cUserIntegral);
		
		User user = userDao.selectByPrimaryKey(cid);
		if (user != null) {
			//积分变动模版推送
			String json_data = "";
			//组装json_data数据
			json_data = "{\"first\": {\"value\":\"亲爱的" + user.getRealname() + "，请查看您的金币变动。\",\"color\":\"#173177\"}," +
						"\"time\":{\"value\":\"" + DateUtil.getDateSampleString(new Date(), "yyyy年MM月dd日 hh时mm分") + "\",\"color\":\"#173177\"}," +
						"\"add_Jifen\": {\"value\":\"" + integral + "个金币\",\"color\":\"#173177\"}," +
						"\"consume_Jifen\": {\"value\":\"0个金币\",\"color\":\"#173177\"}," +
						"\"jifen\": {\"value\":\"" + integral + "个金币\",\"color\":\"#173177\"}," +
						"\"remark\": {\"value\":\"如有疑问，请拨打高和畅客服热线400-6196-805。\",\"color\":\"#173177\"}}";
			String goldTemplateId = Constants.get("gold.templateId");
			TokenForWxapis tokenForWxapis = WxapiUtil.getWxapisToken(Constants.get("wxapi.appid"), Constants.get("wxapi.appsecret"));
			//推送消息模版
			//这边不去查询UserBind表，因为这里保存用户绑定记录代码在后面，所以不能和其他推送代码一样去查询用户绑定记录，直接这里获取当前的openid去推送
			WxapiUtil.sendTM2WxUser(tokenForWxapis.getAccess_token(), OpenidTracker.get(), goldTemplateId, "", json_data);
		}
	}

	public UserBind findUserBind(String id, int type) {
		UserBind object = new UserBind();
		object.setUserId(id);
		object.setAccountType(type);
		return userBindDao.select(object);
	}

}
