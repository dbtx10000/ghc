use db_ghc;

set names gbk;

create table t_integral_type(
	id bigint primary key auto_increment,
	name varchar(100) comment '类型名称',
	type int comment '类型{1.固定的日期内有效,2.领取后一段时间内有效}',
	valid_start_time datetime comment '有效期开始时间(type=1的时候使用)',
	valid_end_time datetime comment '有效期结束时间(type=1的时候使用)',
	time int comment '时间数量',
	unit int comment '单位{1.时,2.天,3.月}',
	create_time datetime not null comment '创建时间',
	update_time datetime not null comment '修改时间',
	state bool not null comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '积分类型';

insert into t_integral_type(id,name,type,valid_start_time,valid_end_time,time,unit,create_time,update_time,state) values(1,'普通金币',2,null,null,3,3,now(),now(),1);
insert into t_integral_type(id,name,type,valid_start_time,valid_end_time,time,unit,create_time,update_time,state) values(2,'畅想金币',2,null,null,2,2,now(),now(),1);

create table t_red_package_event(
	id varchar(40) primary key,
	name varchar(100) comment '红包活动名称',
	source_type int comment '来源类型{1.系统分享,2.购买产品}',
	source_id varchar(40) comment '来源ID(source_type=2时使用)',
	user_id varchar(40) comment '发红包用户ID(source_type!=1时使用)',
	type int comment '红包活动类型{1.数量不限,2.数量有限,3.导入红包}',
	total_nums int comment '红包数量(type=2时使用)',
	goget_nums int comment '领取数量(0)',
	total_integrals int comment '总积分数(type=2时使用)',
	goget_integrals int comment '领取积分(0)',
	integral_type_id bigint comment '积分类型ID(type=1|2时使用)',
	min_integral int comment '积分最小数(type=1|2时使用)',
	max_integral int comment '积分最大数(type=1|2时使用)',
	start_time datetime comment '开始时间,开始时间为空时表示当前立即开始',
	end_time datetime comment '结束时间,结束时间为空时表示不受时间限制',
	status int comment '活动状态{1.上线(开启),2.下线(关闭)}',
	create_time datetime not null comment '创建时间',
	update_time datetime not null comment '修改时间',
	state bool not null comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '红包活动';

alter table t_user_integral add column integral_type_id bigint default 1 comment '金币类型ID';
update t_user_integral set integral_type_id = 1;

create table t_red_package_record(
	id varchar(40) primary key,
    user_id varchar(40) comment '用户Id',
	user_account varchar(40) comment '用户账号',
	user_name varchar(40) comment '用户姓名',
	user_image varchar(500) comment '用户头像',
	source_id varchar(40) comment '红包来源Id',
	source_name varchar(40) comment '红包来源名称',
	integral int not null comment '金币数量',
	create_time datetime not null comment '创建时间',
	update_time datetime not null comment '修改时间',
	state bool not null comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '红包记录表';