set names gbk;

use db_ghc;

alter table t_product add column pay_type int comment '支付类型  是否仅线上支付{0.否 1.是 }';

update t_product set pay_type = 0 where type=1;

update t_product set pay_type = 1 where type=2;

alter table t_order add column online_pay int comment '是否仅为线上支付';

update t_order set online_pay = 1;