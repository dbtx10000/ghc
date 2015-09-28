package com.alidao.gifts.web.control;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alidao.basic.entity.Product;
import com.alidao.gifts.entity.JackpotType;
import com.alidao.gifts.service.JackpotTypeService;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.control.WebCtrl;
import com.alidao.jxe.model.Condition;
import com.alidao.jxe.model.PageParam;
import com.alidao.jxe.util.HttpUtil;

@Controller
@RequestMapping("jackpotType")
public class JackpotTypeCtrl extends WebCtrl {

	@Autowired
	private JackpotTypeService jackpotTypeService;
	
	@RequestMapping("init")
	public void init(HttpServletRequest request, Model model) {
		model.addAttribute("webapp", HttpUtil.getWebAppUrl(request));
	}

	@RequestMapping("page")
	public void page(JackpotType object,  
			PageParam pageParam, HttpServletResponse response) throws Exception {
		jackpotTypeService.page(pageParam, object).jsonOut(response);
	}


	@RequestMapping("input")
	public void edit(String id, Model model) {
//		List<ProductType> productTypeList=jackpotTypeService.productTypeList(null);
//		List<Product> productList=jackpotTypeService.productList(null);
//		if (id != null) {
//			JackpotType object = jackpotTypeService.find(id);
//			model.addAttribute("object", object);
//			if(object!=null&&object.getProductId()!=null){
//				Product product=productService.find(object.getProductId());
//				ProductType productType=product.getProductType();
//				model.addAttribute("productType", productType);
//			}
//		}
//		model.addAttribute("productTypeList", productTypeList);
//		model.addAttribute("productList", productList);
		List<Product> list = jackpotTypeService.productList(null);
		List<Product> result = new ArrayList<Product>();
		for (int i = 0; list != null && i < list.size(); i++) {
			JackpotType object = new JackpotType();
			object.addCondition("product_id", 
					Condition.CDT_LIKE, ("'%" + list.get(i).getId() + "%'"), 
					Condition.SEP_AND);
			object = jackpotTypeService.find(object);
			if (object == null) {
				result.add(list.get(i));
			}
		}
		model.addAttribute("productList", result);
	}

	@RequestMapping("save")
	public void save(
			HttpServletResponse response, 
			JackpotType object)
			throws Exception {
		if (StringUtil.isEmpty(object.getId())) {
			getResponse(
				jackpotTypeService.save(object)
			).jsonOut(response);
		} else {
			getResponse(
				jackpotTypeService.mdfy(object)
			).jsonOut(response);
		}
	}
	
	@RequestMapping("lose/{id}")
	public void lose(
			@PathVariable("id") String id, 
			HttpServletResponse response)
			throws Exception {
		getResponse(
			jackpotTypeService.lose(id)
		).jsonOut(response);
	}
	
	/**
	 * 根据产品类型Id查询产品列表
	 * @param id
	 * @param out
	 * @throws IOException
	 */
	@RequestMapping("productListByProductTypeId")
	public void productListByPartnerId(String productTypeId, 
			HttpServletResponse response) throws IOException {
		Product object = new Product();
		List<JackpotType> list=jackpotTypeService.list(null);
		String productId = "";
		if (list != null && list.size() > 0) {
			productId += "'";
			for (JackpotType jackpotType : list) {
				productId += jackpotType.getProductId();
				productId += "','";
			}
			productId = productId.substring(0, productId.length() - 2);
		}
		if(!StringUtil.isEmpty(productTypeId)){
			object.setTypeId(productTypeId);
		}
		if(!StringUtil.isEmpty(productId)){
			object.addCondition("id not in("+productId+")", Condition.SEP_AND);
		}
		getQueryResponse(
				jackpotTypeService.productList(object)
			).jsonOut(response);
	}
}
