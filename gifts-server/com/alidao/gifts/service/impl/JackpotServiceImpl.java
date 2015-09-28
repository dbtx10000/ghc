package com.alidao.gifts.service.impl;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alidao.common.Constants;
import com.alidao.gifts.dao4mybatis.AwardDao;
import com.alidao.gifts.dao4mybatis.JackpotDao;
import com.alidao.gifts.dao4mybatis.JackpotTypeDao;
import com.alidao.gifts.dao4mybatis.RedPacketDao;
import com.alidao.gifts.dao4mybatis.WinningRecordDao;
import com.alidao.gifts.entity.Award;
import com.alidao.gifts.entity.Jackpot;
import com.alidao.gifts.entity.JackpotType;
import com.alidao.gifts.entity.RedPacket;
import com.alidao.gifts.entity.WinningRecord;
import com.alidao.gifts.service.JackpotService;
import com.alidao.gifts.service.JackpotTypeService;
import com.alidao.jse.util.DateUtil;
import com.alidao.jxe.model.Condition;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.users.dao4mybatis.BuyProductRecordDao;
import com.alidao.users.dao4mybatis.UserBindDao;
import com.alidao.users.dao4mybatis.UserDao;
import com.alidao.users.dao4mybatis.UserIntegralDao;
import com.alidao.users.entity.BuyProductRecord;
import com.alidao.users.entity.User;
import com.alidao.users.entity.UserBind;
import com.alidao.users.entity.UserIntegral;
import com.alidao.users.service.UserIntegralService;
import com.alidao.wxapi.bean.TokenForWxapis;
import com.alidao.wxapi.util.WxapiUtil;

@Service
public class JackpotServiceImpl implements JackpotService {

	private Log log = LogFactory.getLog(this.getClass());

	@Autowired
	private JackpotDao jackpotDao;

	@Autowired
	private RedPacketDao redPacketDao;
	
	@Autowired
	private AwardDao awardDao;
	
	@Autowired
	private WinningRecordDao winningRecordDao;
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private UserIntegralDao userIntegralDao;
	
	@Autowired
	private BuyProductRecordDao buyProductRecordDao;
	
	@Autowired
	private UserIntegralService userIntegralService;
	
	@Autowired
	private UserBindDao userBindDao;
	
//	@Autowired
//	private CashCouponService cashCouponService;
	
	@Autowired
	private JackpotTypeService jackpotTypeService;
	
	@Autowired
	private JackpotTypeDao jackpotTypeDao;
	public int save(Jackpot object) {
		return jackpotDao.insert(object);
	}

	public int mdfy(Jackpot object) {
		Jackpot jackpot=new Jackpot();
		jackpot.setId(object.getId());
		jackpot=jackpotDao.select(jackpot);
		if(jackpot.getRelateType()==Jackpot.TYPE_RED_PACKET){
			RedPacket redPacket=redPacketDao.selectByPrimaryKey(jackpot.getRelateId());
			redPacket.setResidueCount(redPacket.getResidueCount()+(jackpot.getCount()-object.getCount()));
			redPacketDao.update(redPacket);
		}else if(jackpot.getRelateType()==Jackpot.TYPE_AWARD){
			Award award=awardDao.selectByPrimaryKey(jackpot.getRelateId());
			award.setResidueCount(award.getResidueCount()+(jackpot.getCount()-object.getCount()));
			awardDao.update(award);
		}
		return jackpotDao.update(object);
	}


	public int lose(Jackpot object) {
		object=jackpotDao.select(object);
		JackpotType jackpotType=new JackpotType();
		jackpotType.setProductId(object.getProductId());
		jackpotType=jackpotTypeDao.select(jackpotType);
		jackpotType.setJackpotCount(jackpotType.getJackpotCount()-1);
		jackpotTypeDao.update(jackpotType);
		if(object.getRelateType()==Jackpot.TYPE_RED_PACKET){
			RedPacket redPacket=redPacketDao.selectByPrimaryKey(object.getRelateId());
			redPacket.setResidueCount(redPacket.getResidueCount()+object.getCount());
			redPacketDao.update(redPacket);
		}else if(object.getRelateType()==Jackpot.TYPE_AWARD){
			Award award=awardDao.selectByPrimaryKey(object.getRelateId());
			award.setResidueCount(award.getResidueCount()+object.getCount());
			awardDao.update(award);
		}
		return jackpotDao.delete(object);
	}

