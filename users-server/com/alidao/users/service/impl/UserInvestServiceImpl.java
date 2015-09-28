package com.alidao.users.service.impl;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alidao.basic.dao4mybatis.CashCouponDao;
import com.alidao.basic.dao4mybatis.GameDao;
import com.alidao.basic.dao4mybatis.GameRecordDao;
import com.alidao.basic.dao4mybatis.OrderDao;
import com.alidao.basic.dao4mybatis.ProductDao;
import com.alidao.basic.entity.CashCoupon;
import com.alidao.basic.entity.Game;
import com.alidao.basic.entity.GameRecord;
import com.alidao.basic.entity.Order;
import com.alidao.basic.entity.Product;
import com.alidao.common.Constants;
import com.alidao.jse.util.DateUtil;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.model.Condition;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.users.dao4mybatis.UserBindDao;
import com.alidao.users.dao4mybatis.UserDao;
import com.alidao.users.dao4mybatis.UserIntegralDao;
import com.alidao.users.dao4mybatis.UserInvestDao;
import com.alidao.users.entity.User;
import com.alidao.users.entity.UserBind;
import com.alidao.users.entity.UserIntegral;
import com.alidao.users.entity.UserInvest;
import com.alidao.users.service.UserInvestService;
import com.alidao.wxapi.bean.TokenForWxapis;
import com.alidao.wxapi.util.WxapiUtil;

@Service
public class UserInvestServiceImpl implements UserInvestService {

	@Autowired
	private UserDao userDao;
	
	@Autowired
	private UserInvestDao userInvestDao;
	
	@Autowired
	private OrderDao orderDao;
	
	@Autowired
	private UserIntegralDao userIntegralDao;
	
	@Autowired
	private CashCouponDao cashCouponDao;
	
	@Autowired
	private UserBindDao userBindDao;
	
	@Autowired
	private ProductDao productDao;
	
	@Autowired
	private GameDao gameDao;
	
	@Autowired
	private GameRecordDao gameRecordDao;
	
	public int save(UserInvest object) {
		// 插入对应的订单信息
		Order order = createOrder(object);
		if (order != null) {
			String serial = StringUtil.genMsecSerial();
			int rand = new Random().nextInt(10);
			order.setType(1);
			order.setId(serial.substring(2) + rand);
			orderDao.insert(order);
			object.setOrderId(order.getId());
		}
		User user = new User();
		user.setId(object.getUserId());
		user.setOrders(1);
		userDao.modifyCounts(user);
		object.beforeInsert();
		return userInvestDao.insert(object);
	}

	private Order createOrder(UserInvest object) {
		Order order = object.getOrder();
		if (order != null) {
			String userId = object.getUserId();
			order.setUserId(userId);
			User user = userDao.selectByPrimaryKey(userId);
			if (user != null) {
				order.setUserLinkman(user.getRealname());
				order.setUserUsername(user.getUsername());
				order.setUserContact(user.getMobile());
			}
			Product product = productDao.selectByPrimaryKey(object.getProductId());
			order.setProductType(product.getType());
			order.setProductId(object.getProductId());
			order.setInvestMoney(object.getInvestMoney());
			if (object.getStatus() != UserInvest.STATUS_APPLY_ED) {
				order.setPayType(6);
				order.setPayTime(new Date());
				order.setStatus(Order.PAYED);
			} else {
				order.setStatus(Order.UNPAY);
			}
			return order;
		}
		return null;
	}
	
	public int mdfy(UserInvest object) {
		// 更新对应的订单信息
		Long id = object.getId();
		UserInvest invest = find(id);
		String orderId = invest.getOrderId();
		Order order = createOrder(object);
		if (StringUtil.isNotBlank(orderId)) {
			order.setId(orderId);
			orderDao.update(order);
		} else {
			String serial = StringUtil.genMsecSerial();
			int rand = new Random().nextInt(10);
			order.setId(serial.substring(2) + rand);
			orderDao.insert(order);
		}
		object.setOrderId(order.getId());
		object.beforeUpdate();
		object.setReaded(0);
		return userInvestDao.update(object);
	}
	
