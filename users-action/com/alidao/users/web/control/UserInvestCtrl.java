package com.alidao.users.web.control;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alidao.basic.entity.Order;
import com.alidao.basic.entity.Product;
import com.alidao.basic.service.OrderService;
import com.alidao.basic.service.ProductService;
import com.alidao.jxe.control.WebCtrl;
import com.alidao.jxe.model.Condition;
import com.alidao.jxe.model.PageParam;
import com.alidao.users.entity.User;
import com.alidao.users.entity.UserInvest;
import com.alidao.users.service.UserInvestService;
import com.alidao.users.service.UserService;

@Controller
@RequestMapping("users/user/invest")
public class UserInvestCtrl extends WebCtrl {

	@Autowired
	private ProductService productService;
	
	@Autowired
	private UserInvestService userInvestService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private OrderService orderService;
	@RequestMapping("init/{userId}")
	public String init(
			@PathVariable("userId") String userId,
			Model model) {
		User user = userService.find(userId);
		model.addAttribute("user", user);
		return "users/user/invest/init";
	}
	
	@RequestMapping("page")
	public void page(
			PageParam pageParam, 
			UserInvest object, 
			HttpServletResponse response) 
					throws Exception {
		userInvestService.page(
			pageParam, object
		).jsonOut(response);
	}
	
	@RequestMapping("list")
	public void list(
			UserInvest object, 
			HttpServletResponse response) 
					throws Exception {
		getQueryResponse(
			userInvestService.list(object)
		).jsonOut(response);
	}
	
	@RequestMapping("edit/{userId}")
	public String edit(
			@PathVariable("userId") String userId, Long id, Model model) {
		User user = userService.find(userId);
		model.addAttribute("user", user);
		Product product=new Product();
		product.addCondition("subscribe_end_time > now()", Condition.SEP_AND);
		product.addCondition("control_status=1", Condition.SEP_AND);
		List<Product> list = productService.list(product);
		List<Product> products = new ArrayList<Product>();
		for(Product object:list){
			Order order = new Order();
			order.setProductId(object.getId());
			order.addCondition("status not in(2)", Condition.SEP_AND);
			List<Order> listOrder = orderService.list(order);
			if (listOrder != null && listOrder.size() > 0) {
				int allMoney = 0;
				for (Order cell : listOrder) {
					Integer investMoney = cell.getInvestMoney();
					if (object.getSmallProduct() == 0) {
						investMoney = investMoney / 10000;
					}
					allMoney += investMoney;
				}
				if (object.getTotalMoney() - allMoney > 0){
					products.add(object);
				}
			}
		}
		model.addAttribute("products", products);
		if (id != null) {
			UserInvest object = userInvestService.find(id);
			model.addAttribute("object", object);
		}
		return "users/user/invest/edit";
	}
	
	@RequestMapping("save")
	public void save(UserInvest object, 
			HttpServletResponse response) throws Exception {
		String productId = object.getProductId();
		Product product = productService.find(productId);
		object.setProductName(product.getName());
		object.setIncome(product.getIncome());
		object.setIncomeFloat(product.getIncomeFloat());
		object.setSource(UserInvest.SOURCE_INPUT);
		object.setIncomeType(product.getIncomeType());
		object.setIncomeDays(product.getIncomeDays());
		object.setIncomeStartTime(product.getIncomeStartTime());
		object.setIncomeEndTime(product.getIncomeEndTime());
		if (product.getIncomeType() == Product.INCOME_TYPE_FLOAT) {
			if (object.getStatus() != UserInvest.STATUS_APPLY_ED) {
				Integer incomeDays = product.getIncomeDays();
				Date now = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				try {
					now = sdf.parse(sdf.format(now));
				} catch (ParseException e) {
					throw new RuntimeException(e);
				}
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(now);
				calendar.add(Calendar.DAY_OF_YEAR, 1);
				object.setIncomeStartTime(calendar.getTime());
				calendar.setTime(now);
				calendar.add(Calendar.DAY_OF_YEAR, incomeDays);
				object.setIncomeEndTime(calendar.getTime());
			}
		}
		int result = 0;
		if (object.getId() == null) {
			result = userInvestService.save(object);
		} else {
			result = userInvestService.mdfy(object);
		}
		getResponse(result).jsonOut(response);
	}
	
	@RequestMapping("lose/{id}")
	public void lose(
			@PathVariable("id") Long id, 
			HttpServletResponse response) 
					throws Exception {
		getResponse(
			userInvestService.lose(id)
		).jsonOut(response);
	}
	
}