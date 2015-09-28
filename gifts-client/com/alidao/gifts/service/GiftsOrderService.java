package com.alidao.gifts.service;

import java.util.List;

import com.alidao.gifts.entity.GiftsOrder;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

public interface GiftsOrderService {

    public abstract int save(GiftsOrder object);

    public abstract int save(List<GiftsOrder> objects);

    public abstract int lose(Long id);

    public abstract int lose(GiftsOrder object);

    public abstract int mdfy(GiftsOrder object);

    public abstract GiftsOrder find(Long id);

    public abstract GiftsOrder find(GiftsOrder object);

    public abstract Page<GiftsOrder> page(PageParam pageParam, GiftsOrder object);

    public abstract List<GiftsOrder> list(GiftsOrder object);

	public abstract int ibuy(GiftsOrder object);
	
	public abstract int icls(Long id);
    
}