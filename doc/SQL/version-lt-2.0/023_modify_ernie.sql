ALTER TABLE t_jackpot ADD (product_id varchar(1000) not null comment '产品Id');
ALTER TABLE t_jackpot MODIFY jackpot_type int  comment '奖池类型';
create table t_jackpot_type(
	id varchar(40) primary key,
	product_id varchar(1000) not null comment '产品Id',
    name varchar(40) comment '产品名称',
    jackpot_count int not null comment '奖品数量',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '奖池类型表';