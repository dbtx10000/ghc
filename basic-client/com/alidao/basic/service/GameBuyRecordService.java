package com.alidao.basic.service;

import java.util.List;

import com.alidao.basic.entity.GameBuyRecord;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

public interface GameBuyRecordService {

    public  abstract int save(GameBuyRecord object);

    public  abstract int save(List<GameBuyRecord> objects);

    public  abstract int lose(String id);

    public  abstract int lose(GameBuyRecord object);

    public  abstract int mdfy(GameBuyRecord object);

    public  abstract GameBuyRecord find(String id);

    public  abstract GameBuyRecord find(GameBuyRecord object);

    public  abstract Page<GameBuyRecord> page(PageParam pageParam, GameBuyRecord object);

    public  abstract List<GameBuyRecord> list(GameBuyRecord object);
}