package com.alidao.basic.service.impl;

import java.util.Date;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alidao.basic.dao4mybatis.CashCouponDao;
import com.alidao.basic.dao4mybatis.OrderDao;
import com.alidao.basic.dao4mybatis.ProductDao;
import com.alidao.basic.entity.CashCoupon;
import com.alidao.basic.entity.Order;
import com.alidao.basic.entity.Product;
import com.alidao.basic.service.CashCouponService;
import com.alidao.common.Constants;
import com.alidao.jse.util.DateUtil;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.model.Condition;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.users.dao4mybatis.UserBindDao;
import com.alidao.users.dao4mybatis.UserDao;
import com.alidao.users.entity.User;
import com.alidao.users.entity.UserBind;
import com.alidao.wxapi.bean.TokenForWxapis;
import com.alidao.wxapi.util.WxapiUtil;

@Service
public class CashCouponServiceImpl implements CashCouponService {
	
	private Log log = LogFactory.getLog(this.getClass());

	@Autowired
	private CashCouponDao cashCouponDao;
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private UserBindDao userBindDao;
	
	@Autowired
	private OrderDao orderDao;
	
	@Autowired
	private ProductDao productDao;
	public int save(CashCoupon object) {
		User user = userDao.selectByPrimaryKey(object.getUserId());
		if (user != null) {
			//查询可用代金券记录
			CashCoupon cashCouponParam = new CashCoupon();
			cashCouponParam.setUserId(object.getUserId());
			cashCouponParam.setStatus(CashCoupon.STATUS_GET_YES);
			cashCouponParam.addCondition("now() <= vaild_end_time", Condition.SEP_AND);
			List<CashCoupon> list = cashCouponDao.queryForList(cashCouponParam);
			Integer money = 0;
			for (CashCoupon cashCoupon : list) {
				//计算总代金券金额
				money += cashCoupon.getMoney();
			}
			try {
				//积分变动模版推送
				String json_data = "";
				//组装json_data数据
				json_data = "{\"first\": {\"value\":\"亲爱的" + user.getRealname() + "，请查看您的代金券变动。\",\"color\":\"#173177\"}," +
							"\"time\":{\"value\":\"" + DateUtil.getDateSampleString(new Date(), "yyyy年MM月dd日 HH:mm") + "\",\"color\":\"#173177\"}," +
							"\"add_Jifen\": {\"value\":\"" + object.getMoney() + "元代金券\",\"color\":\"#173177\"}," +
							"\"consume_Jifen\": {\"value\":\"0元代金券\",\"color\":\"#173177\"}," +
							"\"jifen\": {\"value\":\"" + (money + object.getMoney()) + "元代金券\",\"color\":\"#173177\"}," +
							"\"remark\": {\"value\":\"如有疑问，请拨打高和畅客服热线400-6196-805。\",\"color\":\"#173177\"}}";
				String goldTemplateId = Constants.get("gold.templateId");
				TokenForWxapis tokenForWxapis = WxapiUtil.getWxapisToken(Constants.get("wxapi.appid"), Constants.get("wxapi.appsecret"));
				UserBind userBind = new UserBind();
				userBind.setUserId(object.getUserId());
				userBind = userBindDao.select(userBind);
				if (userBind != null) {
					//推送消息模版
					WxapiUtil.sendTM2WxUser(tokenForWxapis.getAccess_token(), userBind.getAccount(), goldTemplateId, "", json_data);
				}
			} catch (Exception e) {
				log.error(e.getMessage(), e);
			}
		}
		return cashCouponDao.insert(object);
	}
	
	public int mdfy(CashCoupon object) {
		return cashCouponDao.update(object);
	}
	
	public int lose(String id) {
		return cashCouponDao.deleteByPrimaryKey(id);
	}

	public int lose(CashCoupon object) {
		return cashCouponDao.delete(object);
	}
	
	public CashCoupon find(String id) {
		return cashCouponDao.selectByPrimaryKey(id);
	}
	
	public CashCoupon find(CashCoupon object) {
		return cashCouponDao.select(object);
	}

	public Page<CashCoupon> page(PageParam pageParam, CashCoupon object) {
		Page<CashCoupon> page = cashCouponDao.queryForPage(pageParam, object);
		List<CashCoupon> list = page.getTableList();
		for (int i = 0; list != null && i < list.size(); i++) {	
			CashCoupon cashCoupon = list.get(i);
			if(cashCoupon.getStatus()==CashCoupon.STATUS_USE_YES&&StringUtil.isEmpty(cashCoupon.getProductId())){
				Order order=new Order();
				order.addCondition("cash_id", 
						Condition.CDT_LIKE, ("'%" +cashCoupon.getId() + "%'"), 
						Condition.SEP_AND);
				order=orderDao.select(order);
				if(order!=null){
					Product product=productDao.selectByPrimaryKey(order.getProductId());
					cashCoupon.setProductId(order.getProductId());
					cashCoupon.setProductName(product.getName());
					cashCoupon.setUserName(order.getUserName());
					cashCouponDao.update(cashCoupon);
				}
			}
			if (object.getStatus()==null&&cashCoupon.getVaildEndTime().getTime() < new Date().getTime()) {
				cashCoupon.setStatus(CashCoupon.STATUS_EXPIRED);//已过期
			}
		}
		return page;
	}

	public List<CashCoupon> list(CashCoupon object) {
		return cashCouponDao.queryForList(object);
	}
	
	public int read(String userId) {
		CashCoupon object = new CashCoupon();
		object.setUserId(userId);
		object.setReaded(CashCoupon.READ_YES);
		return cashCouponDao.setUserStatus(object);
	}
	
	public Integer getCashCoupons(String userId) {
		CashCoupon object = new CashCoupon();
		object.setUserId(userId);
		return cashCouponDao.queryForCount(object).intValue();
	}

}
