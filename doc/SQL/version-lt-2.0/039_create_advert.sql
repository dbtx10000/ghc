create table t_advert(
	id varchar(40) primary key,
	position int not null comment '广告位{1首页}',
	image varchar(255) not null comment '广告封面图',
	type int not null comment '广告类型{1.外链，2.图文}',
	creater_id varchar(100) not null comment '创建者ID',
	title varchar(50) comment '广告标题',
	content text comment '广告详细内容',
	relate_id bigint comment '外部关联ID',
	url varchar(255) comment '链接',
	hot bool not null comment '是否推荐',
	top bool not null comment '是否置顶',
	weight bigint not null comment '排序标号',
	create_time datetime not null comment '创建时间',
	update_time datetime not null comment '修改时间',
	state bool not null comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '广告表';