package com.alidao.wxapi.bean;

import java.util.List;

public class CustomMenuOfWx {
	
	private List<ButtonOfWxMenu> button;
	
	public CustomMenuOfWx(List<ButtonOfWxMenu> button){
		this.button = button;
	}

	public List<ButtonOfWxMenu> getButton() {
		return button;
	}

	public void setButton(List<ButtonOfWxMenu> button) {
		this.button = button;
	}
	
}
