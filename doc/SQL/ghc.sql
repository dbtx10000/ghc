set names gbk;

use db_ghc;

create table t_questionnaire(
	id varchar(40) primary key,
	title varchar(40) not null comment '问卷标题',
	image varchar(250)  comment 'logo图片',
	topic_count int comment '题目数',
	user_count int comment '参与调查人数',
	create_time datetime not null comment '创建时间',
	update_time datetime not null comment '修改时间',
	state bool not null comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '问卷调查表';

create table t_topic(
	id varchar(40) primary key,
	questionnaire_id varchar(40) not null comment '问卷Id',
	name varchar(100) not null comment '题目名称',
	seq int comment '排序',
	create_time datetime not null comment '创建时间',
	update_time datetime not null comment '修改时间',
	state bool not null comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '题目表';

create table t_option(
	id varchar(40) primary key,
	topic_id varchar(40) not null comment '题目Id',
	ordinal varchar(40) not null comment '选项序号{ABCD/1234}',
	name varchar(100) not null comment '选项名称{答案}',
	seq int comment '排序',
	create_time datetime not null comment '创建时间',
	update_time datetime not null comment '修改时间',
	state bool not null comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '选项表';

create table t_questionnaire_record(
	id varchar(40) primary key,
	questionnaire_id varchar(40) not null comment '问卷Id',
	questionnaire_title varchar(40) not null comment '问卷标题',
	topic_id varchar(40) not null comment '题目Id',
	topic_name varchar(40) not null comment '题目名称',
	user_id varchar(40) not null comment '用户Id',
	userName varchar(40) comment '用户名',
	option_id varchar(40) not null comment '选项Id',
	option_ordinal varchar(40) not null comment '选项序号{ABCD/1234}',
	option_name varchar(100) not null comment '选项名称{答案}',
	create_time datetime not null comment '创建时间',
	update_time datetime not null comment '修改时间',
	state bool not null comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '选项表';

create table t_award(
	id varchar(40) primary key,
	name varchar(50) not null comment '奖品名称',
	count int not null comment '总数量',
	residue_count int not null comment '剩余数量',
	small_image varchar(255) comment '小图',
	big_image varchar(255) comment '大图',
	intro varchar(255) comment '奖品简介',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '奖品表';

alter table t_product add column gain_by_scale int comment '是否按投资比例';

alter table t_buy_product_record add column scale int comment '获得比例';
alter table t_buy_product_record add column cost_money int comment '消费金额';

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

alter table t_buy_product_record add column order_id varchar(40) comment '订单ID';