package com.alidao.gifts.web.control;

import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alidao.gifts.entity.GiftsOrder;
import com.alidao.gifts.service.GiftsOrderService;
import com.alidao.jxe.control.WebCtrl;
import com.alidao.jxe.model.Condition;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.utils.XlsUtil;

@Controller
@RequestMapping("gifts/order")
public class GiftsOrderCtrl extends WebCtrl {

	@Autowired
	private GiftsOrderService giftsOrderService;
	
	@RequestMapping("init")
	public void init() {}

	@RequestMapping("page")
	public void page(PageParam pageParam, 
			GiftsOrder object, HttpServletResponse response,Date startDate,Date endDate) 
					throws Exception {
		SimpleDateFormat simple=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(startDate != null){
			object.addCondition("create_time >= '" + simple.format(startDate) + "'", Condition.SEP_AND);
		}
		if(endDate != null){
			object.addCondition("create_time <= '" + simple.format(endDate) + "'", Condition.SEP_AND);
		}
		giftsOrderService.page(pageParam, object).jsonOut(response);
	}

	@RequestMapping("list")
	public void list(GiftsOrder object, 
			HttpServletResponse response)
			throws Exception {
		getQueryResponse(
			giftsOrderService.list(object)
		).jsonOut(response);
	}

	@RequestMapping("edit")
	public void edit(Long id, Model model) {
		if (id != null) {
			GiftsOrder object = giftsOrderService.find(id);
			model.addAttribute("object", object);
		}
	}

	@RequestMapping("save")
	public void save(
			HttpServletResponse response, 
			GiftsOrder object)
			throws Exception {
		if (object.getId() == null) {
			getResponse(
				giftsOrderService.save(object)
			).jsonOut(response);
		} else {
			getResponse(
				giftsOrderService.mdfy(object)
			).jsonOut(response);
		}
	}
	
	@RequestMapping("show")
	public void show(Long id, Model model) {
		if (id != null) {
			GiftsOrder object = giftsOrderService.find(id);
			model.addAttribute("object", object);
		}
	}

	@RequestMapping("icls/{id}")
	public void icls(
			@PathVariable("id") Long id, 
			HttpServletResponse response) 
			throws IOException {
		getResponse(
			giftsOrderService.icls(id)
		).jsonOut(response);
	}
	
	@RequestMapping("lose/{id}")
	public void lose(
			@PathVariable("id") Long id, 
			HttpServletResponse response)
			throws Exception {
		getResponse(
			giftsOrderService.lose(id)
		).jsonOut(response);
	}
	
	/**
	 * 导出
	 * @param request
	 * @param pageParam
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("export")
	public void export(HttpServletRequest request, PageParam pageParam, 
			GiftsOrder object, Date startDate,Date endDate,HttpServletResponse response) throws Exception {
		SimpleDateFormat simple=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(startDate != null){
			object.addCondition("create_time >= '" + simple.format(startDate) + "'", Condition.SEP_AND);
		}
		if(endDate != null){
			object.addCondition("create_time <= '" + simple.format(endDate) + "'", Condition.SEP_AND);
		}
		OutputStream os = response.getOutputStream();
		
		pageParam.setPageSize(60000L);// 统计的最大数量
		Page<GiftsOrder> page = giftsOrderService.page(pageParam, object);
		String[] statOfLine = new String[1];// 统计结果行
		statOfLine[0] = "订单总计：" + page.getPageParam().getTotalCount() + "个";
		
		String[] srr = null;
		String[] heads = new String[17];
		List res = new ArrayList();
		int count = 0;
		if (page.getTableList() != null) {
			for (GiftsOrder order : page.getTableList()) {
				srr = new String[17];// 显示17个用户的字段
				setData(srr, order);// 数据赋值
				if (count == 0) {
					// 第一行中文备注只需赋值一次即可
					setHead(heads);
				}
				res.add(srr);
				count ++;
			}
		}
		res.add(statOfLine);// 加入统计结果
		XlsUtil.setHead("订单导出结果.xls", response);
		try {
			XlsUtil.downXlsData(heads,res,os);
		} finally {
			if (null != os) {
				os.flush();
				os.close();
				os = null;
			}
		}
	}
	
	public void setData(String[] srr, GiftsOrder order) {
		srr[0] = order.getOrderNo(); // 订单号
		srr[1] = order.getGiftname(); // 礼品名称
		srr[2] = order.getGifttype() == 1 ? "实物" : "电子券"; // 礼品类型
		srr[3] = order.getNums() + ""; // 兑换数量
		srr[4] = order.getIntegral() + ""; // 兑换积分
		srr[5] = order.getUsername(); // 用户账号
		srr[6] = order.getRealname(); // 真实姓名
		srr[7] = order.getMobile(); // 联系方式
		if (order.getGifttype() == 1) {	// 订单状态
			if (order.getStatus() == GiftsOrder.UN_DELIVER) {
				srr[8] = "未发货";
			} else if (order.getStatus() == GiftsOrder.DELIVER_ED) {
				srr[8] = "已发货";
			} else if (order.getStatus() == GiftsOrder.RECEIVE_ED) {
				srr[8] = "已收货";
			} else {
				srr[8] = "已关闭";
			}
		} else {
			if (order.getStatus() == GiftsOrder.UN_USE) {
				srr[8] = "未使用";
			} else if (order.getStatus() == GiftsOrder.USE_ED) {
				srr[8] = "已使用";
			} else {
				srr[8] = "已关闭";
			}
		}
		srr[9] = order.getAddress(); // 收货地址
		srr[10] = order.getNote() == null ? "" : order.getNote(); // 备注
	}
	
	public void setHead(String[] srr) {
		srr[0] = "订单号";
		srr[1] = "礼品名称";
		srr[2] = "礼品类型";
		srr[3] = "兑换数量";
		srr[4] = "兑换积分";
		srr[5] = "用户账号";
		srr[6] = "真实姓名";
		srr[7] = "联系方式";
		srr[8] = "订单状态";
		srr[9] = "收货地址";
		srr[10] = "备注";
	}
	
}
