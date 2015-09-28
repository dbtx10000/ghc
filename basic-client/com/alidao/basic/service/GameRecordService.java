package com.alidao.basic.service;

import java.util.List;

import com.alidao.basic.entity.GameRecord;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

public interface GameRecordService {

    public  abstract int save(GameRecord object);

    public  abstract int save(List<GameRecord> objects);

    public  abstract int lose(String id);

    public  abstract int lose(GameRecord object);

    public  abstract int mdfy(GameRecord object);

    public  abstract GameRecord find(String id);

    public  abstract GameRecord find(GameRecord object);

    public  abstract Page<GameRecord> page(PageParam pageParam, GameRecord object);

    public  abstract List<GameRecord> list(GameRecord object);
}