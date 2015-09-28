create table t_const(
	id bigint primary key auto_increment,
	regis_integral int comment 'A，本人成功注册',
	buy_integral int comment 'B，本人注册并认购缴款',
	invite_integral int comment 'C，邀请他人注册',
	invite_buy_integral int comment 'D，邀请他们注册且该人认购成功缴款',
	buy_integral_limit int comment '本人注册并认购缴款得积分次数限制',
	invite_integral_limit int comment '邀请得积分次数限制',
	invite_buy_integral_limit int comment '邀请人成功缴款得积分次数限制',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '配置表';

insert into t_const(id,regis_integral, buy_integral, invite_integral, invite_buy_integral, buy_integral_limit, invite_integral_limit, invite_buy_integral_limit, create_user,create_time,update_user,update_time,state) values(1,0,0,0,0,0,0,0,'c4ca4238a0b923820dcc509a6f75849b',now(),'c4ca4238a0b923820dcc509a6f75849b',now(),1);

create table t_intro(
	id bigint primary key auto_increment,
	invite text comment '邀请配置',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '用户收益记录表';

insert into t_intro(id,invite,create_user,create_time,update_user,update_time,state) values(1,'','c4ca4238a0b923820dcc509a6f75849b',now(),'c4ca4238a0b923820dcc509a6f75849b',now(),1);