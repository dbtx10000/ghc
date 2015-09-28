set names gbk;

use db_ghc;

alter table t_product add column subscribe_money int comment '认购金额';
alter table t_product add column actual_pay_money int comment '实际支付';

update t_product set subscribe_money = 10000, actual_pay_money = 1 where type = 2;