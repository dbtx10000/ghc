create table t_signin_record(
	id varchar(40) primary key,
	user_id varchar(40) not null comment '用户Id',
	user_name varchar(40)  comment '用户名',
	integral int not null comment '金币数',
	create_time datetime not null comment '创建时间',
	update_time datetime not null comment '修改时间',
	state bool not null comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '签到记录表';

create table t_proverb(
	id varchar(40) primary key,
	content varchar(500) not null comment '内容',
	create_time datetime not null comment '创建时间',
	update_time datetime not null comment '修改时间',
	state bool not null comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '箴言表';