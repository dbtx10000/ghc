package com.alidao.gifts.service;

import java.util.List;

import com.alidao.gifts.entity.GiftsOrder;
import com.alidao.gifts.entity.RedPacket;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;


public interface RedPacketService {

    public  abstract int save(RedPacket object);

    public  abstract int save(List<RedPacket> objects);

    public  abstract int lose(RedPacket object);

    public  abstract int mdfy(RedPacket object);

    public  abstract RedPacket find(RedPacket object);

    public  abstract Page<RedPacket> page(PageParam pageParam, RedPacket object);

    public  abstract List<RedPacket> list(RedPacket object);
    
    public abstract RedPacket find(String id);
    
    public abstract int lose(String id);
    
    public  abstract int checkWhetherExist(Integer integral);
}