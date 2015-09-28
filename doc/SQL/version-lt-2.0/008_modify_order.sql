set names gbk;

use db_ghc;

alter table t_order add column use_integral int comment '抵扣使用积分数';
alter table t_order add column source_id varchar(5000) comment '积分使用来源ID,多个用逗号分隔';

update t_order set use_integral = 0;