	public int lose(Long id) {
		UserInvest object = find(id);
		String orderId = object.getOrderId();
		int result = userInvestDao.deleteByPrimaryKey(id);
		if (result == 1) {
			if (StringUtil.isNotBlank(orderId)) {
				Order order = orderDao.selectByPrimaryKey(orderId);
				if (order != null) {
					//修改订单状态
					Order param = new Order();
					param.setId(orderId);
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
							List<UserIntegral> list = userIntegralDao.queryForList(userIntegralParam);
							for (UserIntegral userIntegral : list) {
								//突然不想写modifyCount方法。用修改方法算了
								if (useIntegral.intValue() >= userIntegral.getIntegral().intValue()) {
									useIntegral -= userIntegral.getIntegral();
									userIntegral.setSellIntegral(userIntegral.getIntegral());
									userIntegralDao.update(userIntegral);
								} else {
									userIntegral.setSellIntegral(userIntegral.getSellIntegral() + useIntegral);
									userIntegralDao.update(userIntegral);
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
							List<UserIntegral> list = userIntegralDao.queryForList(userIntegralParam);
							for (UserIntegral userIntegral : list) {
								//突然不想写modifyCount方法。用修改方法算了
								if (useIntegral.intValue() >= userIntegral.getIntegral().intValue()) {
									useIntegral -= userIntegral.getIntegral();
									userIntegral.setSellIntegral(userIntegral.getIntegral());
									userIntegralDao.update(userIntegral);
								} else {
									userIntegral.setSellIntegral(userIntegral.getSellIntegral() + useIntegral);
									userIntegralDao.update(userIntegral);
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
				}
			}
		}
		return result;
	}

	public int lose(UserInvest object) {
		return userInvestDao.delete(object);
	}
	
	public UserInvest find(Long id) {
		UserInvest object = 
			userInvestDao.selectByPrimaryKey(id);
		if (object != null) {
			String orderId = object.getOrderId();
			if (StringUtil.isNotBlank(orderId)) {
				object.setOrder(orderDao.
					selectByPrimaryKey(orderId));
			}
		}
		return object;
	}
	
	public UserInvest find(UserInvest object) {
		object = userInvestDao.select(object);
		if (object != null) {
			String orderId = object.getOrderId();
			if (StringUtil.isNotBlank(orderId)) {
				object.setOrder(orderDao.
					selectByPrimaryKey(orderId));
			}
		}
		return object;
	}

	public Page<UserInvest> page(PageParam pageParam, UserInvest object) {
		Page<UserInvest> page = userInvestDao.queryForPage(pageParam, object);
		List<UserInvest> list = page.getTableList();
		for (int i = 0; list != null && i < list.size(); i++) {
			String orderId = list.get(i).getOrderId();
			list.get(i).setOrder(orderDao.selectByPrimaryKey(orderId));
		}
		return page;
	}

	public List<UserInvest> list(UserInvest object) {
		List<UserInvest> list = userInvestDao.queryForList(object);
		for (int i = 0; list != null && i < list.size(); i++) {
			String orderId = list.get(i).getOrderId();
			list.get(i).setOrder(orderDao.selectByPrimaryKey(orderId));
		}
		return list;
	}
	
	public int isum(String userId, Integer status) {
		UserInvest object = new UserInvest();
		object.setUserId(userId);
		object.setStatus(status);
		return userInvestDao.sumOfInvMoney(object);
	}
	
	public Double gsum(String userId, Integer status) {
		UserInvest object = new UserInvest();
		object.setUserId(userId);
		object.setStatus(status);
		return userInvestDao.sumOfIncMoney(object);
	}

	public void sset() throws Exception {
		synchronized (this.getClass()) {
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			try {
				now = sdf.parse(sdf.format(now));
			} catch (ParseException e) {
				throw new RuntimeException(e);
			}
			Long pageNo = 0L, pageSize = 20L;
			PageParam pageParam = new PageParam();
			pageParam.setPageNo(pageNo);
			pageParam.setPageSize(pageSize);
			UserInvest object = new UserInvest();
			object.addCondition("status", UserInvest.CDT_UN_EQ, 
				UserInvest.STATUS_HAS_OVER + "", UserInvest.SEP_AND);
			boolean hasnext = true;
			Page<UserInvest> page = null;
			do {	// 分页轮询投资记录,对不同状态做不同处理
				pageParam.setPageNo(++pageNo);
				page = userInvestDao.queryForPage(pageParam, object);
				if (page.getResult() == Page.SUCC) {
					List<UserInvest> list = page.getTableList();
					for (int i = 0; list != null && i < list.size(); i++) {
						UserInvest invest = list.get(i);
						if (invest.getStatus() == UserInvest.STATUS_APPLY_ED) {
							// 申请中：1.是否已经到收益时间,2.是否已支付
							Date start = invest.getIncomeStartTime();
							if (start != null && !now.before(start)) {
								String id = invest.getOrderId();
								Order order = orderDao.selectByPrimaryKey(id);
								if (order != null) {
									if (order.getStatus() == Order.PAYED) {
										Product p = productDao.selectByPrimaryKey(order.getProductId());
										Game game = new Game();
										game.addCondition("product_id", 
												Condition.CDT_LIKE, ("'%" + order.getProductId() + "%'"), 
												Condition.SEP_AND);
										game = gameDao.select(game);
										DecimalFormat df = new DecimalFormat("#.00");
										if (game != null && p.getGame() == 1) {
											GameRecord gameRecord = new GameRecord();
											gameRecord.addOrderBy("score+friendScore", true);
											gameRecord.setGameId(game.getId());
											List<GameRecord> gameRecordList = gameRecordDao.queryForList(gameRecord);
											for(int t = 0; gameRecordList != null && t < gameRecordList.size(); t++){
												Double step = ((double) (20 - 10)) / (gameRecordList.size() - 1);
												Double income = 20.00 - t * step;
												GameRecord record = gameRecordList.get(t);
												if(record.getUserId().equals(invest.getUserId())){
													invest.setIncome(Double.valueOf(df.format(income)));
													invest.setIncomeMoney(invest._calcAllIncomeMoney());
													userInvestDao.update(invest);
												}
											}
										}
										invest.setStatus(UserInvest.STATUS_HOLD_ING);
										invest.setReaded(0);
										userInvestDao.update(invest);
										//修改用户总资产
										User user = new User();
										user.setId(invest.getUserId());
										user.setAssets(invest.getInvestMoney());
										userDao.modifyCounts(user);
										
										//项目起息模版推送
										User uresult = userDao.selectByPrimaryKey(invest.getUserId());
										Product product = productDao.selectByPrimaryKey(invest.getProductId());
										if (uresult != null && product != null) {
											String json_data = "";
											//组装json_data数据
											json_data = "{\"first\": {\"value\":\"亲爱的" + uresult.getRealname() + "，您认购‘" + product.getName() + "’产品成功，即日起息。\",\"color\":\"#173177\"}," +
														"\"keyword1\":{\"value\":\"" + product.getName() + "\",\"color\":\"#173177\"}," +
														"\"keyword2\": {\"value\":\"" + df.format(invest.getIncome()) + "%\",\"color\":\"#173177\"}," +
														"\"keyword3\": {\"value\":\"" + product.getEndTime() + "\",\"color\":\"#173177\"}," +
														"\"keyword4\": {\"value\":\"" + invest.getInvestMoney() + "元\",\"color\":\"#173177\"}," +
														"\"keyword5\": {\"value\":\"" + df.format(invest.getIncomeMoney()) + "元\",\"color\":\"#173177\"}," +
														"\"remark\": {\"value\":\"还款方式: 到期一次性返还本金和收益。起息日期：" + DateUtil.getDateSampleString(invest.getIncomeStartTime(), "yyyy-MM-dd") + "，到期日期：" + DateUtil.getDateSampleString(invest.getIncomeEndTime(), "yyyy-MM-dd") + "\",\"color\":\"#173177\"}}";
											String incomestartTemplateId = Constants.get("incomestart.templateId");
											TokenForWxapis tokenForWxapis = WxapiUtil.getWxapisToken(Constants.get("wxapi.appid"), Constants.get("wxapi.appsecret"));
											UserBind userBind = new UserBind();
											userBind.setUserId(invest.getUserId());
											userBind = userBindDao.select(userBind);
											if (userBind != null) {
												//推送消息模版
												WxapiUtil.sendTM2WxUser(tokenForWxapis.getAccess_token(), userBind.getAccount(), incomestartTemplateId, "", json_data);
											}
										}
									}
								}
							}
						} else { // 持有中：判断时间是否已经过收益截止日期
							Date end = invest.getIncomeEndTime();
							if (now.after(end)) {
								invest.setStatus(UserInvest.STATUS_HAS_OVER);
								invest.setReaded(0);
								userInvestDao.update(invest);
								//修改用户总资产
								User user = new User();
								user.setId(invest.getUserId());
								user.setAssets(- invest.getInvestMoney());
								userDao.modifyCounts(user);
							}
						}
					}
				}
				hasnext = page.getPageParam().getHasNext();
			} while (hasnext);
		}
	}

	public void updateReaded(UserInvest object) {
		 userInvestDao.updateReaded(object);
	}
	
}
