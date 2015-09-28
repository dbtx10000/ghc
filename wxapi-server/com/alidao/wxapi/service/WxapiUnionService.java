package com.alidao.wxapi.service;

import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.wxapi.bean.UserForWxUnion;
import java.util.List;

public interface WxapiUnionService {

    public  abstract int save(UserForWxUnion object);

    public  abstract int save(List<UserForWxUnion> objects);

    public  abstract int lose(Long id);

    public  abstract int lose(UserForWxUnion object);

    public  abstract int mdfy(UserForWxUnion object);

    public  abstract UserForWxUnion find(Long id);

    public  abstract UserForWxUnion find(UserForWxUnion object);

    public  abstract Page<UserForWxUnion> page(PageParam pageParam, UserForWxUnion object);

    public  abstract List<UserForWxUnion> list(UserForWxUnion object);
}