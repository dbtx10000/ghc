set names gbk;

use db_ghc;

alter table t_user_integral add column sell_integral int comment '剩余可用积分数';
alter table t_user_integral add column vaild_end_time datetime comment '有效期结束时间';

update t_user_integral set sell_integral = integral;
update t_user_integral set vaild_end_time = date_add(create_time, interval 3 month);