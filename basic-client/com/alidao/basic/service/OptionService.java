package com.alidao.basic.service;

import com.alidao.basic.entity.Option;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;

public interface OptionService {

    public  abstract int save(Option object);

    public  abstract int save(List<Option> objects);

    public  abstract int lose(String id);

    public  abstract int lose(Option object);

    public  abstract int mdfy(Option object);

    public  abstract Option find(String id);

    public  abstract Option find(Option object);

    public  abstract Page<Option> page(PageParam pageParam, Option object);

    public  abstract List<Option> list(Option object);
}