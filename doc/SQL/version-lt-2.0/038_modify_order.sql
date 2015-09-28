set names gbk;

use db_ghc;

alter table t_order add column product_type int not null comment '产品类型1.普通产品,2.特权本金';
alter table t_order add column actual_money int comment '实际支付金额';

update t_order set product_type = 1;
update t_order set actual_money = invest_money;
