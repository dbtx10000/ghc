create table t_saler(
	id varchar(40) primary key,
	user_id varchar(40) comment '从哪个用户转变成销售用户的',
	status int comment '状态{1:未激活2:使用中3:已禁用}',
	mobile varchar(20) comment '绑定手机',
	username varchar(20) comment '登录名',
	password varchar(40) comment '登录密码{用SHA1加密}',
	realname varchar(20) comment '姓名',
	credentials_type varchar(40) comment '证件类型',
	credentials_code varchar(40) comment '证件号码',
	avatar varchar(255) comment '头像',
	email varchar(255) comment '邮箱',
	address varchar(255) comment '地址',
	intro varchar(255) comment '个人简介',
	user_count int comment '用户数',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '销售用户';

