use db_ghc;

set names gbk;

alter table t_product add column income_type int comment '收益类型{1.固定时间收益,2.认购成功后立即开始收益}';
alter table t_product add column income_days int comment '收益天数';
alter table t_product add column use_integral_type bigint comment '可0用金币类型,为空时都可用';
alter table t_user_invest add column income_type int comment '收益类型';
alter table t_user_invest add column income_days int comment '收益时间';

update t_product set income_type = 1;
update t_product set use_integral_type = 0;
update t_user_invest set income_type = 1;

alter table t_product modify column income_start_time datetime null; 
alter table t_product modify column income_end_time datetime null; 