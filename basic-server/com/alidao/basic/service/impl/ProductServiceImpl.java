package com.alidao.basic.service.impl;

import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alidao.basic.dao4mybatis.OrderDao;
import com.alidao.basic.dao4mybatis.ProductDao;
import com.alidao.basic.dao4mybatis.ProductProjectDao;
import com.alidao.basic.dao4mybatis.ProductTypeDao;
import com.alidao.basic.entity.Order;
import com.alidao.basic.entity.Product;
import com.alidao.basic.entity.ProductProject;
import com.alidao.basic.service.ProductService;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.model.Condition;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

@Service
public class ProductServiceImpl implements ProductService {

	@Autowired
	private ProductDao productDao;

	@Autowired
	private ProductTypeDao productTypeDao;

	@Autowired
	private OrderDao orderDao;

	@Autowired
	private ProductProjectDao productProjectDao;

	public int save(Product object, String[] zdyname, String[] zdynote) {
		object.beforeInsert();
		int result = productDao.insert(object);
		if (zdyname != null && zdynote != null) {
			// 保存产品自定义项目信息
			for (int i = 0; i < zdynote.length; i++) {
				ProductProject productProject = new ProductProject();
				productProject.setProductId(object.getId());
				productProject.setName(zdyname[i]);
				productProject.setNote(zdynote[i]);
				productProjectDao.insert(productProject);
			}
		}
		return result;
	}

	public int mdfy(Product object, String[] zdyname, String[] zdynote) {
		int result = productDao.update(object);
		// 删除产品下所有的自定义项目
		ProductProject productProject = new ProductProject();
		productProject.setProductId(object.getId());
		productProjectDao.delete(productProject);
		if (zdyname != null && zdynote != null) {
			// 保存产品自定义项目信息
			for (int i = 0; i < zdynote.length; i++) {
				productProject = new ProductProject();
				productProject.setProductId(object.getId());
				productProject.setName(zdyname[i]);
				productProject.setNote(zdynote[i]);
				productProjectDao.insert(productProject);
			}
		}
		return result;
	}

	public int lose(String id) {
		return productDao.deleteByPrimaryKey(id);
	}

	public int lose(Product object) {
		return productDao.delete(object);
	}

	public Product find(String id) {
		Product product = productDao.selectByPrimaryKey(id);
		if (product != null) {
			information(product, false);
			// 关联自定义项目信息
			ProductProject cdt = new ProductProject();
			cdt.setProductId(product.getId());
			product.setProductProjects(
				productProjectDao.queryForList(cdt)
			);
		}
		return product;
	}

	public Product find(Product object) {
		return productDao.select(object);
	}

	public Page<Product> page(PageParam pageParam, Product object) {
		Page<Product> page = productDao.queryForPage(pageParam, object);
		List<Product> list = page.getTableList();
		for (int i = 0; list != null && i < list.size(); i++) {
			information(list.get(i), true);
		}
		return page;
	}
	
	public List<Product> list(Product object) {
		List<Product> list = productDao.queryForList(object);
		for (int i = 0; list != null && i < list.size(); i++) {
			information(list.get(i), true);
		}
		return list;
	}

	private void information(Product product, boolean parseHtml) {
		String intro = product.getIntro();
		if (StringUtil.isNotBlank(intro) && parseHtml) {
			intro = intro.replaceAll(" ", "&nbsp;");
			intro = intro.replaceAll("\r\n", "<br/>");
			intro = intro.replaceAll("\n\r", "<br/>");
			intro = intro.replaceAll("\n", "<br/>");
			intro = intro.replaceAll("\r", "<br/>");
			product.setIntro(intro);
		}
		// 关联产品分类信息
		product.setProductType(productTypeDao.selectByPrimaryKey(product.getTypeId()));
		// 判断状态
		Integer buyStatus = 1;	// 1:进行中
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date now = null;
		try {
			now = sdf.parse(sdf.format(new Date()));
		} catch (ParseException e) {
			throw new RuntimeException(e);
		}
		if (now.before(product.getSubscribeStartTime())) {
			buyStatus = 3;	// 未开始
		} else if (now.after(product.getSubscribeEndTime())) {
			buyStatus = 4;	// 已结束
		}
		parseStatus(product, now);
		// 关联订单信息
		Order order = new Order();
		order.setProductId(product.getId());
		// 排除订单状态为已关闭
		order.addCondition("status not in(2)", Condition.SEP_AND);
		List<Order> listOrder = orderDao.queryForList(order);
		if (listOrder != null && listOrder.size() > 0) {
			int allMoney = 0;
			boolean allpay = true;
			for (Order cell : listOrder) {	// 总投资额计算
				Integer investMoney = cell.getInvestMoney();
				if (product.getSmallProduct() == 0) {
					investMoney = investMoney / 10000;
				}
				allMoney += investMoney;
				if (allpay && cell.getStatus() != 1) {
					allpay = false;
				}
			}
			// 剩余可投
			product.setSurplusMoney(product.getTotalMoney() - allMoney);
			// 进度
			double progress = allMoney * 100.0 / product.getTotalMoney();
			// 进度满
			if (progress == 100) {
				if (allpay) {
					buyStatus = 4;	// 已结束
				} else {
					buyStatus = 2;	// 等待中
				}
			}
			NumberFormat df=NumberFormat.getNumberInstance() ;
			df.setMaximumFractionDigits(2);
			product.setProgress(df.format(progress) + "%");
			// 定购订单数
			product.setOrderCount(listOrder.size());
		} else {
			product.setSurplusMoney(product.getTotalMoney());	// 剩余可投
			product.setProgress("0%");	// 进度
			product.setOrderCount(0);	// 定购订单数
		}
		if (product.getControlStatus() == Product.CTRL_STAT_BUY_QUIT
				|| product.getControlStatus() == Product.CTRL_STAT_DUE_QUIT) {
			buyStatus = 4;	// 已结束
		}
		if (buyStatus == 3) {
			product.setProgress("0%");
		}
		if (buyStatus == 4) {
			product.setProgress("100%");
		}
		product.setBuyStatus(buyStatus);
	}

	private void parseStatus(Product product, Date now) {
		if (product.getSubscribeStartTime().getTime() > now.getTime()) {
			// 未开始认购，状态为未开始
			product.setStatus(0);// 未开始
		} else if (product.getSubscribeStartTime().getTime() <= now.getTime()
				&& product.getSubscribeEndTime().getTime() > now.getTime()) {
			// 认购时间正在进行中，状态为认购中
			product.setStatus(1);// 认购中
		} else {
			product.setStatus(3);// 已结束
		}
		/*
		else if (product.getIncomeStartTime().getTime() <= now.getTime()
				&& product.getIncomeEndTime().getTime() > now.getTime()) {
			// 收益时间正在进行中，状态为收益中
			product.setStatus(2);// 收益中
		} 
		*/ 
	}

}
