package com.alidao.gifts.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alidao.gifts.dao4mybatis.RedPacketDao;
import com.alidao.gifts.entity.RedPacket;
import com.alidao.gifts.service.RedPacketService;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

@Service
public class RedPacketServiceImpl implements RedPacketService {

     @Autowired 
     private RedPacketDao redPacketDao;
    public int save(RedPacket object) {
        return redPacketDao.insert(object);
    }

    public int save(List<RedPacket> objects) {
        int result = 0;
        for (RedPacket object : objects) {
            result &= redPacketDao.insert(object);
        }
        return result;
    }

    public int lose(RedPacket object) {
        return redPacketDao.delete(object);
    }

    public int mdfy(RedPacket object) {
        return redPacketDao.update(object);
    }

    public RedPacket find(RedPacket object) {
        return redPacketDao.select(object);
    }

    public Page<RedPacket> page(PageParam pageParam, RedPacket object) {
        return redPacketDao.queryForPage(pageParam,object);
    }

    public List<RedPacket> list(RedPacket object) {
        return redPacketDao.queryForList(object);
    }
    
    public RedPacket find(String id) {
        return redPacketDao.selectByPrimaryKey(id);
    }
    
    public int lose(String id) {
        return redPacketDao.deleteByPrimaryKey(id);
    }
    
    public int checkWhetherExist(Integer integral) {
		RedPacket redPacket=new RedPacket();
		redPacket.setIntegral(integral);
		redPacket=redPacketDao.select(redPacket);
		if(redPacket!=null&&redPacket.getId()!=null){
			return 0;
		}else{
			return 1;
		}
	}
}