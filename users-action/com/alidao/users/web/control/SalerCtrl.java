package com.alidao.users.web.control;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import com.alidao.basic.service.CashCouponService;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.control.WebCtrl;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.jxe.util.HttpUtil;
import com.alidao.users.entity.Saler;
import com.alidao.users.entity.User;
import com.alidao.users.entity.UserInvest;
import com.alidao.users.service.SalerService;
import com.alidao.users.service.UserIntegralService;
import com.alidao.users.service.UserInvestService;
import com.alidao.users.service.UserService;

@Controller
@RequestMapping("saler")
public class SalerCtrl extends WebCtrl {
	
	@Autowired
	private SalerService salerService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private UserIntegralService userIntegralService;
	
	@Autowired
	private CashCouponService cashCouponService;
	
	@Autowired
	private UserInvestService userInvestService;

	
	@RequestMapping("init")
	public void init(HttpServletRequest request,Model model) {
		String lctx = HttpUtil.getWebAppUrl(request);
		model.addAttribute("lctx", lctx);
	}
	
	@RequestMapping("input")
	public void input(Model model, String id) {
		if (StringUtil.isNotBlank(id)) {
			model.addAttribute("object", salerService.find(id));
		}
	}
	
	@RequestMapping("page")
	public void page(PageParam pageParam, Saler object,
			HttpServletResponse response) throws Exception {
		Page<Saler> page = salerService.page(pageParam, object);
		page.jsonOut(response);
	}
	
	/**
	 * VIP类型用户
	 */
	@RequestMapping("page/vip")
	public void pageVip(PageParam pageParam, User object,
			HttpServletResponse response) throws Exception {
		object.addCondition("and is_saler is null ");
		object.setStatus(User.STATUS_NORMAL);
		Page<User> page = userService.page(pageParam, object);
		List<User> list = page.getTableList();
		for (int i = 0; list != null && i < list.size(); i++) {
			String userId = list.get(i).getId();
			list.get(i).setIntegral(userIntegralService.getMyVaildIntegral(userId, null));
			list.get(i).setIncome(calcCurrMoney(userId));
			list.get(i).setCashCoupons(cashCouponService.getCashCoupons(userId));
			if (StringUtil.isNotBlank(list.get(i).getPid())) {
				User parent = userService.find(list.get(i).getPid());
				if (parent != null) {
					list.get(i).setParentName(parent.getRealname());
				}
			}
		}
		page.jsonOut(response);
	}
	
	
	private double calcCurrMoney(String userId) {
		// 获取已结束投资的收益
		Double gsum = userInvestService.gsum(userId, UserInvest.STATUS_HAS_OVER);
		UserInvest inv_cdt = new UserInvest();
		inv_cdt.setUserId(userId);
		inv_cdt.setStatus(UserInvest.STATUS_HOLD_ING);
		List<UserInvest> list = userInvestService.list(inv_cdt);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Long nowtime = 0L;
		Double cisum = 0D;
		try {
			nowtime = sdf.parse(sdf.format(new Date())).getTime();
		} catch (ParseException e) {
			throw new RuntimeException(e);
		}
		for (int i = 0; list != null && i < list.size(); i++) {
			UserInvest cell = list.get(i);
			Long time = nowtime - cell.getIncomeStartTime().getTime();
			int days = (int) ((time) / (24 * 60 * 60 * 1000)) + 1;
			cisum += days * cell.calcDayIncomeMoney();
		}
		return gsum + cisum;
	}
	
	
	@RequestMapping("edit")
	public void edit(String id, Model model) {
		if (StringUtil.isNotBlank(id)) {
			Saler object = salerService.find(id);
			model.addAttribute("object", object);
		}
	}
	
	
	@RequestMapping("save")
	public void save(Saler object, 
			HttpServletResponse response) 
					throws Exception {
		getResponse(
				salerService.mdfy(object)
		).jsonOut(response);
	}
	
	
	@RequestMapping("lose/{id}")
	public void lose(
			@PathVariable("id") String id, 
			HttpServletResponse response) 
					throws Exception {
		getResponse(
			salerService.loseBusiness(id)
		).jsonOut(response);
	}
	
	
	@RequestMapping("add")
	public String add() {
		return "saler/userInit";
	}
	
	
	/**
	 * VIP用户成为销售用户
	 */
	@RequestMapping("beSaler")
	public void beSaler(HttpServletResponse response,String userId)
					throws Exception {
		getResponse(salerService.beSaler(userId)).jsonOut(response);
	}
	
	
}
