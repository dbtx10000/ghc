create table t_card_bind(
	id bigint primary key auto_increment,
	user_id varchar(40) comment '用户ID',
	serial varchar(40) comment '开户流水号',
	mobile varchar(20) comment '预留手机号',
	gender varchar(20) comment '开户人性别',
	user_name varchar(20) comment '开户人',
	cert_type varchar(20) comment '证件类型',
	cert_id varchar(50) comment '证件号',
	card_no varchar(50) comment '银行卡号',
	open_bank_id varchar(50) comment '开户行ID',
	open_bank_name varchar(50) comment '开户行名称',
	status int comment '状态{1.已绑定,0.未绑定}',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '绑定银行卡';