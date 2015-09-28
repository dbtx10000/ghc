package com.alidao.basic.service;

import java.util.List;

import com.alidao.basic.entity.Order;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

public interface OrderService {

	/** 添加 **/
	public abstract int save(Order object);
	
	/** 修改 **/
	public abstract int mdfy(Order object) throws Exception ;
	
	/** 删除 **/
	public abstract int lose(String id);
	
	/** 删除 **/
	public abstract int lose(Order object);
	
	/** 查找 **/
	public abstract Order find(String id);
	
	/** 查找 **/
	public abstract Order find(Order object);
	
	/** 分页 **/
	public abstract Page<Order> page(PageParam pageParam, Order object);
	
	/** 列举 **/
	public abstract List<Order> list(Order object);
	
	/** WAP普通产品下单 **/
	public abstract int wapOrder(Order object, String fcode, Integer useIntegral, String cashId, Integer cashMoney);
	
	/** WAP特权本金下单 **/
	public abstract int specialOrder(Order object,  Integer useIntegral);
	
	/** 每天下午5.30定时关闭等待支付的订单,供定时器调用 **/
	public abstract void closeDaily();
	
	/** 每天下午5.30定时关闭等待支付的订单,供定时器调用 **/
	public abstract void closeQuart();
	
	/** 金币抵扣 **/
	public abstract int useIntegral(String orderId, Integer useIntegral);
	
}
