-- Basic Model
-- LD.HU
-- 2014-12-20

set names gbk;

drop database db_ghc;

create database db_ghc character set utf8 collate utf8_general_ci;

use db_ghc;

create table t_manager (
	id varchar(40) primary key,
	code varchar(20) not null comment '管理编号',
	username varchar(20) not null comment '登录名',
	password varchar(40) not null comment '登录密码{用SHA1加密}',
	linkman varchar(20) not null comment '联系人姓名',
	telephone varchar(20) not null comment '联系电话',
	status int not null comment '状态{1.正常，2.禁用}',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '管理表';

insert into t_manager(id,code,username,password,linkman,telephone,status,create_user,create_time,update_user,update_time,state) values('c4ca4238a0b923820dcc509a6f75849b','admin','admin','c4ca4238a0b923820dcc509a6f75849b','admin','0000-00000000',1,'c4ca4238a0b923820dcc509a6f75849b',now(),'c4ca4238a0b923820dcc509a6f75849b',now(),1);

create table t_sms (
	id bigint primary key auto_increment,
	type int not null comment '1:注册，2:找回密码，3:支付密码修改',
	verify_code varchar(10) not null comment '验证码',
	mobile varchar(20) not null comment '手机号',
	status int not null comment '状态{0.未使用，1.已使用}',
	token varchar(100) not null  comment '验证成功 返回TOKEN 否则返回空',
	exceed_time datetime not null comment '过期时间',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '短信验证码表';

create table t_article(
	id bigint primary key auto_increment,
	category_id bigint comment '分类ID',
	title varchar(100) comment '标题',
	type int comment '图文类型：{1.外链,2.图文}',
	description varchar(255) comment '简介',
	pic_url varchar(255) comment '图文封面',
	url varchar(255) comment '链接',
	detail text comment '详细图文',
	weight bigint comment '排序',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '文章表';