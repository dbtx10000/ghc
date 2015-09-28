set names gbk;

use db_ghc;

create table t_balance (
	id bigint primary key auto_increment,
	user_id varchar(40) comment '用户ID',
	total_balance decimal(11,2) comment '总共余额',
	freezing_balance decimal(11,2) comment '冻结(处理中)余额',
	surplus_balance decimal(11,2) comment '剩余(可用)余额',
	last_modify bigint comment '最后余额更新时间',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '余额表';

create table t_balance_record (
	id bigint primary key auto_increment,
	user_id varchar(40) comment '用户ID',
	username varchar(20) comment '用户账号',
	realname varchar(20) comment '用户姓名',
	type int comment '类型{1.充值,2.提现,3.收款(收益),4.收款(本金),5.认购产品(使用余额,引起余额变动)}',
	money decimal(11,2) comment '变化金额',
	status int comment '状态{1.提交申请,2.处理中(较少出现),3.处理成功,4.处理失败}',
	note varchar(100) comment '备注信息',
	before_balance decimal(11,2) comment '处理前的余额',
	after_balance decimal(11,2) comment '处理后的余额',
	
	relate_id varchar(40) comment '关联ID(当前为产品ID)',
	relate_name varchar(100) comment '关联名称(当前为产品名称)',
	
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '余额记录表';

create table t_withdrawals (
	id bigint primary key auto_increment,
	user_id varchar(40) comment '用户ID',
	username varchar(20) comment '用户账号',
	realname varchar(20) comment '用户姓名',
	money decimal(11,2) comment '提现金额',
	status int comment '状态{1.提交申请,2.处理中(较少出现),3.处理成功,4.处理失败}',
	note varchar(100) comment '备注信息',
	before_balance decimal(11,2) comment '处理前的余额',
	after_balance decimal(11,2) comment '处理后的余额',
	serial varchar(20) comment '系统流水号',
	
	open_bank_id varchar(50) comment '开户行ID',
	open_bank_name varchar(50) comment '开户行名称',
	bank_card_no varchar(50) comment '银行卡号',
	bank_cert_id varchar(50) comment '证件号',
	bank_user_name varchar(20) comment '开户人',
	bank_cert_type varchar(20) comment '证件类型',
	bank_user_prov varchar(50) comment '开户人地址(省)',
	bank_user_city varchar(50) comment '开户人地址(市)',
	
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '提现表';

create table t_withdrawals_detail (
	id bigint primary key auto_increment,
	withdrawals_id bigint comment '提现记录ID',
	status int comment '状态{1.申请处理,2.处理中(较少出现),3.处理成功,4.处理失败}',
	note varchar(100) comment '备注(记录处理过程中的一些信息)',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '提现细节表';

create table t_recharge (
	id bigint primary key auto_increment,
	user_id varchar(40) comment '用户ID',
	username varchar(20) comment '用户账号',
	realname varchar(20) comment '用户姓名',
	money decimal(11,2) comment '提现金额',
	status int comment '状态{1.提交申请,2.处理中(较少出现),3.处理成功,4.处理失败}',
	note varchar(100) comment '备注信息',
	before_balance decimal(11,2) comment '处理前的余额',
	after_balance decimal(11,2) comment '处理后的余额',
	serial varchar(20) comment '系统流水号',
	
	open_bank_id varchar(50) comment '开户行ID',
	open_bank_name varchar(50) comment '开户行名称',
	bank_card_no varchar(50) comment '银行卡号',
	bank_user_name varchar(20) comment '开户人',
	bank_cert_id varchar(50) comment '证件号',
	bank_cert_type varchar(20) comment '证件类型',
	bank_user_prov varchar(50) comment '开户人地址(省)',
	bank_user_city varchar(50) comment '开户人地址(市)',
	
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '充值表';

create table t_recharge_detail (
	id bigint primary key auto_increment,
	recharge_id bigint comment '充值记录ID',
	status int comment '状态{1.申请处理,2.处理中(较少出现),3.处理成功,4.处理失败}',
	note varchar(100) comment '备注(记录处理过程中的一些信息)',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '充值细节表';

create table t_card_bind_record (
	id bigint primary key auto_increment,
	user_id varchar(40) comment '用户ID',
	username varchar(40) comment '用户名称',
	realname varchar(40) comment '用户姓名',
	serial varchar(40) comment '开户流水号',
	mobile varchar(20) comment '预留手机号',
	gender varchar(20) comment '开户人性别',
	user_name varchar(20) comment '开户人',
	cert_type varchar(20) comment '证件类型',
	cert_id varchar(50) comment '证件号',
	card_no varchar(50) comment '银行卡号',
	open_bank_id varchar(50) comment '开户行ID',
	open_bank_name varchar(50) comment '开户行名称',
	status int comment '状态{1.绑卡,2.解绑}',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '绑定银行卡记录';

create table t_card_bind_record_detail (
	id bigint primary key auto_increment,
	card_bind_record_id bigint comment '绑卡ID',
	status int comment '状态{11.提交绑定,12.绑定成功,13.绑定失败|21.提交解绑,22.解绑成功,23.解绑失败}',
	note varchar(100) comment '备注信息',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '绑定银行卡详细记录';