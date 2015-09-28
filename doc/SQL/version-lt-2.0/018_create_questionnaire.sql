create table t_questionnaire(
	id varchar(40) primary key,
	title varchar(40) not null comment '问卷标题',
	image varchar(150)  comment 'logo图片',
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