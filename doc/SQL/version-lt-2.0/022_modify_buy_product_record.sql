set names gbk;

use db_ghc;

alter table t_buy_product_record add column scale int comment '获得比例';
alter table t_buy_product_record add column cost_money int comment '消费金额';