	public Jackpot find(Jackpot object) {
		Jackpot jackpot = jackpotDao.select(object);
		if (jackpot != null) {
			if (jackpot.getRelateType() == Jackpot.TYPE_RED_PACKET) {
				// 关联红包信息
				jackpot.setRelate(redPacketDao.selectByPrimaryKey(jackpot.getRelateId()));
			}else if (jackpot.getRelateType() == Jackpot.TYPE_AWARD) {
				// 关联奖品信息
				jackpot.setRelate(awardDao.selectByPrimaryKey(jackpot.getRelateId()));
			}
		}
		return jackpot;
	}
	
	public Jackpot find(String id) {
		Jackpot jackpot = jackpotDao.selectByPrimaryKey(id);
		if (jackpot != null) {
			if (jackpot.getRelateType() == Jackpot.TYPE_RED_PACKET) {
				// 关联红包信息
				jackpot.setRelate(redPacketDao.selectByPrimaryKey(jackpot.getRelateId()));
			}else if (jackpot.getRelateType() == Jackpot.TYPE_AWARD) {
				// 关联奖品信息
				jackpot.setRelate(awardDao.selectByPrimaryKey(jackpot.getRelateId()));
			} 
		}
		return jackpot;
	}

	public Page<Jackpot> page(PageParam pageParam, Jackpot object) {
		Page<Jackpot> page = jackpotDao.queryForPage(pageParam, object);
		List<Jackpot> list = page.getTableList();
		// 获取奖池里所有奖品总数
		List<Jackpot> all = jackpotDao.getAllJackpotRelateIdByRelateType(null,object.getProductId());
		double allCount = 0;
		for (int i = 0; all != null && i < all.size(); i++) {
			allCount += all.get(i).getBasic();
		}
		for (int i = 0; list != null && i < list.size(); i++) {
			Jackpot jackpot = list.get(i);
			if (jackpot != null) {
				if (jackpot.getRelateType() == Jackpot.TYPE_RED_PACKET) {
					// 关联红包信息
					jackpot.setRelate(redPacketDao.selectByPrimaryKey(jackpot.getRelateId()));
				}else if (jackpot.getRelateType() == Jackpot.TYPE_AWARD) {
					// 关联奖品信息
					jackpot.setRelate(awardDao.selectByPrimaryKey(jackpot.getRelateId()));
				}
			}
			if (allCount != 0) {
				double d = jackpot.getBasic() / allCount * 100;
				// 保留两位小数
				DecimalFormat df = new DecimalFormat("#.00");
				Double dd = new Double(df.format(d));
				jackpot.setWinProbability(dd);
			}
		}
		return page;
	}

	/**
	 * 导入红包保存
	 */
	public int redPacketSave(String[] ids, Integer[] integral,Integer[] count,Integer[] basic,String productId) {
		int result = 0;
		RedPacket redPacket=new RedPacket();
		JackpotType jackpotType=new JackpotType();
		jackpotType.setProductId(productId);
		jackpotType=jackpotTypeDao.select(jackpotType);
		for (int i = 0; i < ids.length; i++) {
			Jackpot jackpot = new Jackpot();
			jackpot.setRelateId(ids[i]);
			jackpot.setRelateType(Jackpot.TYPE_RED_PACKET);// 红包
			jackpot.setProductId(productId);
			jackpot.setBasic(basic[i]);
			jackpot.setCount(count[i]);
			jackpot.setIntegral(integral[i]);
			jackpot.setWinCount(0);
			result = jackpotDao.insert(jackpot);
			redPacket=redPacketDao.selectByPrimaryKey(ids[i]);
			redPacket.setResidueCount(redPacket.getResidueCount()-count[i]);
			jackpotType.setJackpotCount(jackpotType.getJackpotCount()+1);
			jackpotTypeDao.update(jackpotType);
			redPacketDao.update(redPacket);
		}
		return result;
	}

