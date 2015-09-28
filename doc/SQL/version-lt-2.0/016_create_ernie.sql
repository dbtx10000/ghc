create table t_jackpot(
	id varchar(40) primary key,
	jackpot_type int not null comment '奖池类型1:红包奖池,2.抢购奖池',
	relate_id varchar(40) not null comment '关联ID',
	relate_type int not null comment '关联类型1:红包2:奖品',
	count int not null comment '数量',
	win_count int not null comment '已中奖数量',
	integral int  comment '抵扣积分',
	basic int not null comment '基数',
	lat double comment '纬度',
	lng double comment '经度',
	address varchar(50) comment '地址',
	hot bool not null comment '是否推荐',
	create_time datetime not null comment '创建时间',
	update_time datetime not null comment '修改时间',
	state bool not null comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '奖池表';


create table t_winning_record(
	id varchar(40) primary key,
	user_id varchar(40) not null comment '用户ID',
	relate_id varchar(40) not null comment '关联ID',
	relate_type int not null comment '关联类型1:红包2:奖品',
	relate_name varchar(50) not null comment '关联红包/抢购名称/广告/图文',
	sncode varchar(40) comment 'SN码',
	lng double comment '经度',
	lat double comment '纬度',
	address varchar(50) comment '地址',
	create_time datetime not null comment '创建时间',
	update_time datetime not null comment '修改时间',
	state bool not null comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '中奖记录表';


create table t_red_packet(
	id varchar(40) primary key,
	name varchar(50) comment '红包标题',
	all_count int not null comment '投入总数',
	residue_count int not null comment '剩余数',
	integral int not null comment '积分',
	image varchar(255) comment '红包图片',
	create_time datetime not null comment '创建时间',
	update_time datetime not null comment '修改时间',
	state bool not null comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '红包表';

