package com.alidao.gifts.service.impl;

import com.alidao.basic.dao4mybatis.ProductDao;
import com.alidao.basic.dao4mybatis.ProductTypeDao;
import com.alidao.basic.entity.Product;
import com.alidao.basic.entity.ProductType;
import com.alidao.gifts.dao4mybatis.JackpotDao;
import com.alidao.gifts.dao4mybatis.JackpotTypeDao;
import com.alidao.gifts.entity.Jackpot;
import com.alidao.gifts.entity.JackpotType;
import com.alidao.gifts.service.JackpotService;
import com.alidao.gifts.service.JackpotTypeService;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class JackpotTypeServiceImpl implements JackpotTypeService {

     @Autowired 
     private JackpotTypeDao jackpotTypeDao;

     @Autowired 
     private ProductDao productDao;
     
     @Autowired
 	 private ProductTypeDao productTypeDao;
     
     @Autowired
     private JackpotDao jackpotDao;
     @Autowired
     private JackpotService jackpotService;
    public int save(JackpotType object) {
    	object.beforeInsert();
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
        return jackpotTypeDao.insert(object);
    }

    public int save(List<JackpotType> objects) {
        int result = 0;
        for (JackpotType object : objects) {
            result &= jackpotTypeDao.insert(object);
        }
        return result;
    }

    public int lose(String id) {
    	JackpotType jackpotType=jackpotTypeDao.selectByPrimaryKey(id);
    	Jackpot jackpot=new Jackpot();   
    	jackpot.setProductId(jackpotType.getProductId());
    	List<Jackpot> list=jackpotDao.queryForList(jackpot);
		for(Jackpot object:list){
			jackpotService.lose(object);
    	}
    	return jackpotTypeDao.deleteByPrimaryKey(id);
    }

    public int lose(JackpotType object) {
        return jackpotTypeDao.delete(object);
    }

    public int mdfy(JackpotType object) {
    	if(!StringUtil.isEmpty(object.getProductId())){
    		Product product=productDao.selectByPrimaryKey(object.getProductId());
    		if(product!=null){
    			object.setName(product.getName());
    		}
    	}
        return jackpotTypeDao.update(object);
    }

    public JackpotType find(String id) {
        return jackpotTypeDao.selectByPrimaryKey(id);
    }

    public JackpotType find(JackpotType object) {
        return jackpotTypeDao.select(object);
    }

    public Page<JackpotType> page(PageParam pageParam, JackpotType object) {
        return jackpotTypeDao.queryForPage(pageParam,object);
    }

    public List<JackpotType> list(JackpotType object) {
        return jackpotTypeDao.queryForList(object);
    }

	public List<ProductType> productTypeList(ProductType object) {
		 return productTypeDao.queryForList(object);
	}

	public List<Product> productList(Product object) {
		 return productDao.queryForList(object);
	}
}