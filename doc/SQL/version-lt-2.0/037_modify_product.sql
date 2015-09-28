set names gbk;

use db_ghc;

alter table t_product add column type int comment '产品类型{1.普通产品  2. 特权本金}';

update t_product set type = 1;