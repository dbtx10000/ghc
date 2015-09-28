package com.alidao.gifts.wap.control;

import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alidao.gifts.entity.GiftsOrder;
import com.alidao.gifts.entity.Igift;
import com.alidao.gifts.service.GiftsOrderService;
import com.alidao.gifts.service.IgiftService;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.control.WebCtrl;
import com.alidao.jxe.help.PowerHelper;
import com.alidao.jxe.model.ResponseForAjax;
import com.alidao.users.authorizing.UseridTracker;
import com.alidao.users.entity.User;
import com.alidao.users.service.UserIntegralService;
import com.alidao.users.service.UserService;
import com.alidao.wxapi.util.OpenidTracker;
import com.alidao.wxapi.util.WxapiUtil;

@Controller
@RequestMapping("wap/igift")
public class IgiftWapCtrl extends WebCtrl {
	
	@Autowired
	private IgiftService igiftService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private UserIntegralService userIntegralService;
	
	@Autowired
	private GiftsOrderService giftsOrderService;
	
	@RequestMapping("list")
	public void list(Model model) {
		Igift object = new Igift();
		object.addOrderBy("weight");
		// object.addCondition("start_time", Igift.CDT_LT_EQ, "now()", Igift.SEP_AND);
		// object.addCondition("end_time", Igift.CDT_GT_EQ, "now()", Igift.SEP_AND);
		List<Igift> list = igiftService.list(object);
		model.addAttribute("list", list);
	}
	
	@RequestMapping("cell")
	public void cell(String id, HttpServletRequest request, Model model) {
		Igift object = igiftService.find(id);
		model.addAttribute("object", object);
		Integer stocknum = object.getStocknum();
		Integer status = 1;
		String button = "立即换购";
		Integer number = 0;
		String intro = object.getIntro();
		String notes = object.getNotes();
		if (StringUtil.isNotBlank(intro)) {
			intro = intro.replaceAll("\r\n", "<br>");
			intro = intro.replaceAll("\n\r", "<br>");
			intro = intro.replaceAll("\n", "<br>");
			intro = intro.replaceAll("\r", "<br>");
			object.setIntro(intro);
		}
		if (StringUtil.isNotBlank(notes)) {
			notes = notes.replaceAll("\r\n", "<br>");
			notes = notes.replaceAll("\n\r", "<br>");
			notes = notes.replaceAll("\n", "<br>");
			notes = notes.replaceAll("\r", "<br>");
			object.setNotes(notes);
		}
		Date start = object.getStartTime();
		Date now = new Date();
		Date end = object.getEndTime();
		if (now.before(start)) {
			status = 0;
			button = "未到换购时间";
		} else {
			if (now.after(end)) {
				status = 0;
				button = "已过换购时间";
			} else {
				if (stocknum > 0) {
					User user = null;
					if (WxapiUtil.fromMicBrowser(request)) {
						String openid = OpenidTracker.get();
						user = userService.find(openid, User.BINDED_WECHAT);
					} else {
						String userid = PowerHelper.get();
						if (StringUtil.isNotBlank(userid)) {
							user = userService.find(userid);
						}
					}
					if (user != null) {
						Integer integral = userIntegralService.
								getMyVaildIntegral(user.getId(), null);
						if (integral >= object.getIntegral()) {
							GiftsOrder order = new GiftsOrder();
							order.setGiftId(id);
							order.setUserId(user.getId());
							order.addCondition(
									"status", GiftsOrder.CDT_UN_EQ, 
									"0", GiftsOrder.SEP_AND);
							Integer limit = object.getLimitnum();
							if (limit != null) {
								List<GiftsOrder> list = giftsOrderService.list(order);
								if (list != null) {
									for (GiftsOrder cell : list) {
										number += cell.getNums();
									}
									if (number >= limit) {
										status = 0;
										button = "已到限购个数";
									}
									number = limit - number;
									number = number < 0 ? 0 : number;
								}
							}
						} else {
							status = 0;
							button = "剩余金币不足";
						}
					}
				} else {
					status = 0;
					button = "礼品库存不足";
				}
			}
		}
		model.addAttribute("status", status);
		model.addAttribute("button", button);
		model.addAttribute("number", number);
	}
	
	@RequestMapping("gthis")
	public void get(String id, Integer nums, Model model) {
		model.addAttribute("gift", igiftService.find(id));
		User user = userService.find(UseridTracker.get());
		model.addAttribute("user", user);
		model.addAttribute("nums", nums);
	}
	
	@RequestMapping("gsure")
	public void sure(String giftId, Integer nums,
			String note, String address, Model model) {
		model.addAttribute("gift", igiftService.find(giftId));
		User user = userService.find(UseridTracker.get());
		String mobile = user.getMobile();
		String prefix = mobile.substring(0, 3);
		String suffix = mobile.substring(7);
		user.setMobile(prefix + "****" + suffix);
		model.addAttribute("user", user);
		model.addAttribute("address", address);
		model.addAttribute("nums", nums);
		model.addAttribute("note", note);
	}
	
