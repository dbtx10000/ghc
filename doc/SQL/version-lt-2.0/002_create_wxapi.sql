create table t_wxapi_reply (
	id bigint primary key auto_increment,
	tags varchar(255) comment '关键字',
	mode int comment '回复模式{1.关注回复,2.无应答回复,3.自定义回复}',
	type int comment '消息类型{1.文本,2.图片,3.语音,4.视频,5.音乐,6.图文}',
	news_number int comment '多图文的条数',
	query_count int comment '查询次数',
	txt varchar(255) comment '文本内容',
	url varchar(255) comment '多媒体文件路径',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '微信回复表';

insert into t_wxapi_reply(id,mode,type,news_number,query_count,create_user,create_time,update_user,update_time,state) values(1,1,1,0,0,'c4ca4238a0b923820dcc509a6f75849b',now(),'c4ca4238a0b923820dcc509a6f75849b',now(),1);
insert into t_wxapi_reply(id,mode,type,news_number,query_count,create_user,create_time,update_user,update_time,state) values(2,2,1,0,0,'c4ca4238a0b923820dcc509a6f75849b',now(),'c4ca4238a0b923820dcc509a6f75849b',now(),1);

create table t_wxapi_reply_news (
	id bigint primary key auto_increment,
	reply_id bigint comment '回复id',
	title varchar(100) comment '标题',
	type int comment '图文类型：{1.外链,2.图文}',
	description varchar(255) comment '图文简介',
	pic_url varchar(255) comment '图文封面',
	url varchar(255) comment '图片链接',
	detail text comment '详细图文',
	weight bigint comment '排序',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '微信回复多图文明细';

create table t_wxapi_chats (
	id bigint primary key auto_increment,
	
	to_user_name varchar(100) comment '接受方',
	from_user_name varchar(100) comment '发送方',
	wx_create_time bigint comment '消息服务创建时间',
	msg_type varchar(100) comment 'text,image,voice,video,location,link,event',    
	msg_id varchar(100) comment '消息id',  

	media_id varchar(100) comment '多媒体id',    
	thumb_media_id varchar(100) comment 'video,视频消息缩略图的媒体id',
	content varchar(255) comment 'text，文本内容 或 voice：recognition 语音的结果',
	pic_url varchar(255) comment 'image：图片url', 
	format varchar(100) comment 'voicd 语音格式，如amr，speex等',
	recognition varchar(255) comment '语音识别结果',
  
	location_x varchar(100) comment 'location：维度,event location：latitude',
	location_y varchar(100) comment 'location：经度,event location：longitude',
	scale varchar(100) comment 'location：地图缩放大小,event location：precision',  
	label varchar(100) comment 'location：地理位置信息',  
  
	title varchar(100) comment 'link：标题',
	description varchar(255) comment 'link：描述',
	url varchar(255) comment 'link：url',
	
	event varchar(100) comment 'event,subscribe,unsubscribe,location,click,view',
	event_key varchar(100) comment 'event,event的key',  
	ticket varchar(100) comment 'event,二维码的ticket',

	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '微信聊天记录表';

create table t_wxapi_menus (
	id bigint primary key auto_increment,
	level int comment '级别',
	pid bigint comment '父ID',
	name varchar(100) comment '菜单名',
	type varchar(100) comment '类click/view',
	url varchar(255) comment '链接',
	_key varchar(100) comment '微信key,对应reply的tags',
	weight bigint comment '排序',
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '微信菜单';

create table t_wxapi_union (
	id bigint primary key auto_increment,
	openid varchar(50) comment '',
	subscribe int comment '',
	nickname varchar(50) comment '',
	sex int comment '',
	language varchar(50) comment '',
	city varchar(50) comment '',
	province varchar(50) comment '',
	country varchar(50) comment '',
	headimgurl varchar(150) comment '',
	subscribe_time bigint comment '',
	unionid varchar(50) comment '',
	
	create_user varchar(40) comment '创建用户',
	create_time datetime comment '创建时间',
	update_user varchar(40) comment '修改用户',
	update_time datetime comment '修改时间',
	state bool comment '记录状态{true/false}'
) character set utf8 collate utf8_general_ci comment '微信UNION用户信息';