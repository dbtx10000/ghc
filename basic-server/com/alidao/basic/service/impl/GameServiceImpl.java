package com.alidao.basic.service.impl;

import java.util.List;
import java.util.UUID;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alidao.basic.dao4mybatis.FriendGameRecordDao;
import com.alidao.basic.dao4mybatis.GameBuyRecordDao;
import com.alidao.basic.dao4mybatis.GameDao;
import com.alidao.basic.dao4mybatis.GameRecordDao;
import com.alidao.basic.dao4mybatis.ProductDao;
import com.alidao.basic.entity.FriendGameRecord;
import com.alidao.basic.entity.Game;
import com.alidao.basic.entity.GameBuyRecord;
import com.alidao.basic.entity.GameRecord;
import com.alidao.basic.entity.Product;
import com.alidao.basic.service.GameService;
import com.alidao.common.Constants;
import com.alidao.jse.util.Crypto;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.model.Condition;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.users.dao4mybatis.UserDao;
import com.alidao.users.entity.User;
import com.alidao.wxapi.bean.TokenForWxapis;
import com.alidao.wxapi.bean.UserForWxUnion;
import com.alidao.wxapi.util.OpenidTracker;
import com.alidao.wxapi.util.WxapiUtil;

@Service
public class GameServiceImpl implements GameService {
	private Log log = LogFactory.getLog(this.getClass());
     @Autowired 
     private GameDao gameDao;

     @Autowired 
     private ProductDao productDao;

     @Autowired
     private GameBuyRecordDao gameBuyRecordDao;
     
     @Autowired
     private GameRecordDao gameRecordDao;
     
     @Autowired
     private FriendGameRecordDao friendGameRecordDao;
     
     @Autowired
     private UserDao userDao;
    public int save(Game object) {
    	if(!StringUtil.isEmpty(object.getProductId())){
    		String name = "";
    		for (String productId : object.getProductId().split(",")) {
    			Product product=productDao.selectByPrimaryKey(productId);
    			if (product != null) {
    				name += " + " + product.getName();
    			}
    		}
    		object.setName(name.substring(" + ".length()));
    	}
        return gameDao.insert(object);
    }

    public int save(List<Game> objects) {
        int result = 0;
        for (Game object : objects) {
            result &= gameDao.insert(object);
        }
        return result;
    }

    public int lose(String id) {
        return gameDao.deleteByPrimaryKey(id);
    }

    public int lose(Game object) {
        return gameDao.delete(object);
    }

    public int mdfy(Game object) {
        return gameDao.update(object);
    }

    public Game find(String id) {
        return gameDao.selectByPrimaryKey(id);
    }

    public Game find(Game object) {
        return gameDao.select(object);
    }

    public Page<Game> page(PageParam pageParam, Game object) {
        return gameDao.queryForPage(pageParam,object);
    }

    public List<Game> list(Game object) {
        return gameDao.queryForList(object);
    }

	public int submitScore(String userId, String id, String shareSn,Integer score) {
		String openId=OpenidTracker.get();
		String appid = Constants.get("wxapi.appid");
		String appsecret = Constants.get("wxapi.appsecret");
		if(!StringUtil.isEmpty(userId)){
			if(StringUtil.isEmpty(shareSn)){
				if(game(userId,id)){//可以提交
						GameRecord gameRecord=new GameRecord();
						gameRecord.setUserId(userId);
						gameRecord.setGameId(id);
						gameRecord=gameRecordDao.select(gameRecord);
						if(gameRecord==null){
							addBuyerGameRecord(id, userId, openId, score);
						}else{
							gameRecord.setScore(score);
							gameRecordDao.update(gameRecord);
						}
						return 1;//提交成功
				}else{
					return -1;//没有游戏提交资格  没有购买产品
				}
			}else{
				GameRecord gameRecord=new GameRecord();
				gameRecord.setGameId(id);
				gameRecord.setShareSn(shareSn);
				gameRecord=gameRecordDao.select(gameRecord);
				if(gameRecord!=null&&gameRecord.getUserId().equals(userId)){
					gameRecord.setScore(score);
					gameRecordDao.update(gameRecord);
					return 1;
				}else{
					return friendScore(shareSn, openId, score, appid, appsecret);
				}
			}
			
		}else{
			if(!StringUtil.isEmpty(shareSn)){
				return friendScore(shareSn, openId, score, appid, appsecret);
			}else{
				FriendGameRecord friendGameRecord=new FriendGameRecord();
				friendGameRecord.setOpenid(openId);
				friendGameRecord.setShareSn(shareSn);
				friendGameRecord=friendGameRecordDao.select(friendGameRecord);
				if(friendGameRecord==null){
					addFriendGameRecord( appid, appsecret, openId, shareSn, score);
				}else{
					friendGameRecord.setMaxScore(score);
					friendGameRecordDao.update(friendGameRecord);
				}
				return 0;//不能提交 userId和shareSn都为空
			}
		}
	}
	
