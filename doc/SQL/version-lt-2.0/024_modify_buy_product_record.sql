set names gbk;

use db_ghc;

alter table t_buy_product_record add column order_id varchar(40) comment '订单ID';