	@RequestMapping("check")
	public void check(String giftId, Integer nums,
			HttpServletResponse response) throws Exception {
		ResponseForAjax resp = new ResponseForAjax();
		Igift gift = igiftService.find(giftId);
		Integer stocknum = gift.getStocknum();
		Date start = gift.getStartTime();
		Date now = new Date();
		Date end = gift.getEndTime();
		if (now.before(start)) {
			resp.setResult(0);
			resp.setMessage("未到换购时间");
		} else {
			if (now.after(end)) {
				resp.setResult(0);
				resp.setMessage("已过换购时间");
			} else {
				if (stocknum >= nums) {
					Integer integral = userIntegralService.
							getMyVaildIntegral(UseridTracker.get(), null);
					if (integral >= gift.getIntegral() * nums) {
						GiftsOrder order = new GiftsOrder();
						order.setGiftId(giftId);
						order.setUserId(UseridTracker.get());
						order.addCondition(
								"status", GiftsOrder.CDT_UN_EQ, 
								"0", GiftsOrder.SEP_AND);
						Boolean is_in_limit = true;
						Integer limit = gift.getLimitnum();
						if (limit != null) {
							List<GiftsOrder> list = giftsOrderService.list(order);
							if (list != null) {
								Integer count = 0;
								for (GiftsOrder cell : list) {
									count += cell.getNums();
								}
								if (count >= limit) {
									is_in_limit = false;
								}
							}
						}
						if (is_in_limit) {
							resp.setResult(1);
						} else {
							resp.setResult(0);
							resp.setMessage("已到限购次数");
						}
					} else {
						resp.setResult(0);
						resp.setMessage("剩余金币不足");
					}
				} else {
					resp.setResult(0);
					resp.setMessage("礼品库存不足");
				}
			}
		}
		resp.jsonOut(response);
	}
	
	@RequestMapping("order")
	public void order(String giftId, Integer nums,
			String note, String address, HttpServletResponse response) 
					throws Exception {
		ResponseForAjax resp = new ResponseForAjax();
		Igift gift = new Igift();
		gift.setId(giftId);
		gift.addCondition("start_time", Igift.CDT_LT_EQ, "now()", Igift.SEP_AND);
		gift.addCondition("end_time", Igift.CDT_GT_EQ, "now()", Igift.SEP_AND);
		gift = igiftService.find(gift);
		if (gift != null) {
			Integer stocknum = gift.getStocknum();
			if (stocknum >= nums) {
				Integer integral = userIntegralService.
						getMyVaildIntegral(UseridTracker.get(), null);
				if (integral >= gift.getIntegral() * nums) {
					GiftsOrder order = new GiftsOrder();
					order.setGiftId(giftId);
					order.setUserId(UseridTracker.get());
					order.addCondition(
							"status", GiftsOrder.CDT_UN_EQ, 
							"0", GiftsOrder.SEP_AND);
					Boolean is_in_limit = true;
					Integer limit = gift.getLimitnum();
					if (limit != null) {
						List<GiftsOrder> list = giftsOrderService.list(order);
						if (list != null) {
							Integer count = 0;
							for (GiftsOrder cell : list) {
								count += cell.getNums();
							}
							if (count >= limit) {
								is_in_limit = false;
							}
						}
					}
					if (is_in_limit) {
						order.setAddress(address);
						order.setNote(note);
						order.setNums(nums);
						if (gift.getType() == Igift.TYPE_MAT) {
							order.setStatus(GiftsOrder.UN_DELIVER);
						} else {
							order.setStatus(GiftsOrder.UN_USE);
						}
						order.setIntegral(gift.getIntegral() * nums);
						Random random = new Random();
						String serial = StringUtil.genMsecSerial();
						serial = serial.substring(2) + random.nextInt(10);
						order.setOrderNo(serial);
						// 补充信息(礼品)
						order.setGiftname(gift.getName());
						order.setGifttype(gift.getType());
						order.setImages(gift.getSmallImage());
						// 补充信息(用户)
						User user = userService.find(UseridTracker.get());
						order.setUsername(user.getUsername());
						order.setRealname(user.getRealname());
						order.setMobile(user.getMobile());
						giftsOrderService.ibuy(order);
						resp.setResult(1);
						resp.setMessage("金币换购成功");
					} else {
						resp.setResult(0);
						resp.setMessage("已到限购次数");
					}
				} else {
					resp.setResult(0);
					resp.setMessage("剩余金币不足");
				}
			} else {
				resp.setResult(0);
				resp.setMessage("礼品库存不足");
			}
		} else {
			resp.setResult(0);
			resp.setMessage("礼品不存在或已下架");
		}
		resp.jsonOut(response);
	}
	
}
