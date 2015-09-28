package com.alidao.basic.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alidao.basic.dao4mybatis.ProductTypeDao;
import com.alidao.basic.entity.Product;
import com.alidao.basic.entity.ProductType;
import com.alidao.basic.service.ProductService;
import com.alidao.basic.service.ProductTypeService;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

@Service
public class ProductTypeServiceImpl implements ProductTypeService {

	@Autowired
	private ProductTypeDao productTypeDao;
	
	@Autowired
	private ProductService productService;
	
	public int save(ProductType object) {
		return productTypeDao.insert(object);
	}
	
	public int mdfy(ProductType object) {
		return productTypeDao.update(object);
	}

	public int lose(String id) {
		return productTypeDao.deleteByPrimaryKey(id);
	}

	public int lose(ProductType object) {
		return productTypeDao.delete(object);
	}
	
	public ProductType find(String id) {
		return productTypeDao.selectByPrimaryKey(id);
	}

	public ProductType find(ProductType object) {
		return productTypeDao.select(object);
	}

	public Page<ProductType> page(PageParam pageParam, ProductType object) {
		Page<ProductType> page = productTypeDao.queryForPage(pageParam, object);
		List<ProductType> list = page.getTableList();
		for (int i = 0; list != null && i < list.size(); i++) {	
			ProductType productType = list.get(i);
			//计算产品数量
			Product product = new Product();
			product.setTypeId(productType.getId());
			List<Product> products = productService.list(product);
			Long count = 0L;
			if (products != null && products.size() > 0) {
				for (Product cell : products) {
					if (cell.getBuyStatus() != 4) {
						count ++;
					}
				}
			}
			productType.setProductCount(count);
		}
		return page;
	}

	public List<ProductType> list(ProductType object) {
		List<ProductType> list = productTypeDao.queryForList(object);
		for (int i = 0; list != null && i < list.size(); i++) {	
			ProductType productType = list.get(i);
			String note = productType.getNote();
			if (StringUtil.isNotBlank(note)) {
				note = note.replaceAll("\r\n", "<br>");
				note = note.replaceAll("\n\r", "<br>");
				note = note.replaceAll("\n", "<br>");
				note = note.replaceAll("\r", "<br>");
				productType.setNote(note);
			}
			//计算产品数量
			Product product = new Product();
			product.setTypeId(productType.getId());
			List<Product> products = productService.list(product);
			Long count = 0L;
			if (products != null && products.size() > 0) {
				for (Product cell : products) {
					if (cell.getBuyStatus() != 4) {
						count ++;
					}
				}
			}
			productType.setProductCount(count);
		}
		return list;
	}
}
