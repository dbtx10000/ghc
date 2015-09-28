create table t_buy_product_record(
	id varchar(40) primary key,
	user_id varchar(40) not null comment '用户Id',
	product_id varchar(40) not null comment '产品ID',
	sncode varchar(40) not null comment 'SN码',
	status int not null comment '使用状态{0.未使用,1.已使用}',
	readed int not null comment '是否已读{0.未读,1.已读}',
	create_time datetime not null comment '创建时间',
	update_time datetime not null comment '修改时间',
	state bool not null comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '购买产品记录表';