create table t_product (
	id varchar(40) primary key,
	name varchar(50) not null comment '产品名称',
	buy_type int not null comment '购买方式1.开放购买2.F码购买',
	control_status int not null comment '控制状态{1.开放认购,2.关闭认购,3.到期退出}',
	type_id varchar(40) not null comment '产品分类ID',
	income_start_time datetime not null comment '收益开始时间',
	income_end_time datetime not null comment '收益结束时间',
	subscribe_start_time datetime not null comment '认购开始时间',
	subscribe_end_time datetime not null comment '认购结束时间',
	logo varchar(255) comment '产品图片',
	total_money int not null comment '总金额(万元单位)',
	income decimal(11,2) not null comment '年化收益率',
	income_float int not null comment '是否浮动收益',
	fling_money int not null comment '起投金额(万元单位)',
	increase_money int not null comment '每人最大递增金额(万元单位)',
	max_money int not null comment '最大金额(万元单位)',
	expect_income varchar(50) comment '预期年化收益',
	expect_income_show int not null comment '预期年化收益是否显示0.显示，1.不显示',
	allot_type varchar(50) comment '收益分配方式',
	allot_type_show int not null comment '收益分配方式是否显示0.显示，1.不显示',
	start_time varchar(50) comment '起息日',
	start_time_show int not null comment '起息日是否显示0.显示，1.不显示',
	end_time varchar(50) comment '期限',
	end_time_show int not null comment '期限是否显示0.显示，1.不显示',
	bank_name varchar(50) not null comment '开户行',
	account_name varchar(50) not null comment '账户名称',
	account varchar(255) not null comment '账户',
	integral int comment '购买可得积分',
	intro varchar(255) comment '产品简介',
	product_note text comment '产品介绍',
	allot_note text comment '分配计划',
	contract_note text comment '电子合同',
	contract_time datetime comment '默认合同签订日期',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '产品表';

create table t_product_project (
	id varchar(40) primary key,
	product_id varchar(40) not null comment '产品ID',
	name varchar(50) not null comment '自定义名称',
	note varchar(255) not null comment '自定义内容',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '产品项目表';

create table t_product_type (
	id varchar(40) primary key,
	name varchar(50) not null comment '分类名称',
	logo varchar(255) comment '分类图片',
	seq int comment '分类排序',
	note varchar(255) comment '分类简介',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '产品分类表';

create table t_fcode (
	id varchar(40) primary key,
	fcode varchar(40) not null comment 'F码',
	end_time datetime not null comment '有效期截至时间',
	status int not null comment '状态0.未使用，1.已使用',
	user_id varchar(40) comment '用户ID',
	product_id varchar(40) comment '产品ID',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment 'F码表';

create table t_order(
	id varchar(40) primary key,
	user_id varchar(40) not null comment '用户ID',
	user_username varchar(40) comment '用户帐号',
	user_linkman varchar(20) comment '联系用户名称',
	user_contact varchar(20) comment '用户联系方式',
	product_id varchar(40) not null comment '产品ID',
	invest_money int not null comment '投资金额(万元单位)',
	pay_type int comment '支付类型{1.支付宝WAP支付，2.支付宝快捷支付，3.微信支付，4.银联支付，5.积分支付，6线下支付}',
	serial_no varchar(255) comment '流水号',
	status int not null comment '状态{-1.等待支付，0.支付定金，1.支付成功，2.已关闭}',
	pay_time datetime comment '付款时间',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '订单表';

alter table t_order add column cmer_id varchar(40) comment '商户ID';
alter table t_order add column card_no varchar(40) comment '支付卡号';
alter table t_order add column open_bank_id varchar(40) comment '开户行';
alter table t_order add column user_name varchar(40) comment '开户行';
alter table t_order add column cert_type varchar(40) comment '证件类型';
alter table t_order add column cert_id varchar(40) comment '证件号码';