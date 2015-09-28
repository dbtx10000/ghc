create table t_game(
	id varchar(40) primary key,
	product_id varchar(1000) not null comment '产品Id',
    name varchar(500) comment '产品名称',
    start_time datetime comment '开始时间',
    end_time datetime comment '结束时间',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '游戏表';

create table t_game_buy_record(
	id varchar(40) primary key,
	user_id varchar(40) not null comment '用户Id',
	product_id varchar(40) not null comment '产品ID',
	order_id varchar(40) comment '订单ID',
	status int not null comment '使用状态{0.未使用,1.已使用}',
	create_time datetime not null comment '创建时间',
	update_time datetime not null comment '修改时间',
	state bool not null comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '购买产品记录表{游戏}';

create table t_game_record(
	id varchar(40) primary key,
	game_id varchar(40) comment '游戏Id',
    user_id varchar(40) comment '用户Id',
	user_account varchar(40) comment '用户账号',
	user_name varchar(40) comment '用户姓名',
	user_image varchar(500) comment '用户头像',
	score int comment '分数',
	share_sn varchar(40) comment '分享凭证',
	create_time datetime not null comment '创建时间',
	update_time datetime not null comment '修改时间',
	state bool not null comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '游戏记录表';

create table t_friend_game_record(
	id varchar(40) primary key,
	share_sn varchar(40) comment '游戏分享凭证',
	wxnickname varchar(40) comment '微信昵称',
	head_image varchar(255) comment '用户头像',
	openid varchar(40) comment 'WX-openid',
	score int comment '分数',
	create_time datetime not null comment '创建时间',
	update_time datetime not null comment '修改时间',
	state bool not null comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '朋友的游戏记录表';