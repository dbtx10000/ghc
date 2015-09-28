package com.alidao.gifts.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alidao.gifts.dao4mybatis.GiftsOrderDao;
import com.alidao.gifts.entity.GiftsOrder;
import com.alidao.gifts.entity.Igift;
import com.alidao.gifts.service.GiftsOrderService;
import com.alidao.gifts.service.IgiftService;
import com.alidao.jse.util.DateUtil;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.model.Condition;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.users.authorizing.UseridTracker;
import com.alidao.users.entity.UserIntegral;
import com.alidao.users.service.UserIntegralService;

@Service
public class GiftsOrderServiceImpl implements GiftsOrderService {

    @Autowired 
    private GiftsOrderDao giftsOrderDao;
    
    @Autowired
    private UserIntegralService userIntegralService;
    
    @Autowired
    private IgiftService igiftService;

    public int save(GiftsOrder object) {
    	Igift gift = new Igift();
    	gift.setId(object.getGiftId());
    	gift.setTradenum(0 + object.getNums());
    	gift.setStocknum(0 - object.getNums());
    	igiftService.plus(gift);
        return giftsOrderDao.insert(object);
    }

    public int save(List<GiftsOrder> objects) {
        int result = 0;
        for (GiftsOrder object : objects) {
            result &= giftsOrderDao.insert(object);
        }
        return result;
    }

    public int lose(Long id) {
        return giftsOrderDao.deleteByPrimaryKey(id);
    }

    public int lose(GiftsOrder object) {
        return giftsOrderDao.delete(object);
    }

    public int mdfy(GiftsOrder object) {
        return giftsOrderDao.update(object);
    }

    public GiftsOrder find(Long id) {
        return giftsOrderDao.selectByPrimaryKey(id);
    }

    public GiftsOrder find(GiftsOrder object) {
        return giftsOrderDao.select(object);
    }

    public Page<GiftsOrder> page(PageParam pageParam, GiftsOrder object) {
        return giftsOrderDao.queryForPage(pageParam,object);
    }

    public List<GiftsOrder> list(GiftsOrder object) {
        return giftsOrderDao.queryForList(object);
    }

	public int ibuy(GiftsOrder object) {
		//修改用户积分数
		UserIntegral userIntegralParam = new UserIntegral();
		userIntegralParam.setUserId(UseridTracker.get());
		String date = "'" + DateUtil.formatDate(new Date(), "yyyy-MM-dd") + "'";
		userIntegralParam.addCondition("vaild_end_time", ">=", date, Condition.SEP_AND);
		userIntegralParam.addCondition("sell_integral > 0", Condition.SEP_AND);
		userIntegralParam.addOrderBy("vaild_end_time", false);//过期时间正序
		List<UserIntegral> list = userIntegralService.list(userIntegralParam);
		String sourceIds = "";
		Integer integral = object.getIntegral();
		for (UserIntegral userIntegral : list) {
			sourceIds += userIntegral.getId() + ",";
			//突然不想写modifyCount方法。用修改方法算了
			if (integral >= userIntegral.getSellIntegral()) {
				integral -= userIntegral.getSellIntegral();
				userIntegral.setSellIntegral(0);
				userIntegralService.mdfy(userIntegral);
			} else {
				userIntegral.setSellIntegral(userIntegral.getSellIntegral() - integral);
				userIntegralService.mdfy(userIntegral);
				break;
			}
		}
		if (StringUtil.isNotBlank(sourceIds)) {
			int index = sourceIds.length() - 1;
			sourceIds = sourceIds.substring(0, index);
		}
		object.setIntegralSourceId(sourceIds);
		return save(object);
	}
	
	public int icls(Long id) {
		GiftsOrder order = find(id);
		if (order != null) {
			Integer integral = order.getIntegral();
			//返还用户抵扣积分数
			UserIntegral cdt = new UserIntegral();
			cdt.addCondition("id in (" + order.getIntegralSourceId() + ")", Condition.SEP_AND);
			List<UserIntegral> list = userIntegralService.list(cdt);
			for (UserIntegral cell : list) {
				if (integral >= cell.getIntegral()) {
					integral -= cell.getIntegral();
					cell.setSellIntegral(cell.getIntegral());
					userIntegralService.mdfy(cell);
				} else {
					cell.setSellIntegral(cell.getSellIntegral() + integral);
					userIntegralService.mdfy(cell);
				}
			}
			order.setStatus(GiftsOrder.CLOSED);
			Igift gift = new Igift();
			gift.setId(order.getGiftId());
			gift.setTradenum(0 - order.getNums());
	    	gift.setStocknum(0 + order.getNums());
			igiftService.plus(gift);
			return mdfy(order);
		} else {
			return 0;
		}
	}

}