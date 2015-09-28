package com.alidao.users.web.control;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alidao.jxe.control.WebCtrl;
import com.alidao.users.entity.UserHelper;
import com.alidao.users.service.UserHelperService;

@Controller
@RequestMapping("users/user/helper")
public class UserHelperCtrl extends WebCtrl {
	
	@Autowired
	private UserHelperService userHelperService;
	
	@RequestMapping("edit")
	public void edit(Model model) {
		List<UserHelper> list = userHelperService.list(null);
		model.addAttribute("list", list);
	}
	
	@RequestMapping("save")
	public void save(
			UserHelpListDataPackage data, 
			HttpServletResponse response) 
					throws Exception {
		for (UserHelper cell : data.getList()) {
			if (cell.getId() == null) {
				userHelperService.save(cell);
			} else {
				userHelperService.mdfy(cell);
			}
		}
		getResponse(1).jsonOut(response);
	}
	
}