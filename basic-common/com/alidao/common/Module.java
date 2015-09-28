package com.alidao.common;

public enum Module {
	
	BASIC ( 
		1, 1, "基础模块", "basic", "com.alidao.basic", ""
	), WXAPI (
		2, 1, "微信模块", "wxapi", "com.alidao.wxapi", ""
	);
	
	/** 模块编号 **/
	private Integer mid;

	/** 模块版本 **/
	private Integer ver;
	
	/** 模块名称 **/
	private String name;
	
	/** 模块包名 **/
	private String pack;
	
	/** 模块路径 **/
	private String path;
	
	/** 模块简介 **/
	private String note;

	private Module(Integer mid, Integer ver, String name, String pack,
			String path, String note) {
		this(mid, ver, name, pack, path);
		this.note = note;
	}

	private Module(Integer mid, Integer ver, String name, String pack,
			String path) {
		this.mid = mid;
		this.ver = ver;
		this.name = name;
		this.pack = pack;
		this.path = path;
	}

	public Integer getMid() {
		return mid;
	}

	public void setMid(Integer mid) {
		this.mid = mid;
	}

	public Integer getVer() {
		return ver;
	}

	public void setVer(Integer ver) {
		this.ver = ver;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPack() {
		return pack;
	}

	public void setPack(String pack) {
		this.pack = pack;
	}
	
	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

}