	public int awardSave(String[] ids, Integer[] count, Integer[] basic,
			String productId) {
		int result = 0;
		Award award=new Award();
		JackpotType jackpotType=new JackpotType();
		jackpotType.setProductId(productId);
		jackpotType=jackpotTypeDao.select(jackpotType);
		for (int i = 0; i < ids.length; i++) {
			Jackpot jackpot = new Jackpot();
			jackpot.setRelateId(ids[i]);
			jackpot.setRelateType(Jackpot.TYPE_AWARD);// 奖品
			jackpot.setProductId(productId);
			jackpot.setBasic(basic[i]);
			jackpot.setCount(count[i]);
			jackpot.setWinCount(0);
			result = jackpotDao.insert(jackpot);
			award=awardDao.selectByPrimaryKey(ids[i]);
			award.setResidueCount(award.getResidueCount()-count[i]);
			jackpotType.setJackpotCount(jackpotType.getJackpotCount()+1);
			jackpotTypeDao.update(jackpotType);
			awardDao.update(award);
		}
		return result;
	}
	
	/**
	 * 根据类型获取所有的奖池里存在的关联ID,用于导入的时候显示列表排除已经在奖池里的数据
	 */
	public String getAllJackpotRelateIdByRelateType(Integer relateType,String productId) {
		List<Jackpot> list = jackpotDao
				.getAllJackpotRelateIdByRelateType(relateType, productId);
		String allRelateId = "";
		if (list != null && list.size() > 0) {
			allRelateId += "'";
			for (Jackpot jackpot : list) {
				allRelateId += jackpot.getRelateId();
				allRelateId += "','";
			}
			allRelateId = allRelateId.substring(0, allRelateId.length() - 2);
		}
		return allRelateId;
	}


	public int hot(Jackpot object) {
		return jackpotDao.update(object);
	}
	
