package com.alidao.gifts.service.impl;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Random;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alidao.basic.dao4mybatis.IntegralTypeDao;
import com.alidao.basic.entity.IntegralType;
import com.alidao.common.Constants;
import com.alidao.gifts.dao4mybatis.RedPackageEventDao;
import com.alidao.gifts.dao4mybatis.RedPackageRecordDao;
import com.alidao.gifts.entity.RedPackageEvent;
import com.alidao.gifts.entity.RedPackageRecord;
import com.alidao.gifts.service.RedPackageRecordService;
import com.alidao.jse.global.EncodeVar;
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
import com.alidao.users.service.UserService;
import com.alidao.wxapi.bean.TokenForWxapis;
import com.alidao.wxapi.bean.UserForWxUnion;
import com.alidao.wxapi.util.OpenidTracker;
import com.alidao.wxapi.util.WxapiUtil;

@Service
public class RedPackageRecordServiceImpl implements RedPackageRecordService {
	private Log log = LogFactory.getLog(this.getClass());
     @Autowired 
     private RedPackageRecordDao redPackageRecordDao;

     @Autowired
     private RedPackageEventDao redPackageEventDao;
     
     @Autowired
     private IntegralTypeDao integralTypeDao;
     
     @Autowired
     private UserDao userDao;
     
     @Autowired
     private UserBindDao userBindDao;
     
     @Autowired
     private UserIntegralDao userIntegralDao;

     @Autowired
     private UserIntegralService userIntegralService;
     
     @Autowired
     private UserService userService;
    public int save(RedPackageRecord object) {
        return redPackageRecordDao.insert(object);
    }

    public int save(List<RedPackageRecord> objects) {
        int result = 0;
        for (RedPackageRecord object : objects) {
            result &= redPackageRecordDao.insert(object);
        }
        return result;
    }

    public int lose(String id) {
        return redPackageRecordDao.deleteByPrimaryKey(id);
    }

    public int lose(RedPackageRecord object) {
        return redPackageRecordDao.delete(object);
    }

    public int mdfy(RedPackageRecord object) {
        return redPackageRecordDao.update(object);
    }

    public RedPackageRecord find(String id) {
        return redPackageRecordDao.selectByPrimaryKey(id);
    }

    public RedPackageRecord find(RedPackageRecord object) {
        return redPackageRecordDao.select(object);
    }

    public Page<RedPackageRecord> page(PageParam pageParam, RedPackageRecord object) {
        return redPackageRecordDao.queryForPage(pageParam,object);
    }

    public List<RedPackageRecord> list(RedPackageRecord object) {
        return redPackageRecordDao.queryForList(object);
    }

