package com.alidao.basic.service;

import java.util.List;

import com.alidao.basic.entity.SmsBlack;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

public interface SmsBlackService {

    public  abstract int save(SmsBlack object);

    public  abstract int save(List<SmsBlack> objects);

    public  abstract int lose(Long id);

    public  abstract int lose(SmsBlack object);

    public  abstract int mdfy(SmsBlack object);

    public  abstract SmsBlack find(Long id);

    public  abstract SmsBlack find(SmsBlack object);

    public  abstract Page<SmsBlack> page(PageParam pageParam, SmsBlack object);

    public  abstract List<SmsBlack> list(SmsBlack object);
    
}