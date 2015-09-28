create table t_cash_coupon(
	id varchar(40) primary key,
	user_id varchar(40) comment '用户ID',
	name varchar(40) comment '名称',
	vaild_start_time datetime comment '有效期开始时间',
	vaild_end_time datetime comment '有效期结束时间',
	use_condition int comment '使用条件(万元为单位)',
	money int comment '代金券金额(元为单位)',
	status int not null comment '状态0.未获取,1.以获取,2.已使用,3.已过期',
	readed int not null comment '查看状态0.未读,1.已读',
	use_time datetime comment '使用时间',
	product_id varchar(40) comment '产品ID(后期扩展)',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '代金券表';