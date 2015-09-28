package com.alidao.basic.service;

import com.alidao.basic.entity.Topic;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;

public interface TopicService {

    public  abstract int save(Topic object,String [] ordinal,String [] optionName,Integer [] optionSeq);

    public  abstract int save(List<Topic> objects);

    public  abstract int lose(String id);

    public  abstract int lose(Topic object);

    public  abstract int mdfy(Topic object,String [] ordinal,String [] optionName,Integer [] optionSeq);

    public  abstract Topic find(String id);

    public  abstract Topic find(Topic object);

    public  abstract Page<Topic> page(PageParam pageParam, Topic object);

    public  abstract List<Topic> list(Topic object);
}