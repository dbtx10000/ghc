package com.alidao.basic.entity;

import com.alidao.jxe.model.SpkModel;

/**
 * 广告实体类
 */
public class Advert extends SpkModel {
	
	private static final long serialVersionUID = 1L;
	
	/** 外链 **/
	public static final int TYPE_URL = 1;
	/** 图文 **/
	public static final int TYPE_NEWS = 2;
	
	/** 首页 **/
	public static final int POSITION_TYPE_INDEX = 1;

    private Integer position;

    private String image;

    private Integer type;

    private String createrId;
    
    private String title;

    private Long relateId;

    private String url;

    private String content;
    
    private Object creater;

	public String getCreaterId() {
		return createrId;
	}


	public Integer getPosition() {
        return position;
    }

    public void setPosition(Integer position) {
        this.position = position;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image == null ? null : image.trim();
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public void setCreaterId(String createrId) {
		this.createrId = createrId;
	}

    
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Long getRelateId() {
        return relateId;
    }

    public void setRelateId(Long relateId) {
        this.relateId = relateId;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
    
    public Object getCreater() {
		return creater;
	}

	public void setCreater(Object creater) {
		this.creater = creater;
	}
	
}