DROP TABLE t_user_risk_evaluation;
create table t_user_risk_evaluation(
	id varchar(40) primary key,
	user_id varchar(40) not null comment '用户Id',
    score int not null comment '分数',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '用户风险评测表';