	public List<Jackpot> list(Jackpot object) {
		List<Jackpot> list = jackpotDao.queryForList(object);
		for (int i = 0; list != null && i < list.size(); i++) {
			Jackpot jackpot = list.get(i);
			if (jackpot != null) {
				if (jackpot.getRelateType() == Jackpot.TYPE_RED_PACKET) {
					// 关联红包信息
					jackpot.setRelate(redPacketDao.selectByPrimaryKey(jackpot.getRelateId()));
				}
			}
		}
		return list;
	}
	
	
	/**
	 * 抽奖接口
	 * @return
	 */
	public Map<String,Object> luckyDraw(String uid, String id) {
		Map<String,Object> map = new  HashMap<String,Object>();
		JackpotType jackpotType = jackpotTypeService.find(id);
		String productId = jackpotType.getProductId();
		BuyProductRecord condition = new BuyProductRecord();
		condition.setUserId(uid);
		condition.addOrderBy("status");
		String ids = "";
		for (String productid : productId.split(",")) {
			ids += ",'" + productid + "'";
		}
		ids = "(" + ids.substring(1) + ")";
		condition.addCondition("product_id", Condition.CDT_IN, ids, Condition.SEP_AND);
		List<BuyProductRecord> records = buyProductRecordDao.queryForList(condition);
		if (records != null && records.size() > 0) {
			List<BuyProductRecord> list = new ArrayList<BuyProductRecord>(0);
			for (BuyProductRecord record : records) {
				if (record.getStatus() == 0) {
					list.add(record);
				}
			}
			
			if (list.size() > 0) {//可以抽奖
				List<Jackpot> all = jackpotDao.getAllJackpotByShake(null, productId);
				int allCount = 0;
				for (int i = 0; all != null && i < all.size(); i++) {
					allCount += all.get(i).getBasic();
				}
				Random random = new Random();
				int num = allCount != 0 ? (random.nextInt(allCount) + 1) : 0;
				log.debug("随即生成的数为" + num);
				int nowCount = 0, scale = 0;
				for (BuyProductRecord cell : list) {
					cell.setStatus(1);	// 状态改为已抽奖
					buyProductRecordDao.update(cell);
					scale += cell.getScale();
				}
				if (scale > 20) {
					scale = 20;
				}
				for (int i = 0; all != null && i < all.size(); i++) {
					Jackpot jackpot = all.get(i);
					nowCount += jackpot.getBasic();
					if (nowCount >= num) {
						WinningRecord winningRecord = new WinningRecord();
						winningRecord.setUserId(uid);
						winningRecord.setRelateId(jackpot.getRelateId());
						winningRecord.setRelateType(jackpot.getRelateType());
						
						Jackpot jk = new Jackpot();
						jk.setId(jackpot.getId());
						jk.setCount(-1);
						jk.setWinCount(1);
						jackpotDao.modifyCounts(jk);
						if (jackpot.getRelateType() == Jackpot.TYPE_RED_PACKET) {
							// 关联红包信息
							RedPacket redPacket=redPacketDao.selectByPrimaryKey(jackpot.getRelateId());
							if (redPacket != null) {
								Integer getintegral = redPacket.getIntegral();
								getintegral *= scale;
								
								User user = new User();
								user.setId(uid);
								user.setIntegral(getintegral);
								userDao.modifyCounts(user);//用户积分增加
								
								UserIntegral integral = new UserIntegral();
								integral.setUserId(uid);
								integral.setIntegral(getintegral);
								integral.setType(UserIntegral.TYPE_GET_JACKPOT);
								integral.setNote("抽奖获得" + getintegral + "金币");
								userIntegralDao.insert(integral);
								
								try {
									// 根据UID获取用户
									user = userDao.selectByPrimaryKey(uid);
									// 积分变动模版推送
									String json_data = "";
									// 组装json_data数据
									json_data = "{\"first\": {\"value\":\"亲爱的" + user.getRealname() + "，请查看您的金币变动。\",\"color\":\"#173177\"}," +
												"\"time\":{\"value\":\"" + DateUtil.getDateSampleString(new Date(), "yyyy年MM月dd日 HH:mm") + "\",\"color\":\"#173177\"}," +
												"\"add_Jifen\": {\"value\":\"" + getintegral + "个金币\",\"color\":\"#173177\"}," +
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
								
								/*
								//代金券逻辑处理
								CashCoupon cashCoupon = new CashCoupon();
								cashCoupon.setUserId(uid);
								Date now = new Date();
								cashCoupon.setVaildStartTime(now);
								cashCoupon.setVaildEndTime(DateUtil.monthAddMonth(now, 3));
								cashCoupon.setStatus(CashCoupon.STATUS_GET_YES);
								cashCoupon.setReaded(CashCoupon.READ_NO);
								Integer coupons = 0;
								if (buyProductRecord.getCostMoney() >= 1) {
									cashCoupon.setId(null);
									cashCoupon.setMoney(50);//第一张代金券金额50元
									cashCoupon.setUseCondition(1);//1W才可使用
									cashCouponService.save(cashCoupon);
									coupons += 50;
								}
								if (buyProductRecord.getCostMoney() >= 5) {
									cashCoupon.setId(null);
									cashCoupon.setMoney(200);//第一张代金券金额200元
									cashCoupon.setUseCondition(5);//5W才可使用
									cashCouponService.save(cashCoupon);
									coupons += 200;
								}
								if (buyProductRecord.getCostMoney() >= 10) {
									cashCoupon.setId(null);
									cashCoupon.setMoney(250);//第二张代金券金额250元
									cashCoupon.setUseCondition(10);//10W才可使用
									cashCouponService.save(cashCoupon);
									coupons += 250;
								}
								if (buyProductRecord.getCostMoney() >= 20) {
									cashCoupon.setId(null);
									cashCoupon.setMoney(550);//第三张代金券金额550元
									cashCoupon.setUseCondition(20);//20W才可使用
									cashCouponService.save(cashCoupon);
									coupons += 550;
								}
								*/
								
								// 添加中奖记录
								winningRecord.setSncode("");
								winningRecord.setRelateName(redPacket.getName() + "*" + scale);
								winningRecordDao.insert(winningRecord);
								// 将该奖池红包的剩余数量-1,并且将该红包的中奖数+1
								map.put("result", 1);
								map.put("type", Jackpot.TYPE_RED_PACKET);
								// map.put("data", getintegral + "金币和" + coupons + "代金券");
								map.put("data", getintegral + "金币");
								return map;
							}
						}else if(jackpot.getRelateType()==Jackpot.TYPE_AWARD){//奖品
							Award award=awardDao.selectByPrimaryKey(jackpot.getRelateId());
							if(award!=null){
								winningRecord.setSncode("");
								winningRecord.setRelateName(award.getName());
								winningRecordDao.insert(winningRecord);
							}
							// 将该奖池红包的剩余数量-1,并且将该红包的中奖数+1
							map.put("result", 1);
							map.put("type", Jackpot.TYPE_AWARD);
							map.put("data", award.getName());
							return map;
						}else{
							return null;//没有中奖
						}
					}
				}
			}else{
				map.put("result", -2);
				return map;//已抽奖(已使用)
			}
			
		} else {
			map.put("result", -1);
			return map;//不能抽奖,没有抽奖资格
		}
		return null;
	}
}
