package com.alidao.basic.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alidao.basic.dao4mybatis.CashCouponDao;
import com.alidao.basic.dao4mybatis.FcodeDao;
import com.alidao.basic.dao4mybatis.GameBuyRecordDao;
import com.alidao.basic.dao4mybatis.GameDao;
import com.alidao.basic.dao4mybatis.GameRecordDao;
import com.alidao.basic.dao4mybatis.HolidayDao;
import com.alidao.basic.dao4mybatis.OrderDao;
import com.alidao.basic.dao4mybatis.ProductDao;
import com.alidao.basic.entity.CashCoupon;
import com.alidao.basic.entity.Const;
import com.alidao.basic.entity.Fcode;
import com.alidao.basic.entity.Game;
import com.alidao.basic.entity.GameBuyRecord;
import com.alidao.basic.entity.GameRecord;
import com.alidao.basic.entity.Holiday;
import com.alidao.basic.entity.Order;
import com.alidao.basic.entity.Product;
import com.alidao.basic.service.ConstService;
import com.alidao.basic.service.OrderService;
import com.alidao.common.Constants;
import com.alidao.jse.util.Crypto;
import com.alidao.jse.util.DateUtil;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.model.Condition;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.users.authorizing.UseridTracker;
import com.alidao.users.dao4mybatis.UserBindDao;
import com.alidao.users.dao4mybatis.UserDao;
import com.alidao.users.entity.BuyProductRecord;
import com.alidao.users.entity.User;
import com.alidao.users.entity.UserBind;
import com.alidao.users.entity.UserIntegral;
import com.alidao.users.entity.UserInvest;
import com.alidao.users.service.BuyProductRecordService;
import com.alidao.users.service.UserIntegralService;
import com.alidao.users.service.UserInvestService;
import com.alidao.users.service.UserService;
import com.alidao.wxapi.bean.TokenForWxapis;
import com.alidao.wxapi.bean.UserForWxUnion;
import com.alidao.wxapi.util.WxapiUtil;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderDao orderDao;
	
	@Autowired
	private ProductDao productDao;
	
	@Autowired
	private FcodeDao fcodeDao;
	
	@Autowired
	private UserInvestService userInvestService;
	
	@Autowired
	private UserIntegralService userIntegralService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ConstService constService;
	
	@Autowired
	private CashCouponDao cashCouponDao;
	
	@Autowired
	private UserBindDao userBindDao;
	
	@Autowired
	private BuyProductRecordService buyProductRecordService;
	
	@Autowired
	private GameBuyRecordDao gameBuyRecordDao;
	
	@Autowired
	private HolidayDao holidayDao;
	
	@Autowired
	private GameRecordDao gameRecordDao;
	
	@Autowired
	private GameDao gameDao;
	
	@Autowired
	private UserDao userDao;
	
	public Date convert(Date endTime) {//2016-01-12
		for (int i = 0; i < 3; i++) {
			endTime = DateUtil.addOneDay(endTime);
			if(isRestDay(endTime)) {
				i--;//如果是休息日则跳过这一天，时间往后加
			}
		}
		return endTime;
	}
	
	public boolean isRestDay(Date date) {
		boolean flag = false;
		//先判断该日期是否是周六、周天
		int week = getWeekOfDate(date);
		if(week==0||week==6) {//周六、周天
			flag = true;
			return flag;
		}
		Holiday holiday = new Holiday();
		holiday.setYear(Integer.parseInt(DateUtil.formatDate(date, "yyyy-MM-dd").substring(0,4)));
		List<Holiday> holidays = holidayDao.queryForList(holiday);
		if(holidays != null && holidays.size() > 0) {
			for (Holiday holiday2 : holidays) {
				if(date.getTime() >= holiday2.getStartTime().getTime() && 
						date.getTime() <= holiday2.getEndTime().getTime()) {
					flag = true;
					break;
				}
			}
		}
		return flag;
	}
	
   public static int getWeekOfDate(Date dt) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(dt);
        int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
        if (w < 0) {
        	w = 0;
        }
        return w;
    }
	
	public int save(Order object) {
		return orderDao.insert(object);
	}
	
	public int mdfy(Order object) throws Exception {
		if (object.getStatus() != null) {
			if (object.getStatus() == 1) {	// 支付成功
				// 用户获取积分
				Order origin = orderDao.selectByPrimaryKey(object.getId());
				String productId = origin.getProductId();
				String userId = origin.getUserId();
				Const cons = constService.find(new Const());
				Product product = productDao.selectByPrimaryKey(productId);
				
				Boolean can_get_integral = product.getType() == 1;
				
				// 指定某个产品送金
				UserIntegral userIntegral = new UserIntegral();
				userIntegral.setUserId(userId);
				userIntegral.setType(UserIntegral.TYPE_GET_BUY_PRODUCT);
				userIntegral.setRelate(productId);
				userIntegral = userIntegralService.find(userIntegral);
				if (can_get_integral && userIntegral == null) {
					if (product != null) {
						Integer integral = product.getIntegral();
						if (integral != null && integral > 0) {
							User user = new User();
							user.setId(userId);
							user.setIntegral(integral);
							String note = "购买产品(" + product.getName() + 
									"),小畅赠送您" + integral + "金币";
							getIntegral(user, integral, product.getId(), 
								UserIntegral.TYPE_GET_BUY_PRODUCT, note);
						}
					}
				}
				// 本人注册并认购缴款送金币
				Integer limit = cons.getBuyIntegralLimit();
				Integer type = UserIntegral.TYPE_GET_BUY_INTEGRAL;
				if (can_get_integral && userIntegralService.lnum(userId, null, limit, type)) {
					userIntegral = new UserIntegral();
					userIntegral.setUserId(userId);
					userIntegral.setType(UserIntegral.TYPE_GET_BUY_INTEGRAL);
					userIntegral.setRelate(productId);
					userIntegral = userIntegralService.find(userIntegral);
					Integer integral = cons.getBuyIntegral();
					if (userIntegral == null && integral != null && integral > 0) {
						User user = new User();
						user.setId(userId);
						user.setIntegral(integral);
						String note = "缴款成功,小畅赠送您" + integral + "金币";
						getIntegral(user, integral, product.getId(), 
							UserIntegral.TYPE_GET_BUY_INTEGRAL, note);
					}
				}
				//邀请他们注册且该人认购成功缴款
				User user = userService.find(userId);
				if (can_get_integral && StringUtil.isNotBlank(user.getPid())) {
					limit = cons.getInviteBuyIntegralLimit();
					type = UserIntegral.TYPE_GET_INVITE_BUY_INTEGRAL;
					if (userIntegralService.lnum(user.getPid(), userId, limit, type)) {
						Integer integral = cons.getInviteBuyIntegral();
						if (integral != null && integral > 0) {
							User pUser = new User();
							pUser.setId(user.getPid());
							pUser.setIntegral(integral);
							String note = "您邀请的好友(" + user.getRealname() + 
									")购买产品并缴款成功,小畅赠送您" + integral + "金币";
							getIntegral(pUser, integral, userId,
								UserIntegral.TYPE_GET_INVITE_BUY_INTEGRAL, note);
						}
					}
				}
				UserInvest userInvest = new UserInvest();
				userInvest.setOrderId(object.getId());
				userInvest = userInvestService.find(userInvest);
				if(userInvest != null) {
					// 判断产品收益类型
					if (product.getIncomeType() == Product.INCOME_TYPE_FLOAT) {
						Integer incomeDays = product.getIncomeDays();
						Date now = new Date();
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						try {
							now = sdf.parse(sdf.format(now));
						} catch (ParseException e) {
							throw new RuntimeException(e);
						}
						Calendar calendar = Calendar.getInstance();
						calendar.setTime(now);
						calendar.add(Calendar.DAY_OF_YEAR, 1);
						userInvest.setIncomeStartTime(calendar.getTime());
						calendar.setTime(now);
						calendar.add(Calendar.DAY_OF_YEAR, incomeDays);
						userInvest.setIncomeEndTime(calendar.getTime());
					}
					userInvest.setRepayTime(convert(userInvest.getIncomeEndTime()));
					userInvestService.mdfy(userInvest);
				}
				// 判断产品是否可以抽奖
				if (can_get_integral && product.getJackpot() == 1) {
					Integer gbs = product.getGainByScale();
					Integer scale = 1;
					if (gbs != null && gbs == 1) {
						if (product.getSmallProduct() == 0) {
							scale = origin.getInvestMoney() / 10000;
						}
					}
					// 添加抽奖机会记录
					BuyProductRecord record = new BuyProductRecord();
					record.setUserId(userId);
					record.setProductId(productId);
					record = buyProductRecordService.find(record);
					if (record == null) {	// 为空说明是首次，可以获得机会
						record = new BuyProductRecord();
						record.setUserId(userId);
						record.setProductId(productId);
						record.setOrderId(object.getId());
						record.setScale(scale);
						record.setCostMoney(origin.getInvestMoney());
						String sncode = UUID.randomUUID().toString();
						record.setSncode(sncode);
						record.setStatus(0);
						record.setReaded(0);
						buyProductRecordService.save(record);
					} else {
						record.setScale(record.getScale() + scale);
						record.setCostMoney(record.getCostMoney() + 
								origin.getInvestMoney());
						buyProductRecordService.mdfy(record);
					}
				}
				if(product.getGame()==1){//可以玩游戏提高收益
					/**添加游戏--产品购买记录**/
					GameBuyRecord gameBuyRecord=new GameBuyRecord();
					gameBuyRecord.setUserId(userId);
					gameBuyRecord.setProductId(productId);
					gameBuyRecord=gameBuyRecordDao.select(gameBuyRecord);
					if(gameBuyRecord==null){
						gameBuyRecord=new GameBuyRecord();
						gameBuyRecord.setUserId(userId);
						gameBuyRecord.setProductId(productId);
						gameBuyRecord.setOrderId(object.getId());
						gameBuyRecord.setStatus(GameBuyRecord.STATUS_TYPE_NOT_USED);
						gameBuyRecordDao.insert(gameBuyRecord);
					}
					Game game=new Game();
					game.addCondition("product_id", 
							Condition.CDT_LIKE, ("'%" + productId + "%'"), 
							Condition.SEP_AND);
					game = gameDao.select(game);
					UserBind userBind = new UserBind();
					userBind.setUserId(userId);
					userBind=userBindDao.select(userBind);
					TokenForWxapis token= WxapiUtil.
							getWxapisToken(Constants.get("wxapi.appid"), Constants.get("wxapi.appsecret"));
					UserForWxUnion union=WxapiUtil.
							getWxUnionUser(token.getAccess_token(), userBind.getAccount());
					if(game!=null){
						GameRecord gameRecord=new GameRecord();
						gameRecord.setGameId(game.getId());
						gameRecord.setUserId(userId);
						gameRecord=gameRecordDao.select(gameRecord);
						if(gameRecord==null){
							gameRecord=new GameRecord();
							gameRecord.setGameId(game.getId());
							gameRecord.setShareSn(Crypto.MD5(UUID.randomUUID().toString()));
							gameRecord.setUserId(userId);
							gameRecord.setScore(0);
							gameRecord.setFriendScore(0);
							gameRecord.setUserAccount(user.getMobile());
							gameRecord.setUserName(user.getRealname());
							gameRecord.setFriendCount(0);
							gameRecord.setUserImage(union.getHeadimgurl());
							gameRecordDao.insert(gameRecord);//新增购买产品者游戏记录
						}
					}
				}
				if (origin.getProductType() == 1) {
					// 交易确认模版推送
					String json_data = "";
					// 组装json_data数据
					json_data = "{\"first\": {\"value\":\"您好，您的认购申请已确认。\",\"color\":\"#173177\"}," +
								"\"confirmDate\":{\"value\":\"" + DateUtil.getDateSampleString(new Date(), "yyyy-MM-dd") + "\",\"color\":\"#173177\"}," +
								"\"confirmMsg\": {\"value\":\"支付成功\",\"color\":\"#173177\"}," +
								"\"confirmMoney\": {\"value\":\"" + (origin.getInvestMoney() - origin.getUseIntegral() - origin.getCashMoney()) + "元\",\"color\":\"#173177\"}," +
								"\"confirmAmount\": {\"value\":\"" + origin.getInvestMoney() + "元\",\"color\":\"#173177\"}," +
								"\"remark\": {\"value\":\"如有疑问，请拨打咨询热线400-6196-805。\",\"color\":\"#173177\"}}";
					String paysuccTemplateId = Constants.get("paysucc.templateId");
					TokenForWxapis tokenForWxapis = WxapiUtil.getWxapisToken(Constants.get("wxapi.appid"), Constants.get("wxapi.appsecret"));
					UserBind userBind = new UserBind();
					userBind.setUserId(origin.getUserId());
					userBind = userBindDao.select(userBind);
					if (userBind != null) {
						// 推送消息模版
						WxapiUtil.sendTM2WxUser(tokenForWxapis.getAccess_token(), userBind.getAccount(), paysuccTemplateId, "", json_data);
					}
				}
			} else if (object.getStatus() == 2) {	// 关闭
				UserInvest userInvest = new UserInvest();
				userInvest.setOrderId(object.getId());
				userInvest = userInvestService.find(userInvest);
				if (userInvest != null) {
					userInvestService.lose(userInvest.getId());
				}
			}
		}
		return orderDao.update(object);
	}
	
	public void getIntegral(User user, int integral, 
			String relate, int type, String note) throws Exception {
		UserIntegral userIntegral = new UserIntegral();
		userIntegral.setIntegral(integral);
		userIntegral.setRelate(relate);
		userIntegral.setUserId(user.getId());
		userIntegral.setType(type);
		userIntegral.setStatus(UserIntegral.STATUS_UN_READ);
		userIntegral.setNote(note);
		userIntegralService.save(userIntegral);
		userService.plus(user);
		
		user = userService.find(user.getId());
		if (user != null) {
			//积分变动模版推送
			String json_data = "";
			//组装json_data数据
			json_data = "{\"first\": {\"value\":\"亲爱的" + user.getRealname() + "，请查看您的金币变动。\",\"color\":\"#173177\"}," +
						"\"time\":{\"value\":\"" + DateUtil.getDateSampleString(new Date(), "yyyy年MM月dd日 HH:mm") + "\",\"color\":\"#173177\"}," +
						"\"add_Jifen\": {\"value\":\"" + integral + "个金币\",\"color\":\"#173177\"}," +
						"\"consume_Jifen\": {\"value\":\"0个金币\",\"color\":\"#173177\"}," +
						"\"jifen\": {\"value\":\"" + userIntegralService.getMyVaildIntegral(user.getId(), null) + "个金币\",\"color\":\"#173177\"}," +
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
		}
	}

	public int lose(String id) {
		return lose(id);
	}

	public int lose(Order object) {
		return orderDao.delete(object);
	}
	
	public Order find(String id) {
		Order order = orderDao.selectByPrimaryKey(id);
		if (order != null) {
			//关联产品信息
			order.setProduct(productDao.selectByPrimaryKey(order.getProductId()));
			//关联用户信息
			order.setUser(userService.find(order.getUserId()));
		}
		return order;
	}

	public Order find(Order object) {
		return orderDao.select(object);
	}

	public Page<Order> page(PageParam pageParam, Order object) {
		Page<Order> page = orderDao.queryForPage(pageParam, object);
		List<Order> list = page.getTableList();
		for (int i = 0; list != null && i < list.size(); i++) {	
			Order order = list.get(i);
			//关联产品信息
			order.setProduct(productDao.selectByPrimaryKey(order.getProductId()));
			//关联用户信息
			order.setUser(userService.find(order.getUserId()));
		}
		return page;
	}

	public List<Order> list(Order object) {
		return orderDao.queryForList(object);
	}
	
	public int wapOrder(Order object, String fcode, 
			Integer useIntegral, String cashId, Integer cashMoney) {
		//修改用户订单数和总投资数量
		/*User user = new User();
		user.setId(object.getUserId());
		user.setOrders(1);
		userService.plus(user);*/
		//保存用户投资记录信息
		User user=userDao.selectByPrimaryKey(object.getUserId());
		UserInvest userInvest = new UserInvest();
		userInvest.setUserId(object.getUserId());
		userInvest.setInvestTime(new Date());
		userInvest.setInvestMoney(object.getInvestMoney());
		userInvest.setStatus(UserInvest.STATUS_APPLY_ED);
		userInvest.setOrderId(object.getId());
		userInvest.setSource(UserInvest.SOURCE_ORDER);
		Product product = productDao.selectByPrimaryKey(object.getProductId());
		if (product != null) {
			//关联产品信息
			userInvest.setIncomeType(product.getIncomeType());
			userInvest.setIncomeDays(product.getIncomeDays());
			userInvest.setProductId(product.getId());
			userInvest.setProductName(product.getName());
			userInvest.setIncome(product.getIncome());
			userInvest.setIncomeFloat(product.getIncomeFloat());
			if (product.getIncomeType() == Product.INCOME_TYPE_FIXED) {
				userInvest.setIncomeStartTime(product.getIncomeStartTime());
				userInvest.setIncomeEndTime(product.getIncomeEndTime());
			}
		}
		userInvestService.save(userInvest);
		if (fcode != null) {
			//修改F码信息
			Fcode fcodeObj = new Fcode();
			fcodeObj.setFcode(fcode);
			fcodeObj = fcodeDao.select(fcodeObj);
			if (fcodeObj != null) {
				fcodeObj.setProductId(object.getProductId());
				fcodeObj.setUserId(object.getUserId());
				fcodeObj.setStatus(Fcode.STATUS_BE_USED);
				fcodeDao.update(fcodeObj);
			}
		}
		if (object.getType() == 1) {
			//使用金币
			if (useIntegral != null && useIntegral > 0) {
				//做金币抵扣逻辑处理
				object.setUseIntegral(useIntegral);
				//修改用户积分数
				UserIntegral userIntegralParam = new UserIntegral();
				userIntegralParam.setUserId(UseridTracker.get());
				userIntegralParam.addCondition("vaild_end_time >= '" + DateUtil.formatDate(new Date(), "yyyy-MM-dd") + "'", Condition.SEP_AND);
				userIntegralParam.addCondition("sell_integral > 0", Condition.SEP_AND);
				userIntegralParam.addOrderBy("vaild_end_time", false);//过期时间正序
				List<UserIntegral> list = userIntegralService.list(userIntegralParam);
				String sourceId = "";
				for (UserIntegral userIntegral : list) {
					sourceId += userIntegral.getId() + ",";
					//突然不想写modifyCount方法。用修改方法算了
					if (useIntegral.intValue() >= userIntegral.getSellIntegral().intValue()) {
						useIntegral -= userIntegral.getSellIntegral();
						userIntegral.setSellIntegral(0);
						userIntegralService.mdfy(userIntegral);
					} else {
						userIntegral.setSellIntegral(userIntegral.getSellIntegral() - useIntegral);
						userIntegralService.mdfy(userIntegral);
						break;
					}
				}
				if (StringUtil.isNotBlank(sourceId)) {
					sourceId = sourceId.substring(0, sourceId.length() - 1);
				}
				object.setSourceId(sourceId);
			}
		} else if (object.getType() == 2) {
			//使用代金券
			object.setCashId(cashId);
			object.setCashMoney(cashMoney);
			//修改代金券状态
			String[] cashids = cashId.split(",");
			for (String id : cashids) {
				CashCoupon cashCoupon = new CashCoupon();
				cashCoupon.setId(id);
				cashCoupon.setStatus(CashCoupon.STATUS_USE_YES);
				cashCoupon.setUseTime(new Date());
				cashCoupon.setProductId(object.getProductId());
				cashCoupon.setProductName(product.getName());
				cashCoupon.setUserName(user.getRealname());
				cashCouponDao.update(cashCoupon);
			}
		} else if (object.getType() == 3) {
			//两者都使用
			if (useIntegral != null && useIntegral > 0) {
				//做金币抵扣逻辑处理
				object.setUseIntegral(useIntegral);
				//修改用户积分数
				UserIntegral userIntegralParam = new UserIntegral();
				userIntegralParam.setUserId(UseridTracker.get());
				userIntegralParam.addCondition("vaild_end_time >= '" + DateUtil.formatDate(new Date(), "yyyy-MM-dd") + "'", Condition.SEP_AND);
				userIntegralParam.addCondition("sell_integral > 0", Condition.SEP_AND);
				userIntegralParam.addOrderBy("vaild_end_time", false);//过期时间正序
				List<UserIntegral> list = userIntegralService.list(userIntegralParam);
				String sourceId = "";
				for (UserIntegral userIntegral : list) {
					sourceId += userIntegral.getId() + ",";
					//突然不想写modifyCount方法。用修改方法算了
					if (useIntegral.intValue() >= userIntegral.getSellIntegral().intValue()) {
						useIntegral -= userIntegral.getSellIntegral();
						userIntegral.setSellIntegral(0);
						userIntegralService.mdfy(userIntegral);
					} else {
						userIntegral.setSellIntegral(userIntegral.getSellIntegral() - useIntegral);
						userIntegralService.mdfy(userIntegral);
						break;
					}
				}
				if (StringUtil.isNotBlank(sourceId)) {
					sourceId = sourceId.substring(0, sourceId.length() - 1);
				}
				object.setSourceId(sourceId);
			}
			object.setCashId(cashId);
			object.setCashMoney(cashMoney);
			//修改代金券状态
			String[] cashids = cashId.split(",");
			for (String id : cashids) {
				CashCoupon cashCoupon = new CashCoupon();
				cashCoupon.setId(id);
				cashCoupon.setStatus(CashCoupon.STATUS_USE_YES);
				cashCoupon.setUseTime(new Date());
				cashCoupon.setProductId(object.getProductId());
				cashCoupon.setProductName(product.getName());
				cashCoupon.setUserName(user.getRealname());
				cashCouponDao.update(cashCoupon);
			}
		}
		//保存订单
		return orderDao.insert(object);
	}
	
	
	public int specialOrder(Order object,Integer useIntegral) {
		//修改用户订单数和总投资数量
		/*User user = new User();
		user.setId(object.getUserId());
		user.setOrders(1);
		userService.plus(user);*/
		//保存用户投资记录信息
		UserInvest userInvest = new UserInvest();
		userInvest.setUserId(object.getUserId());
		userInvest.setInvestTime(new Date());
		userInvest.setInvestMoney(object.getInvestMoney());
		userInvest.setStatus(UserInvest.STATUS_APPLY_ED);
		userInvest.setOrderId(object.getId());
		userInvest.setSource(UserInvest.SOURCE_ORDER);
		Product product = productDao.selectByPrimaryKey(object.getProductId());
		if (product != null) {
			//关联产品信息
			userInvest.setIncomeType(product.getIncomeType());
			userInvest.setIncomeDays(product.getIncomeDays());
			userInvest.setProductId(product.getId());
			userInvest.setProductName(product.getName());
			userInvest.setIncome(product.getIncome());
			userInvest.setIncomeFloat(product.getIncomeFloat());
		}
		if (object.getType() == 1) {//使用金币
			object.setPayTime(new Date());
			userInvest.setStatus(UserInvest.STATUS_APPLY_ED);
			User u = new User();
			u.setId(object.getUserId());
			u.setIntegral(-useIntegral);
			userService.plus(u);
			if (product.getIncomeType() == Product.INCOME_TYPE_FLOAT) {
					Integer incomeDays = product.getIncomeDays();
					Date now = new Date();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					try {
						now = sdf.parse(sdf.format(now));
					} catch (ParseException e) {
						throw new RuntimeException(e);
					}
					Calendar calendar = Calendar.getInstance();
					calendar.setTime(now);
					calendar.add(Calendar.DAY_OF_YEAR, 1);
					userInvest.setIncomeStartTime(calendar.getTime());
					calendar.setTime(now);
					calendar.add(Calendar.DAY_OF_YEAR, incomeDays);
					userInvest.setIncomeEndTime(calendar.getTime());
			}
			if (useIntegral != null && useIntegral > 0) {
				//做金币抵扣逻辑处理
				object.setUseIntegral(useIntegral);
				//修改用户积分数
				UserIntegral userIntegralParam = new UserIntegral();
				userIntegralParam.setUserId(UseridTracker.get());
				userIntegralParam.addCondition("vaild_end_time >= '" + DateUtil.formatDate(new Date(), "yyyy-MM-dd") + "'", Condition.SEP_AND);
				userIntegralParam.addCondition("sell_integral > 0", Condition.SEP_AND);
				userIntegralParam.addOrderBy("vaild_end_time", false);//过期时间正序
				List<UserIntegral> list = userIntegralService.list(userIntegralParam);
				String sourceId = "";
				for (UserIntegral userIntegral : list) {
					sourceId += userIntegral.getId() + ",";
					//突然不想写modifyCount方法。用修改方法算了
					if (useIntegral.intValue() >= userIntegral.getSellIntegral().intValue()) {
						useIntegral -= userIntegral.getSellIntegral();
						userIntegral.setSellIntegral(0);
						userIntegralService.mdfy(userIntegral);
					} else {
						userIntegral.setSellIntegral(userIntegral.getSellIntegral() - useIntegral);
						userIntegralService.mdfy(userIntegral);
						break;
					}
				}
				if (StringUtil.isNotBlank(sourceId)) {
					sourceId = sourceId.substring(0, sourceId.length() - 1);
				}
				object.setSourceId(sourceId);
				object.setStatus(1);//支付成功
				/*
				String json_data = "";
				// 组装json_data数据
				json_data = "{\"first\": {\"value\":\"您好，您的认购申请已确认。\",\"color\":\"#173177\"}," +
							"\"confirmDate\":{\"value\":\"" + DateUtil.getDateSampleString(new Date(), "yyyy-MM-dd") + "\",\"color\":\"#173177\"}," +
							"\"confirmMsg\": {\"value\":\"支付成功\",\"color\":\"#173177\"}," +
							"\"confirmMoney\": {\"value\":\"" + object.getInvestMoney() + "元\",\"color\":\"#173177\"}," +
							"\"confirmAmount\": {\"value\":\"" + object.getInvestMoney() + "元\",\"color\":\"#173177\"}," +
							"\"remark\": {\"value\":\"如有疑问，请拨打咨询热线400-6196-805。\",\"color\":\"#173177\"}}";
				String paysuccTemplateId = Constants.get("paysucc.templateId");
				TokenForWxapis tokenForWxapis;
				try {
					tokenForWxapis = WxapiUtil.getWxapisToken(Constants.get("wxapi.appid"), Constants.get("wxapi.appsecret"));
					UserBind userBind = new UserBind();
					userBind.setUserId(object.getUserId());
					userBind = userBindDao.select(userBind);
					if (userBind != null) {
						// 推送消息模版
							WxapiUtil.sendTM2WxUser(tokenForWxapis.getAccess_token(), userBind.getAccount(), paysuccTemplateId, "", json_data);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				*/
				
			}
		}
		userInvestService.save(userInvest);
		//保存订单
		return orderDao.insert(object);
	}
	
	
	public void closeDaily(){
		Order object = new Order();
		object.setStatus(-1);	// 等待支付
		object.addCondition("to_days(now()) - " +
			"to_days(create_time) >= 1", Condition.SEP_AND);
		List<Order> orders = list(object);
		for (Order order : orders) {
			String productId = order.getProductId();
			if (productId.equals(Constants.get("product_id_1")) || 
					productId.equals(Constants.get("product_id_2")) ||
					productId.equals(Constants.get("product_id_3"))) {
				continue;
			}
			//修改订单状态
			Order param = new Order();
			param.setId(order.getId());
			param.setStatus(Order.CLOSE);
			param.setUseIntegral(0);
			param.setSourceId("");
			param.setCashId("");
			param.setCashMoney(0);
			param.setType(0);
			orderDao.update(param);
			if (order.getType() == 1) {
				//使用金币
				if (order.getUseIntegral() > 0) {
					Integer useIntegral = order.getUseIntegral();
					//返还用户抵扣积分数
					UserIntegral userIntegralParam = new UserIntegral();
					userIntegralParam.addCondition("id in (" + order.getSourceId() + ")", Condition.SEP_AND);
					List<UserIntegral> list = userIntegralService.list(userIntegralParam);
					for (UserIntegral userIntegral : list) {
						//突然不想写modifyCount方法。用修改方法算了
						if (useIntegral.intValue() >= userIntegral.getIntegral().intValue()) {
							useIntegral -= userIntegral.getIntegral();
							userIntegral.setSellIntegral(userIntegral.getIntegral());
							userIntegralService.mdfy(userIntegral);
						} else {
							userIntegral.setSellIntegral(userIntegral.getSellIntegral() + useIntegral);
							userIntegralService.mdfy(userIntegral);
						}
					}
				}
			} else if (order.getType() == 2) {
				//使用代金券
				if (order.getCashMoney() > 0) {
					//修改代金券状态
					String[] cashids = order.getCashId().split(",");
					for (String cashid : cashids) {
						CashCoupon cashCoupon = new CashCoupon();
						cashCoupon.setId(cashid);
						cashCoupon.setStatus(CashCoupon.STATUS_GET_YES);
						cashCoupon.setUseTime(null);
						cashCouponDao.update(cashCoupon);
					}
				}
			} else if (order.getType() == 3) {
				//两者都使用
				if (order.getUseIntegral() > 0) {
					Integer useIntegral = order.getUseIntegral();
					//返还用户抵扣积分数
					UserIntegral userIntegralParam = new UserIntegral();
					userIntegralParam.addCondition("id in (" + order.getSourceId() + ")", Condition.SEP_AND);
					List<UserIntegral> list = userIntegralService.list(userIntegralParam);
					for (UserIntegral userIntegral : list) {
						//突然不想写modifyCount方法。用修改方法算了
						if (useIntegral.intValue() >= userIntegral.getIntegral().intValue()) {
							useIntegral -= userIntegral.getIntegral();
							userIntegral.setSellIntegral(userIntegral.getIntegral());
							userIntegralService.mdfy(userIntegral);
						} else {
							userIntegral.setSellIntegral(userIntegral.getSellIntegral() + useIntegral);
							userIntegralService.mdfy(userIntegral);
						}
					}
				}
				if (order.getCashMoney() > 0) {
					//修改代金券状态
					String[] cashids = order.getCashId().split(",");
					for (String cashid : cashids) {
						CashCoupon cashCoupon = new CashCoupon();
						cashCoupon.setId(cashid);
						cashCoupon.setStatus(CashCoupon.STATUS_GET_YES);
						cashCoupon.setUseTime(null);
						cashCouponDao.update(cashCoupon);
					}
				}
			}
			UserInvest invest = new UserInvest();
			invest.setOrderId(order.getId());
			userInvestService.lose(invest);
		}
	}
	
	public void closeQuart(){
		Order object = new Order();
		object.setStatus(-1);	// 等待支付
		object.setOnlinePay(1);//线上支付的产品订单
		object.addCondition("unix_timestamp(now()) - " +
			"unix_timestamp(create_time) >= 40*60", Condition.SEP_AND);
		List<Order> orders = list(object);
		for (Order order : orders) {
			//修改订单状态
			Order param = new Order();
			param.setId(order.getId());
			param.setStatus(Order.CLOSE);
			param.setUseIntegral(0);
			param.setSourceId("");
			param.setCashId("");
			param.setCashMoney(0);
			param.setType(0);
			orderDao.update(param);
			if (order.getType() == 1) {
				//使用金币
				if (order.getUseIntegral() > 0) {
					Integer useIntegral = order.getUseIntegral();
					//返还用户抵扣积分数
					UserIntegral userIntegralParam = new UserIntegral();
					userIntegralParam.addCondition("id in (" + order.getSourceId() + ")", Condition.SEP_AND);
					List<UserIntegral> list = userIntegralService.list(userIntegralParam);
					for (UserIntegral userIntegral : list) {
						//突然不想写modifyCount方法。用修改方法算了
						if (useIntegral.intValue() >= userIntegral.getIntegral().intValue()) {
							useIntegral -= userIntegral.getIntegral();
							userIntegral.setSellIntegral(userIntegral.getIntegral());
							userIntegralService.mdfy(userIntegral);
						} else {
							userIntegral.setSellIntegral(userIntegral.getSellIntegral() + useIntegral);
							userIntegralService.mdfy(userIntegral);
						}
					}
				}
			} else if (order.getType() == 2) {
				//使用代金券
				if (order.getCashMoney() > 0) {
					//修改代金券状态
					String[] cashids = order.getCashId().split(",");
					for (String cashid : cashids) {
						CashCoupon cashCoupon = new CashCoupon();
						cashCoupon.setId(cashid);
						cashCoupon.setStatus(CashCoupon.STATUS_GET_YES);
						cashCoupon.setUseTime(null);
						cashCouponDao.update(cashCoupon);
					}
				}
			} else if (order.getType() == 3) {
				//两者都使用
				if (order.getUseIntegral() > 0) {
					Integer useIntegral = order.getUseIntegral();
					//返还用户抵扣积分数
					UserIntegral userIntegralParam = new UserIntegral();
					userIntegralParam.addCondition("id in (" + order.getSourceId() + ")", Condition.SEP_AND);
					List<UserIntegral> list = userIntegralService.list(userIntegralParam);
					for (UserIntegral userIntegral : list) {
						//突然不想写modifyCount方法。用修改方法算了
						if (useIntegral.intValue() >= userIntegral.getIntegral().intValue()) {
							useIntegral -= userIntegral.getIntegral();
							userIntegral.setSellIntegral(userIntegral.getIntegral());
							userIntegralService.mdfy(userIntegral);
						} else {
							userIntegral.setSellIntegral(userIntegral.getSellIntegral() + useIntegral);
							userIntegralService.mdfy(userIntegral);
						}
					}
				}
				if (order.getCashMoney() > 0) {
					//修改代金券状态
					String[] cashids = order.getCashId().split(",");
					for (String cashid : cashids) {
						CashCoupon cashCoupon = new CashCoupon();
						cashCoupon.setId(cashid);
						cashCoupon.setStatus(CashCoupon.STATUS_GET_YES);
						cashCoupon.setUseTime(null);
						cashCouponDao.update(cashCoupon);
					}
				}
			}
			UserInvest invest = new UserInvest();
			invest.setOrderId(order.getId());
			userInvestService.lose(invest);
		}
	}
	
	public int useIntegral(String orderId, Integer useIntegral) {
		Order order = new Order();
		order.setUseIntegral(useIntegral);
		//修改用户积分数
		UserIntegral object = new UserIntegral();
		object.setUserId(UseridTracker.get());
		object.addCondition("vaild_end_time >= '" + DateUtil.formatDate(new Date(), "yyyy-MM-dd") + "'", Condition.SEP_AND);
		object.addCondition("sell_integral > 0", Condition.SEP_AND);
		object.addOrderBy("vaild_end_time", false);//过期时间正序
		List<UserIntegral> list = userIntegralService.list(object);
		String sourceId = "";
		for (UserIntegral userIntegral : list) {
			sourceId += userIntegral.getId() + ",";
			//突然不想写modifyCount方法。用修改方法算了
			if (useIntegral.intValue() >= userIntegral.getSellIntegral().intValue()) {
				useIntegral -= userIntegral.getSellIntegral();
				userIntegral.setSellIntegral(0);
				userIntegralService.mdfy(userIntegral);
			} else {
				userIntegral.setSellIntegral(userIntegral.getSellIntegral() - useIntegral);
				userIntegralService.mdfy(userIntegral);
				break;
			}
		}
		if (StringUtil.isNotBlank(sourceId)) {
			sourceId = sourceId.substring(0, sourceId.length() - 1);
		}
		//修改订单使用金币以及来源
		order.setId(orderId);
		order.setSourceId(sourceId);
		return orderDao.update(order);
	}
}
