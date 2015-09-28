create table t_holiday(
	id varchar(40) primary key,
    name varchar(200) comment '名称',
    start_time datetime comment '开始时间',
    end_time datetime comment '结束时间',
    year int comment '哪一年',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '假期表';