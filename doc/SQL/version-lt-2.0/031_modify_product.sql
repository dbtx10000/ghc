set names gbk;

use db_ghc;

alter table t_product add column can_use_coupon int comment '是否可使用代金券';

update t_product set can_use_coupon = 1;