	public RedPackageRecord save(String redPackageEventId, String userId,Integer num) {
		RedPackageEvent redPackageEvent=redPackageEventDao.selectByPrimaryKey(redPackageEventId);
		IntegralType integralType=integralTypeDao.selectByPrimaryKey(redPackageEvent.getIntegralTypeId());
		RedPackageRecord object=new RedPackageRecord();
		String [] remark={"据说抢到的金币马上花掉会有好运哦~","抢到金币棒棒哒，快去购买吧！",
				"哇塞，今天人品非常好哟！","小象要哭了，金币都被你抢走了！","金币拿去，随便花！"};
		Random random=new Random();
		int number=random.nextInt(remark.length);
		object.setRemark(remark[number]);
		User user=userDao.selectByPrimaryKey(userId);
		object.setUserId(userId);
		object.setUserAccount(user.getMobile());
		object.setIntegral(num);//老用户10积分 
		object.setSourceId(redPackageEventId);
		object.setSourceName(redPackageEvent.getName());
		String appid = Constants.get("wxapi.appid");
		String appsecret = Constants.get("wxapi.appsecret");
		String openid = OpenidTracker.get();
		try {
			TokenForWxapis token = WxapiUtil.
				getWxapisToken(appid, appsecret);
			String access_token = token.getAccess_token();
			UserForWxUnion union = WxapiUtil.
				getWxUnionUser(access_token, openid);
			if(!StringUtil.isEmpty(union.getNickname())){
				object.setUserName(new String(union.getNickname().getBytes(EncodeVar.ISO_8859_1), EncodeVar.UTF_8));
			}else{
				object.setUserName("");
			}
			object.setUserImage(union.getHeadimgurl());
		}catch (Exception e1) {
			log.error(e1.getMessage(), e1);
		}
		save(object);
		
		
		int count=random.nextInt(5)+1;
		redPackageEvent.setGetCount(redPackageEvent.getGetCount()+1);
		redPackageEvent.setForwardCount(redPackageEvent.getForwardCount()+count);
		redPackageEventDao.update(redPackageEvent);
		
		User newUser = new User();
		newUser.setId(userId);
		newUser.setIntegral(num);
		userDao.modifyCounts(newUser);//用户积分增加
		
		
		UserIntegral integral = new UserIntegral();
		integral.setUserId(userId);
		integral.setIntegral(num);
		integral.setType(UserIntegral.TYPE_GET_RED_PACK);
		integral.setNote("领红包获得" + num + "金币");
		integral.setIntegralTypeId(integralType.getId());
		if(integralType.getUnit()==3){//月
			integral.setVaildEndTime(DateUtil.monthAddMonth(new Date(), integralType.getTime()));
		}else if(integralType.getUnit()==1){//时
			integral.setVaildEndTime(addHour(new Date(), integralType.getTime()));
		}else if(integralType.getUnit()==2){//天
			integral.setVaildEndTime(addDay(new Date(), integralType.getTime()));
		}
		userIntegralDao.insert(integral);
		
		try {
			// 根据UID获取用户
			user = userDao.selectByPrimaryKey(userId);
			// 积分变动模版推送
			String json_data = "";
			// 组装json_data数据
			json_data = "{\"first\": {\"value\":\"亲爱的" + user.getRealname() + "，请查看您的金币变动。\",\"color\":\"#173177\"}," +
						"\"time\":{\"value\":\"" + DateUtil.getDateSampleString(new Date(), "yyyy年MM月dd日 HH:mm") + "\",\"color\":\"#173177\"}," +
						"\"add_Jifen\": {\"value\":\"" + num + "个金币\",\"color\":\"#173177\"}," +
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
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
		return object;
	}
	
	public static Date addHour(Date date, int hour)
    {
        Calendar calendar = convert(date);
        calendar.add(Calendar.HOUR, hour);
        return calendar.getTime();
    }
	public static Date addDay(Date date, int day)
    {
        Calendar calendar = convert(date);
        calendar.add(Calendar.DAY_OF_MONTH, day);
        return calendar.getTime();
    }
	private static Calendar convert(Date date)
    {
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        return calendar;
    }

	public RedPackageRecord bindAndGet(String redPackageEventId, String mobile, String openid) {
		RedPackageEvent redPackageEvent=redPackageEventDao.selectByPrimaryKey(redPackageEventId);
		RedPackageRecord object = new RedPackageRecord();
		User user = new User();
		user.setMobile(mobile);
		user = userDao.select(user);
		if (user == null) {
			User newUser=new User();
			newUser.setUsername(mobile);
			newUser.setMobile(mobile);
			newUser.setRealname("");
			newUser.setType(User.U_TYPE_COMMON);
			newUser.setStatus(User.STATUS_NEWREG);
			newUser.setSource(User.SOURCE_WECHAT);
			try {
				userService.save(newUser);
				userService.bind(newUser.getId(), openid, User.BINDED_WECHAT, false);//绑定微信
				object = save(redPackageEventId,newUser.getId(),redPackageEvent.getMaxIntegral());//新用户50
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			// userService.bind(user.getId(), openid, User.BINDED_WECHAT, false);//绑定微信
			RedPackageRecord record = new RedPackageRecord();
			record.setUserId(user.getId());
			record.setSourceId(redPackageEventId);
			record = redPackageRecordDao.select(record);
			if (record == null) {
				object = save(redPackageEventId,user.getId(),redPackageEvent.getMinIntegral());
			} else {
				return record;
			}
		}
		return object;
	}
}