create table t_user(
	id varchar(40) primary key,
	pid varchar(40) comment '父ID,即该用户的邀请用户',
	type int comment '类型{1.VIP用户,2.普通用户,3.销售员}',
	source int comment '用户来源{1.App,2.微信,3.Wap,4.PC,5.后台}',
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
	integral int comment '当前积分',
	assets int comment '总资产unit(w)',
	income decimal(11,2) comment '总收益unit(y)',
	orders int comment '订单数',
	friend int comment '好友数',
	pay_password varchar(40) comment '支付密码',
	touchs_password varchar(40) comment '手势密码',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '系统用户表';

create table t_user_bind(
	id bigint primary key auto_increment, 
	user_id varchar(40) comment '用户ID',
	account varchar(40) comment '第三方账号',
	account_type int comment '第三方账号类型{1.微信}',
	session_key varchar(40) comment '登录凭证',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '用户绑定第三方账户表';

create table t_user_helper(
	id bigint primary key auto_increment, 
	user_type int comment '用户类型{1.VIP用户,2.普通用户,3.销售员}',
	type_name varchar(20) comment '用户类型{1.VIP用户,2.普通用户,3.销售员}',
	detail text comment '展示细节',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '用户帮助表';

insert into t_user_helper(id,user_type,type_name,detail,create_user,create_time,update_user,update_time,state) values(1,1,'VIP用户','','c4ca4238a0b923820dcc509a6f75849b',now(),'c4ca4238a0b923820dcc509a6f75849b',now(),1);
insert into t_user_helper(id,user_type,type_name,detail,create_user,create_time,update_user,update_time,state) values(2,2,'普通用户','','c4ca4238a0b923820dcc509a6f75849b',now(),'c4ca4238a0b923820dcc509a6f75849b',now(),1);
insert into t_user_helper(id,user_type,type_name,detail,create_user,create_time,update_user,update_time,state) values(3,3,'销售人员','','c4ca4238a0b923820dcc509a6f75849b',now(),'c4ca4238a0b923820dcc509a6f75849b',now(),1);

create table t_user_invest(
	id bigint primary key auto_increment, 
	user_id varchar(40) comment '用户ID',
	product_id varchar(40) comment '产品ID',
	product_name varchar(50) comment '产品名称',
	income decimal(11,2) comment '预期年化收益',
	income_float int not null comment '是否浮动收益',
	income_start_time datetime comment '收益开始时间',
	income_end_time datetime comment '收益结束时间',
	invest_money int comment '投资金额unit(w)',
	income_money int comment '收益金额unit(y)',
	invest_time datetime comment '投资时间',
	status int comment '状态{1.申请中,2.持有中,3.已结束}',
	source int comment '来源{1.下单/2.添加}',
	readed int comment '是否已查看',
	order_id varchar(40) comment '订单ID',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '投资记录表';

create table t_user_integral(
	id bigint primary key auto_increment,
	user_id varchar(40) comment '关联用户ID',
	type int comment '记录类型{1:被邀注册(+积分),2:邀请注册(+积分)}',
	integral int comment '积分数量',
	status int comment '记录状态',
	relate varchar(40) comment '被用户或邀请用户ID',
	note varchar(255) comment '备注',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '用户积分记录表';