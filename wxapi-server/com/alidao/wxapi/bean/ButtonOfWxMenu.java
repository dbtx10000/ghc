package com.alidao.wxapi.bean;

import java.util.List;

public class ButtonOfWxMenu {

	private String type;
	
	private String name;
	
	private String key;
	
	private String url;
	
	private List<ButtonOfWxMenu> sub_button;

	public ButtonOfWxMenu(String type, String name, String key, String url) {
		this.type = type;
		this.name = name;
		if ("click".equals(this.type)) {
			this.key = key;
		} else if ("view".equals(this.type)) {
			this.url = url;
		}
	}

	public ButtonOfWxMenu(String name,
			List<ButtonOfWxMenu> sub_button) {
		this.name = name;
		this.sub_button = sub_button;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}
	
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public List<ButtonOfWxMenu> getSub_button() {
		return sub_button;
	}

	public void setSub_button(List<ButtonOfWxMenu> sub_button) {
		this.sub_button = sub_button;
	}

}