	public GameRecord addBuyerGameRecord(String gameId,String userId,String openId,Integer score){
		String appId = Constants.get("wxapi.appid");
		String appsecret = Constants.get("wxapi.appsecret");
		GameRecord gameRecord=new GameRecord();
		User user=userDao.selectByPrimaryKey(userId);
		gameRecord.setGameId(gameId);
		gameRecord.setShareSn(Crypto.MD5(UUID.randomUUID().toString()));
		gameRecord.setUserId(userId);
		gameRecord.setScore(score);
		gameRecord.setFriendScore(0);
		gameRecord.setUserAccount(user.getMobile());
		gameRecord.setUserName(user.getRealname());
		gameRecord.setFriendCount(0);
		UserForWxUnion union=getUserForWxUnion(appId,appsecret,openId);
		gameRecord.setUserImage(union.getHeadimgurl());
		gameRecordDao.insert(gameRecord);//新增购买产品者游戏记录
		return gameRecord;
	}
	public boolean game(String userId,String gameId){
		Game game=gameDao.selectByPrimaryKey(gameId);
		String productId=game.getProductId();
		GameBuyRecord gameBuyRecord=new GameBuyRecord();
		gameBuyRecord.setUserId(userId);
		gameBuyRecord.addOrderBy("status");
		String ids = "";
		for (String productid : productId.split(",")) {
			ids += ",'" + productid + "'";
		}
		ids = "(" + ids.substring(1) + ")";
		gameBuyRecord.addCondition("product_id", Condition.CDT_IN, ids, Condition.SEP_AND);
		List<GameBuyRecord> list=gameBuyRecordDao.queryForList(gameBuyRecord);
		return list!=null&&list.size()>0;
	}
	public int friendScore(String shareSn,String openId,Integer score,String appid,String appsecret){
		FriendGameRecord friendGameRecord=new FriendGameRecord();
		friendGameRecord.setShareSn(shareSn);
		friendGameRecord.setOpenid(openId);
		friendGameRecord=friendGameRecordDao.select(friendGameRecord);
		if(friendGameRecord==null){
			GameRecord record=new GameRecord();
			record.setShareSn(shareSn);
			record=gameRecordDao.select(record);
			record.setFriendScore(record.getFriendScore()+score);
			record.setFriendCount(record.getFriendCount()+1);
			gameRecordDao.update(record);//更改游戏分享者分数
			addFriendGameRecord( appid, appsecret, openId, shareSn, score);//增加亲友团游戏记录
			return 1;
		}else{
			friendGameRecord.setMaxScore(score);
			friendGameRecordDao.update(friendGameRecord);
			return -2;//已经帮朋友提交分数
		}
	}
	/**
	 * 增加亲友团游戏记录
	 * @param friendGameRecord
	 * @param appId
	 * @param appsecret
	 * @param openId
	 * @param shareSn
	 * @param score
	 */
	public void addFriendGameRecord(String appId,String appsecret,String openId,String shareSn,Integer score){
		FriendGameRecord friendGameRecord=new FriendGameRecord ();
		friendGameRecord.setShareSn(shareSn);
		UserForWxUnion union=getUserForWxUnion(appId,appsecret,openId);
		if(!StringUtil.isEmpty(union.getNickname())){
			friendGameRecord.setWxnickname(union.getNickname());
		}else{                                   
			friendGameRecord.setWxnickname("");
		}
		friendGameRecord.setHeadImage(union.getHeadimgurl());
		friendGameRecord.setOpenid(openId);
		friendGameRecord.setScore(score);
		friendGameRecord.setMaxScore(score);
		friendGameRecordDao.insert(friendGameRecord);
	}
	public UserForWxUnion getUserForWxUnion(String appId,String appsecret,String openId){
		TokenForWxapis token;
		UserForWxUnion union = new UserForWxUnion();
		try {
			token = WxapiUtil.
					getWxapisToken(appId, appsecret);
			String access_token = token.getAccess_token();
			union = WxapiUtil.
					getWxUnionUser(access_token, openId);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
		return union;
	}
}