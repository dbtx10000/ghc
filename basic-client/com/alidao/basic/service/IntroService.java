package com.alidao.basic.service;

import java.util.List;

import com.alidao.basic.entity.Intro;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

public interface IntroService {

	public abstract int save(Intro object);
	
	public abstract int mdfy(Intro object);
	
	public abstract int lose(Long id);
	
	public abstract int lose(Intro object);
	
	public abstract Intro find(Long id);
	
	public abstract Intro find(Intro object);
	
	public abstract Page<Intro> page(PageParam pageParam, Intro object);
	
	public abstract List<Intro> list(Intro object);
	
}
