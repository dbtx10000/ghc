set names gbk;

use db_ghc;

alter table t_order add column pay_no varchar(40) comment '支付号';
