package com.alidao.basic.service;

import com.alidao.basic.entity.Game;
import com.alidao.basic.entity.GameRecord;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;

public interface GameService {

    public  abstract int save(Game object);

    public  abstract int save(List<Game> objects);

    public  abstract int lose(String id);

    public  abstract int lose(Game object);

    public  abstract int mdfy(Game object);

    public  abstract Game find(String id);

    public  abstract Game find(Game object);

    public  abstract Page<Game> page(PageParam pageParam, Game object);

    public  abstract List<Game> list(Game object);
    /** 提交分数 **/
	public abstract int submitScore(String userId, String id, String shareSn,Integer score);
	/**是否购买产品**/
	public abstract boolean game(String userId,String gameId);
	/**增加购买产品者游戏记录**/
	public abstract GameRecord addBuyerGameRecord(String gameId,String userId,String openId,Integer score);
}