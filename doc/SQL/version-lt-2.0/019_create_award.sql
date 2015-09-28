create table t_award(
	id varchar(40) primary key,
	name varchar(50) not null comment '奖品名称',
	count int not null comment '总数量',
	residue_count int not null comment '剩余数量',
	small_image varchar(255) comment '小图',
	big_image varchar(255) comment '大图',
	intro varchar(255) comment '奖品简介',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '奖品表';
